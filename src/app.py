import re
import streamlit as st
from groq import Groq
import time

from langchain.chains import LLMChain
from langchain_core.prompts import (
    ChatPromptTemplate,
    HumanMessagePromptTemplate,
    MessagesPlaceholder,
)
from langchain_core.messages import SystemMessage
from langchain.chains.conversation.memory import ConversationBufferWindowMemory, ConversationSummaryBufferMemory
from langchain_groq import ChatGroq

import input_facts
from swi_interface import query
from argumentation.arg_interface import get_full_theory, run_reasoner


def prompt_model(prompt, system="", model="llama3-70b-8192", temperature=0.0):
  client = Groq(
      api_key='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',
  )

  while True:
    try:
      completion = client.chat.completions.create(
        model=model,
        messages=[
            {
                "role": "system",
                "content": system
            },
            {
                "role": "user",
                "content": prompt
            }
        ],
        temperature=temperature,
        top_p=1,
        stream=True,
        stop=None,
      )

      return "".join([chunk.choices[0].delta.content or "" for chunk in completion])
    except Exception as e:
      time.sleep(3)


def facts_hash(context):
  return hash(f"{context["facts"]}")


def target_hash(context):
  return hash(f"{context["right_target"]} - {context["country_target"]} - {context["opt_target"]} - {context["facts"]}")


def pretty_rights(context):
   if facts_hash(context) not in context["rights"]:
      return ""
   return [i["article"] + " - " + i["right"] + " - " + i["option"] for _, v in context["rights"][facts_hash(context)].items() for i in v["directive"]]


def filter_target(rights, context):
   if context["right_target"] not in rights:
      return {}
   return [x for _, v in rights[context["right_target"]].items() for x in v if x["option"] == context["opt_target"]]


def filter_target_inverse(rights, context):
   if context["right_target"] not in rights:
      return {}
   return [x for _, v in rights[context["right_target"]].items() for x in v if x["option"] != context["opt_target"]]

def natural_language(rights):
   return "\n\nHere is the next right:\n\n".join([x["pretty_explanation"] for x in rights])

def select_prompt(context):

    return f"""
      Follow all instructions of Phase 1, before Phase 2.

      Phase 1: Interacting with the user.
      Assist the user in building a comprehensive case description by extracting relevant Prolog facts, while conversing with the user.
      There are certain facts which are essential and must always apply, unless explicitly stated otherwise: '''{input_facts.facts}'''.

      Consider also if any of the following conditions may be relevant :'''{input_facts.dir_facts[context["directive_target"]]} {input_facts.national_facts[context["directive_target"]][context["country_target"]]}'''.
      Evaluate whether these facts can reasonably apply to the given scenario.
      Avoid asking yes or no questions. Just ask a few questions on the state of the scenario.

      Respect the following instructions:
      - DO NOT tell the user what rights may apply.
      - DO NOT ask similar questions more than once.

      These are the facts the user provided so far:

      {context["facts"]}

      After some questions ask the users if they wants to know what rights they have.

    """ + (f"""
      Phase 2: Presenting the rights computed by the symbolic engine.

      Rights granted at the European level:

      {"\n".join(pretty_rights(context))}

      Format of the answer:
      - Tell the user the list of computed rights in natural language.
      - Ensure that each main right is matched to its corresponding options and article. The same right can have more than one option and article.
      - The answer should have each main right, followed by a brief reference to the article. Finally, add the option.

      Respect these instructions:
      DO NOT invent any rights, only present what has been computed.
      Present all rights.

      If no rights apply, ask the user if more details should be provided to the scenario.
      If rights are granted, ask if the user wants to know more details any of these rights.

    """ if context["state"] == "2" else "") + (f"""

      Phase 3: Explaining the Rights

      These are the details on {context["right_target"]} - {context["opt_target"]}:

      {natural_language(filter_target(context["rights"][facts_hash(context)], context))}

      Respect this instruction:
      DO NOT invent any rights, only present what has been computed.

      Ask if the user wants to know about the conformity evaluation with the European country about any right.

      Questions on conformity can only be answered based on the following text. Do not add anything.

      {context["pretty_arguments"][target_hash(context)]}

      Following is the list of rights for different options in the national implementation:

      {natural_language(filter_target_inverse(context["target"][target_hash(context)], context))}

      If there is no list, tell the user no rights are granted in the specific EU state.
      If there are rights, tell the user the list of national rights in natural language.

      These are specific and additional facts required by the national implementation: '''{context["suggestions"]}'''.
      If there are no facts, tell the user such.
      If there's more than one fact, tell the user what facts are needed for the national law to apply in this specific scenario.
      Provide the user a brief explanation of these facts in natural language.

    """ if context["right_target"] and target_hash(context) in context["pretty_arguments"] else "")


