import re
import json
import os
import pyswip, ctypes

root = os.path.abspath(os.path.dirname(__file__))

class PrologMT(pyswip.Prolog):
    """Multi-threaded (one-to-one) pyswip.Prolog ad-hoc reimpl"""

    _swipl = pyswip.core._lib

    PL_thread_self = _swipl.PL_thread_self
    PL_thread_self.restype = ctypes.c_int

    PL_thread_attach_engine = _swipl.PL_thread_attach_engine
    PL_thread_attach_engine.argtypes = [ctypes.c_void_p]
    PL_thread_attach_engine.restype = ctypes.c_int

    @classmethod
    def _init_prolog_thread(cls):
        pengine_id = cls.PL_thread_self()
        if pengine_id == -1:
            pengine_id = cls.PL_thread_attach_engine(None)
            print("{INFO} attach pengine to thread: %d" % pengine_id)
        if pengine_id == -1:
            raise pyswip.prolog.PrologError(
                "Unable to attach new Prolog engine to the thread"
            )
        elif pengine_id == -2:
            print("{WARN} Single-threaded swipl build, beware!")

    class _QueryWrapper(pyswip.Prolog._QueryWrapper):
        def __call__(self, *args, **kwargs):
            PrologMT._init_prolog_thread()
            return super().__call__(*args, **kwargs)


def source_path(directive, implementation):
    dict = {
        "pl": "polish_implementation",
        "it": "italian_implementation",
        "nl": "dutch_implementation",
        "bg": "bulgarian_implementation",
        "dir": directive,
        "directive": directive,
    }

    return os.path.join(
        root, f"prolog/directives/{directive}/{dict[implementation]}.pl"
    ).replace("\\", "/")


def nationality(law):
    element = {
        "_it": "it",
        "_pl": "pl",
        "_nl": "nl",
        "_bg": "bg",
        "": "directive",
    }
    return next((y for x, y in element.items() if x in law))


def _generate_interpreter():
    def _add_directive(swipl, root, directive, implementations):
        def _impl(directive, implementation):

            module = source_path(directive, implementation)
            next(swipl.query(f"use_module('{module}',[])"))

            return (
                implementation,
                directive
                if implementation == "dir"
                else directive + "_" + implementation,
            )

        return [_impl(directive, "dir")] + [
            _impl(directive, x) for x in implementations
        ]

    swipl = PrologMT()
    # root = os.path.abspath(os.path.join(os.path.dirname(__file__), os.pardir))
    swipl.consult(os.path.join(root, "prolog/my_init.pl").replace("\\", "/"))

    return (
        swipl,
        _add_directive(swipl, root, "directive_2010_64", ["it", "nl", "pl", "bg"])
        # + _add_directive(swipl, root, "directive_2016_800", ["it", "nl", "pl", "bg"])
        + _add_directive(swipl, root, "directive_2012_13", ["it", "nl", "pl", "bg"])
        + _add_directive(swipl, root, "directive_2016_343", ["it", "nl", "pl", "bg"])
        + _add_directive(swipl, root, "directive_2013_48", ["it", "nl", "pl", "bg"])
        # + _add_directive(swipl, root, "directive_2016_1919", ["it", "nl", "pl", "bg"]),
    )


_swipl, _mappings = _generate_interpreter()


def _json_clean_explanation(expl):
    def _clean_explanation(tmp_list):
        log = []
        for tmp in tmp_list:
            if isinstance(tmp, list):
                log.append(_clean_explanation(tmp))
            else:
                tmp = re.sub("Variable\(\d+\)", "_", str(tmp))
                if (
                    tmp != "system_predicate"
                    and not tmp.startswith("auxiliary_right_scope")
                    and not tmp.startswith("right_property_scope")
                ):
                    log.append(tmp)
        return log

    return json.dumps(_clean_explanation(expl))


def _with_facts(execute, facts, module):
    for item in facts:
        _swipl.assertz(module + ":" + item)

    result = execute()

    for item in facts:
        _swipl.retractall(module + ":" + item)

    return result


def _solve(query):
    return list(_swipl.query(query))


def _with_explanation(module, query, explanation=True):
    return f"{module}:explain({query}, Expl)" if explanation else f"{module}:{query}"


def right_to(
    person,
    facts,
    laws,
    modules,
    right,
    opt,
    explanation,
):
    modules = [m if l == "dir" else f"{m}_{l}" for m in modules for l in laws]
    return set(
        (
            law,
            module,
            x["Art"],
            x["Opt"] if opt == "Opt" else opt,
            x["Right"] if right == "Right" else right,
            _json_clean_explanation(x["Expl"]) if explanation else "",
        )
        for law, module in _mappings
        if law in laws and module in modules
        for x in _with_facts(
            lambda: _solve(
                _with_explanation(
                    module,
                    f"has_right({right}, {law}, Art, {person}, {opt})",
                    explanation,
                )
            ),
            facts,
            module
        )
    )

def generate_response(personId, facts, laws, modules, right="Right", opt="Opt", abduce=False):
    return [
        {
            "right": item[4],
            "law": item[1],
            "article": item[2],
            "option": item[3],
            "explanation": item[5] if not item[5] else json.loads(item[5])
        }
        for item in right_to(
            personId,
            facts + (["abd_enabled"] if abduce else []),
            laws=laws,
            modules=modules,
            right=right,
            opt=opt,
            explanation=True,
        )
    ]

def prettify_response(response, facts):

    def _get_article_text(type, law, article):
        directive = law[:-3] if not law[-1].isdigit() else law
        path = source_path(directive, nationality(law))
        with open(path, "r") as pl_src:
            law_text = pl_src.read()
            res = re.search(
                type
                + r"\(_"
                + article
                + ".+\n%\n%\s?([^%]+?(?=%))([\S\s%\n]+?)(?=\n[a-z]|\$)(\$[\s\S]*?\$)?",
                law_text,
            )
            if res is not None:
                title = res.group(1).replace("%", "")
                text = res.group(2).replace("%", " ")
                comment = (res.group(3) or "").replace("%", " ").replace("$", "")
                return [title, text, comment]
        return ""

    def _to_html_tree(tree, facts):
        if tree == "":
            return ""
        log = "<ul>"
        for x in tree:
            if isinstance(x, list) and not x:
                continue
            if isinstance(x, list):
                log += _to_html_tree(x, facts)
            elif x.startswith(":(user"):
                log += (
                    "<li>"
                    + re.search(r":\(user, (.+)\)", x).group(1)
                    + " <b>[FACT]</b></li>"
                )
            elif x in facts:
                log += "<li>" + x + " <b>[FACT]</b></li>"
            elif x.startswith("abduced"):
                log += (
                    "<li>"
                    + re.search(r"abduced\((.+)\)", x).group(1)
                    + " <b>[ABDUCED]</b></li>"
                )
            else:
                log += "<li>" + x + "</li>"
        log += "</ul>"
        return log

    def _extract_facts(explanation):
        if explanation == "":
            return []
        temp = []
        for x in explanation:
            if isinstance(x, list) and not x:
                continue
            if isinstance(x, list):
                temp += _extract_facts(x)
            elif x in facts:
                temp += [x]
        return temp

    def _extract_abduced_facts(explanation):
        if explanation == "":
            return []
        temp = []
        for x in explanation:
            if isinstance(x, list) and not x:
                continue
            if isinstance(x, list):
                temp += _extract_abduced_facts(x)
            elif x.startswith("abduced"):
                temp += [re.search(r"abduced\((.+)\)", x).group(1)]
        return temp

    def _prettify(elem, type, law):
        elem["article_text"] = _get_article_text(type, law, elem["article"])
        elem["abduced"] = _extract_abduced_facts(elem["explanation"])
        elem["facts"] = _extract_facts(elem["explanation"])
        elem["explanation"] = _to_html_tree(elem["explanation"], facts)
        return elem

    def _to_theory(elem):

        modifier = lambda x : "-" if x ==  "directive" else "="

        import random

        for law, rights in elem.items():
            for y in rights:
              y[
                  "arg_rule"
              ] = f"f{random.randint(1, 10000)} :{modifier(law)}> right({law}, {y['article']}, {y['right']}, {y['option']}, {sorted(set(y['facts'] + y['abduced']))}).".replace(
                  "'", ""
              )

        return elem

    import copy

    pretty = [copy.deepcopy(dict) for dict in response]

    for elem in pretty:
        _prettify(elem, "has_right", elem["law"])

    group = {}
    for item in pretty:
        group.setdefault(item["right"], []).append(item)
    for key, value in group.items():
        national_group = {}
        for item in value:
            national_group.setdefault(nationality(item["law"]), []).append(item)
        group[key] = _to_theory(national_group)

    return group

def query(personId, facts, laws, modules, right="Right", opt="Opt", abduce=False):
    f = facts + [f"person_made_aware({personId}, personStatus)", f"proceeding_status({personId}, started)", f"proceeding_type({personId}, criminal)"]
    f = list(set([x.replace(".", "").strip() for x in f]))
    response = generate_response(personId, f, laws, modules, right=right, opt=opt, abduce=abduce)
    return prettify_response(response, f)

if __name__ == "__main__":

    def test_facts():
        return [
            "proceeding_type(personId, criminal)",
            "person_status(personId, accused)",
            "person_made_aware(personId, personStatus)",
            "proceeding_status(personId, started)",
            "person_understands(personId, unknown)",
            "person_speaks(personId, unknown)",
            "proceeding_language(personId, langUnknown)"
        ]

    def tt():
        return [
            "person_status(mario, accused)",
            "person_nationality(mario, italian)",
            "proceeding_country(mario, france)",
            "proceeding_matter(mario, questioning)",
            "person_made_aware(mario, personStatus)",
            "person_status(mario, deprived_of_liberty)",
            "proceeding_status(mario, started)"
        ]

    def n():
        return ['proceeding_type(alessandro, criminal)', 'person_status(alessandro, suspect)', 'person_made_aware(alessandro, personStatus)', 'person_status(alessandro, deprived_of_liberty)', "proceeding_country(alessandro, 'netherlands')", "person_nationality(alessandro, 'italy')", 'person_nominate(alessandro, giulio)']

    #facts, response = generate_response("personId", tt(), ["dir", "it"], right="right_to_appear", abduce=True)
    facts, response = generate_response("alessandro", n(), ["dir"], ["directive_2013_48"])
    pretty = prettify_response(response, facts)

    for k, i in pretty.items():
        print(k)
        print(i)