def select_state(messages, context):
    res = prompt_model(f"""
        In the context of a system assisting a user in building a comprehensive case description and providing info on the rights applicable to the case.
        According to the following input, what does the user want to do?

        0. None of the following;
        1. Provide new details to the scenario;
        2. Know which rights are deducible from her scenario;
        3. Know about one of this specific rights: {pretty_rights(context)}

        Reply "0" if 0, "1" if 1, "2" if 2, and "3 - article - right - option (from the list)" if 3.
        Do not include anything else in your output.

        {messages[-2:]}
    """)

    print("Selecting State:")
    print(res)
    print()

    context["right_target"] = [x.strip() for x in res.split("-")][2] if "3" in res else context["right_target"]
    context["opt_target"] = [x.strip() for x in res.split("-")][3] if "3" in res else context["opt_target"]
    raw_state = [x.strip() for x in res.split("-")][0]
    context["state"] = "0" if "0" in raw_state else "1" if "1" in raw_state else "2" if "2" in raw_state else "3"


def run_argumentation(context):
    if context["right_target"] and context["country_target"] and target_hash(context) not in context["arguments"]:
      rules = [x["arg_rule"] for x in filter_target(context["rights"][facts_hash(context)], context)] + [x["arg_rule"] for x in filter_target(context["target"][target_hash(context)], context)]
      theory = get_full_theory("\n".join(rules), [context["country_target"]])
      context["arguments"][target_hash(context)] = run_reasoner(theory)
      context["pretty_arguments"][target_hash(context)] = prompt_model(f"""
        Arguments on conformity with national implementations [{context["country_target"]}]:

        {context["arguments"][target_hash(context)]}

        Arguments are either IN or OUT:
         - If IN they are accepted according to Dung's grounded semantics;
         - If OUT they are rejected according to Dung's grounded semantics;

        To extract the conformity analyze the IN arguments provided, ignore the OUT arguments.
        Read the IN arguments to define the level of conformity. For each right there is a list of conditions needed to grant that right.
        There are three levels of conformity:
          - if you read in the IN arguments ((conformity(COUNTRY, ART)) it means there is Full Conformity: The right and its conditions are identical between EU and national implementation.
          - if you read in the IN arguments ('-'(conformity(COUNTRY, ART)) it means there is No Conformity: That specific right is not granted under the national implementation.
          - if you read in the IN arguments (partial_conformity(COUNTRY, ART)) it means there is Partial Conformity: The right is granted under national law, but under different conditions than the european source.

        If there's full conformity, tell the user the right is granted and perfectly recognised under the national law.
        If there's no conformity, tell the user the right is not granted under national law. Similar rights may apply, but its not relevant to the conformity.
        If there's partial conformity, evaluate the conditions required by the national implementation of the EU and National rights, and analyze the key differences between the two, and the option of the right.

        Details on national implementation:

        {filter_target(context["target"][target_hash(context)], context)}

        Details on european implementation:

        {filter_target(context["rights"][facts_hash(context)], context)}

        Explain if there is conformity and why.
      """)
      print("Argumentation result:")
      print(context["arguments"][target_hash(context)])
      print()
      print("Argumentation parsed:")
      print(context["pretty_arguments"][target_hash(context)])
      print()


def extract_facts(user_text, context):
  def _extract_code(completion):
    from mdextractor import extract_md_blocks
    blocks = extract_md_blocks(completion)
    return blocks[0] if blocks else ""

  res = prompt_model(f"""
    Assist the user in building a comprehensive case description by extracting relevant Prolog facts.

    Consider if any of the following conditions may be relevant:
    '''
    {input_facts.facts}
    {input_facts.dir_facts[context["directive_target"]]}
    {input_facts.national_facts[context["directive_target"]][context["country_target"]]}
    '''

    Evaluate whether these facts can reasonably apply to the given scenario.

    Respect the following instructions:
    - DO NOT create new facts.
    - If the input is not relevant do not extract any fact.

    Format of the output:
    - INCLUDE THE EXTRACTED PROLOG FACTS inside a single markdown block.
    - DO NOT create more than one block. Keep all facts in a single one.
    - DO NOT put comments inside the markdown block.
    - All variables must be lower letter for a fact to be valid.

    {"PersonId is " + context["person_id"] + "." if context["person_id"] else ""}

    Here is the user input:

    {user_text}
  """)

  print(user_text)
  print()

  return [x for x in [y.strip().split("%")[0] for y in _extract_code(res).replace(".", "").split("\n")] if x]


def add_facts(messages, context):
  extr = extract_facts("\n".join([x["content"] for x in messages if x["role"] == "user"]), context)
  if set(extr) == set(context["facts"]):
    return False
  context["facts"] = list(set(extr))
  id = re.search(r"person_status\((.+),", "\n".join(context["facts"]))
  context["person_id"] = id.group(1).strip() if id else context["person_id"]
  print(context["person_id"])
  print(context["facts"])
  print()
  return True


def prettify_prolog(input):
  def _prettify(elem):
    return prompt_model(f"""
      Prolog Tree:
      {elem}

      You have been provided a Prolog inference tree using a legal norm in a specific case (Prolog Tree).
      Each main right (right:) has a corresponding legal source (law) and article, and additional information (option).
      Ensure that each right is matched to its corresponding option and article. The same right can have more than one option and article.

      Provide the following info according to the given structure:

      Summary: simplified text of the legal norm. Use everyday langaguage with a serious register. Present the main right. Then explain in a concise manner the legal source and article. Finally, refer to the option.
      What Rights do You Have: what rights do you have according to the Prolog explanation;
      Why do You Have Them: inference steps and reasoning that led to the the rights. Use all the Prolog terms in the explanation explicitly referencing the original Prolog when needed.

      Use enumerations in the 'What Rights do You Have' and 'Why do You Have Them' sections if needed.
    """)

  for _, v in input.items():
    for _, r in v.items():
       for x in r:
          x["pretty_explanation"] = _prettify(x)

def run_dir_prolog(context):
  if facts_hash(context) in context["rights"]:
     return
  try:
    context["rights"][facts_hash(context)] = query(context["person_id"], context["facts"], ["dir"], [context["directive_target"]])
    prettify_prolog(context["rights"][facts_hash(context)])
    print("Dir rights:")
    print(context["rights"][facts_hash(context)])
    print()
  except Exception as e:
    print(e)


def run_national_prolog(context):
  if target_hash(context) in context["target"]:
     return
  try:
    context["target"][target_hash(context)] = query(context["person_id"], context["facts"], [context["country_target"]], [context["directive_target"]], right=context["right_target"])
    prettify_prolog(context["target"][target_hash(context)])
    print("National result:")
    print(context["target"][target_hash(context)])
    print()
  except Exception as e:
    print(e)

def suggest_facts(context):
  try:
      response = query(context["person_id"], context["facts"], [context["country_target"]], [context["directive_target"]], right=context["right_target"], abduce=True)
      context["suggestions"] = set([y for _, v in response[context["right_target"]].items() for x in v for y in x["abduced"]])
      print("Abduction result:")
      print(context["suggestions"])
      print()
  except Exception as e:
    print(e)


def llm_response(input_text, context, memory):
  return LLMChain(
      llm=memory.llm,
      prompt=ChatPromptTemplate.from_messages(
        [
            SystemMessage(content=select_prompt(context)),
            MessagesPlaceholder(variable_name="my_chat"),
            HumanMessagePromptTemplate.from_template("{human_input}")
        ]),
      verbose=False,
      memory=memory,
  ).predict(human_input=input_text)


def main():

    if "chat_message" not in st.session_state:
      st.session_state.context = {
        "state" : "1",
        "person_id" : "",
        "directive_target" : "",
        "facts" : [],
        "rights" : {},
        "country_target" : "",
        "right_target" : "",
        "opt_target" : "",
        "target" : {},
        "arguments" : {},
        "pretty_arguments" : {},
        "suggestions" : set()
      }
      st.session_state.chat_message = []
      # st.session_state.memory = ConversationBufferWindowMemory(k=3, memory_key="my_chat", return_messages=True)
      st.session_state.memory = ConversationSummaryBufferMemory(llm=ChatGroq(
          groq_api_key='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',
          model_name="llama3-70b-8192",
          temperature=0.5
      ), max_token_limit=2000, memory_key="my_chat", return_messages=True)

    dirs = ["directive_2010_64", "directive_2012_13", "directive_2016_343", "directive_2013_48"]
    selected_dir = st.sidebar.selectbox('Choose from the list the relevant directives: Directive 2010/64 on right to interpretation and translation; 2012/13 on the right to information, 2016/343 on the presumption of innocence; 2013/48 on the right of access to a lawyer', dirs)

    laws = ["it", "nl", "bg", "pl"]
    selected_law = st.sidebar.selectbox('Choose the country where the proceedings are taking place, therefore the applicable national law:', laws)

    st.sidebar.markdown(f"""
      ## Welcome to the Tutorial

      This is a simple tutorial on how to use the bot.

      ## How to use me:
      1. Describe the scenario;
      2. When you are satisfied of the scenario, ask me to provide the rights that apply to your scenario;
      3. To understand why a specific right apply, choose it from the list obtained from the previous step and ask me further details about it;
      4. To know whether the right recognised at the European level is also recogniesd an the national level, ask me furhter about the conformity of the national legislation.
      5. Ask me suggestions of potential facts or conditions that may be relevant in your case to have rights recognised

      ### Talk with me:
      To provide accurate advice, please provide the following details about the person involved in the criminal proceedings:

      1. Their **name**.
      2. The **proceeding language**.
      3. The **location** of the proceedings.
      4. Their **nationality**.
      5. Their **spoken language(s)**.
      6. Their **status** (e.g., suspect or accused).
      7. Whether they were **arrested/detained** by authorities.
      8. The **stage** of the proceedings (e.g., investigation, trial).
      9. Details of any **investigative events** (e.g., searches, interrogations).
      10. Any other **relevant information** about the case.

      Providing clear, complete information ensures tailored and effective legal guidance.
    """)

    for message in st.session_state.chat_message:
        with st.chat_message(message["role"]):
            st.markdown(message["content"])

    st.session_state.context["country_target"] = selected_law
    st.session_state.context["directive_target"] = selected_dir

    if user_question := st.chat_input("Describe your case:"):

        with st.chat_message("user"):
          st.markdown(user_question)

        st.session_state.chat_message.append({"role": "user", "content": user_question})

        select_state(st.session_state.chat_message, st.session_state.context)

        if st.session_state.context["state"] == "1":
          if add_facts(st.session_state.chat_message, st.session_state.context):
            run_dir_prolog(st.session_state.context)

        st.sidebar.markdown(f"## State: {st.session_state.context["state"]}")
        st.sidebar.markdown(f"""
          ## Extracted Facts:
          {"".join(["\n\n- **" + x + "**" for x in st.session_state.context["facts"]])}
        """)

        if st.session_state.context["state"] == "3":
          run_national_prolog(st.session_state.context)
          run_argumentation(st.session_state.context)
          suggest_facts(st.session_state.context)

        response = llm_response(user_question, st.session_state.context, st.session_state.memory)

        with st.chat_message("ai"):
          st.markdown(response)

        st.session_state.chat_message.append({"role": "ai", "content": response})

if __name__ == "__main__":
    main()
