:- module(directive_2010_64, [has_right/5, auxiliary_right/5, auxiliary_right_checked/5, right_property/5, right_property_checked/5, explain/2]).

:- include('./../../utils.pl').

has_right(Right, dir, Article, PersonId, Matter) :-
    once(directive_2010_64_applies(PersonId)),
    has_right(Article, PersonId, Right, Matter).

%auxiliary_right(Article, Reference, PersonId, Matter, Value, PersonTarget).

directive_2010_64_applies(PersonId) :-
    directive_2010_64_applies(art1_1, PersonId, proceedingData),
    directive_2010_64_applies(art1_2, PersonId, personalData).

%% directive_2010_64_applies(_art1_1, PersonId, _proceedingData)
%
% Article 1.1
%
% This Directive lays down rules concerning the right to
% interpretation and translation in criminal proceedings and
% proceedings for the execution of a European arrest warrant.

directive_2010_64_applies(art1_1, PersonId, proceedingData) :-
    (   proceeding_type(PersonId, criminal)
    ;   proceeding_type(PersonId, europeanArrestWarrant)
    ).

%% directive_2010_64_applies(_art1_2, PersonId, _personalData)
%
% Article 1.2
%
% The right referred to in paragraph 1 shall apply to persons
% from the time that they are made aware by the competent
% authorities of a Member State, by official notification or
% otherwise, that they are suspected or accused of having
% committed a criminal offence until the conclusion of the
% proceedings, which is understood to mean the final determination
% of the question whether they have committed the
% offence, including, where applicable, sentencing and the
% resolution of any appeal.
directive_2010_64_applies(art1_2, PersonId, personalData) :-
    (   person_status(PersonId, suspect)
    ;   person_status(PersonId, accused)
    ),
    person_made_aware(PersonId, personStatus),
    proceeding_status(PersonId, started),
    \+ proceeding_status(PersonId, concluded).

%% has_right(_art2_1, PersonId, _right_to_interpretation, _trial)
%
% Article 2.1
%
% Member States shall ensure that suspected or accused
% persons who do not speak or understand the language of the
% criminal proceedings concerned are provided, without delay,
% with interpretation during criminal proceedings before investigative
% and judicial authorities, including during police questioning,
% all court hearings and any necessary interim hearings.

has_right(art2_1, PersonId, right_to_interpretation, trial) :-
    proceeding_language(PersonId, Language),
    \+ person_language(PersonId, Language).

%% has_right(_art2_2, PersonId, _right_to_interpretation, _lawyer)
%
% Article 2.2
%
% Member States shall ensure that, where necessary for
% the purpose of safeguarding the fairness of the proceedings,
% interpretation is available for communication between suspected
% or accused persons and their legal counsel in direct connection
% with any questioning or hearing during the proceedings or with
% the lodging of an appeal or other procedural applications.

has_right(art2_2, PersonId, right_to_interpretation, lawyer):-
    lawyer_language(PersonId, Language),
    \+ person_language(PersonId, Language).

%% auxiliary_right(_art2_3, PersonId, _assistance, _vulnerablePersons)
%
% Article 2.3
%
% The right to interpretation under
% paragraphs 1 and 2 includes appropriate assistance for persons
% with hearing or speech impediments.

auxiliary_right_scope(art2_3, [art2_1, art2_2, art2_7]).

auxiliary_right(art2_3, PersonId, assistance, vulnerablePersons):-
    person_condition(PersonId, hearingSpeechImpediments).

%% right_property(_art2_4, PersonId, _nationalAuthority, _languageAssmessment)
%
% Article 2.4
%
% Member States shall ensure that a procedure or mechanism is in
% place to ascertain whether suspected or accused persons
% speak and understand the language of the criminal proceedings and
% whether they need the assistance of an interpreter.

right_property_scope(art2_4, [art2_1, art2_2, art2_7]).

right_property(art2_4, PersonId, nationalAuthority, languageAssmessment).

person_language(PersonId, Language):-
    right_property(_, A, nationalAuthority, languageAssmessment),
    person_language_verified_by(PersonId, Language, A).

%% auxiliary_right(_art2_5, PersonId, _remedy, _decision)
%
% Article 2.5
%
% Member States shall ensure that, in accordance with procedures in
% national law, suspected or accused persons have the right to challenge
% a decision finding that there is no need for interpretation and, when
% interpretation has been provided, the possibility to complain that the
% quality of the interpretation is not sufficient to safeguard the fairness
% of the proceedings.

auxiliary_right_scope(art2_5, [art2_1, art2_2, art2_7]).

auxiliary_right(art2_5, PersonId, remedy, decision) :-
    person_challenges_decision(PersonId, interpretation).

%% auxiliary_right(_art2_5, PersonId, _remedy, _quality)
%
% Article 2.5
%
% Member States shall ensure that, in accordance with procedures in
% national law, suspected or accused persons have the right to challenge
% a decision finding that there is no need for interpretation and, when
% interpretation has been provided, the possibility to complain that the
% quality of the interpretation is not sufficient to safeguard the fairness
% of the proceedings.

auxiliary_right(art2_5, PersonId, remedy, quality) :-
    quality_not_sufficient(PersonId, interpreter).

%% right_property(_art2_6, PersonId, _means, _technology)
%
% Article 2.6
%
% Where appropriate, communication technology such
% as videoconferencing, telephone or the Internet may be used, unless
% the physical presence of the interpreter is required in order to
% safeguard the fairness of the proceedings.

right_property_scope(art2_6, [art2_1, art2_2, art2_7]).

right_property(art2_6, PersonId, means, technology) :-
    \+ physical_presence_required(PersonId, interpreter, safeguard_fairness).

%% has_right(_art2_7, _PersonId, _right_to_interpretation, _europeanArrestWarrant)
%
% Article 2.7
%
% In proceedings for the execution of a European arrest warrant, the
% executing Member State shall ensure that its competent
% authorities provide persons subject to such proceedings who do not
% speak or understand the language of the proceedings with
% interpretation in accordance with this Article.

has_right(art2_7, PersonId, right_to_interpretation, europeanArrestWarrant):-
    proceeding_type(PersonId, europeanArrestWarrant),
    proceeding_language(PersonId, Language),
    \+ person_language(PersonId, Language).

%% has_right(_art3_1, PersonId, _right_to_translation, _document_translation)
%
% Article 3
%
% Member States shall ensure that suspected or accused
% persons who do not understand the language of the criminal
% proceedings concerned are, within a reasonable period of time,
% provided with a written translation of all documents which are
% essential to ensure that they are able to exercise their right of
% defence and to safeguard the fairness of the proceedings.

has_right(art3_1, PersonId, right_to_translation, essentialDocument):-
    proceeding_language(PersonId, Language),
    essential_document(_, PersonId, documents),
    \+ person_understands(PersonId, Language).

%% essential_document(_art, PersonId, _documents)
%
% Article 3.2
%
% Essential documents shall include any decision depriving a
% person of his liberty, any charge or indictment, and any
% judgment.
essential_document(art3_2, PersonId, documents):-
    person_document(PersonId, document_deprives_liberty).

essential_document(art3_2, PersonId, documents):-
    person_document(PersonId, charge).

essential_document(art3_2, PersonId, documents):-
    person_document(PersonId, indictment).

essential_document(art3_2, PersonId, documents):-
    person_document(PersonId, judgement).

%% essential_document(_art3_3, PersonId, _documents):
%
% Article 3.3
%
% The competent authorities shall, in any given case, decide
% whether any other document is essential. Suspected or accused
% persons or their legal counsel may submit a reasoned request to
% that effect.
essential_document(art3_3, PersonId, documents):-
    authority_decision(PersonId, essential_document),
    person_request_submitted(PersonId, essential_document).

essential_document(art3_3, PersonId, documents):-
    authority_decision(PersonId, essential_document).

% 4.
% There shall be no requirement to translate passages of
% essential documents which are not relevant for the purposes
% of enabling suspected or accused persons to have knowledge
% of the case against them.

%% auxiliary_right(_art3_5, PersonId, _remedy, _decision)
%
% Article 3.5
%
% Member States shall ensure that, in accordance with
% procedures in national law, suspected or accused persons have
% the right to challenge a decision finding that there is no need
% for the translation of documents or passages thereof and, when
% a translation has been provided, the possibility to complain that
% the quality of the translation is not sufficient to safeguard the
% fairness of the proceedings.

auxiliary_right_scope(art3_5, [art3_1, art3_6]).

auxiliary_right(art3_5, PersonId, remedy, decision) :-
    person_challenges_decision(PersonId, essential_document).

%% auxiliary_right(_art3_5, PersonId, _remedy, _quality)
%
% Article 3.5
%
% Member States shall ensure that, in accordance with
% procedures in national law, suspected or accused persons have
% the right to challenge a decision finding that there is no need
% for the translation of documents or passages thereof and, when
% a translation has been provided, the possibility to complain that
% the quality of the translation is not sufficient to safeguard the
% fairness of the proceedings.

auxiliary_right(art3_5, PersonId, remedy, quality) :-
    quality_not_sufficient(PersonId, document_translation).

%% has_right(_art3_6, PersonId, _right_to_translation, _europeanArrestWarrant)
%
% Article 3.6
%
% In proceedings for the execution of a European arrest
% warrant, the executing Member State shall ensure that its
% competent authorities provide any person subject to such
% proceedings who does not understand the language in which
% the European arrest warrant is drawn up, or into which it has
% been translated by the issuing Member State, with a written
% translation of that document.

has_right(art3_6, PersonId, right_to_translation, europeanArrestWarrant):-
    proceeding_type(PersonId, europeanArrestWarrant),
    person_document(PersonId, europeanArrestWarrant),
    proceeding_language(PersonId, Language),
    \+ person_understands(PersonId, Language).

%% right_property(_art3_7, PersonId, _form, _written)
%
% Article 3.7
%
% As an exception to the general rules established in
% paragraphs 1, 2, 3 and 6, an oral translation or oral
% summary of essential documents may be provided instead of
% a written translation on condition that such oral translation or
% oral summary does not prejudice the fairness of the
% proceedings.

right_property_scope(art3_7, [art3_1, art3_6]).

right_property(art3_7, PersonId, form, written) :-
    \+ right_property(art3_7, PersonId, form, oral).

%% right_property(_art3_7, PersonId, _form, _oral)
%
% Article 3.7
%
% As an exception to the general rules established in
% paragraphs 1, 2, 3 and 6, an oral translation or oral
% summary of essential documents may be provided instead of
% a written translation on condition that such oral translation or
% oral summary does not prejudice the fairness of the
% proceedings.

right_property(art3_7, PersonId, form, oral) :- \+ proceeding_event(PersonId, prejudice_fairness).

%% auxiliary_right(_art3_8, PersonId, _waiver, _translation)
%
% Article 3.8
%
% Any waiver of the right to translation of documents
% referred to in this Article shall be subject to the requirements
% that suspected or accused persons have received prior legal
% advice or have otherwise obtained full knowledge of the conse
% quences of such a waiver, and that the waiver was unequivocal
% and given voluntarily.

auxiliary_right_scope(art3_8, [art3_1, art3_6]).

auxiliary_right(art3_8, PersonId, waiver, translation) :-
    person_status(PersonId, priorAdviceReceived),
    waiver_status(PersonId, unequivocalVoluntary).

% 9.
% Translation provided under this Article shall be of a
% quality sufficient to safeguard the fairness of the proceedings,
% in particular by ensuring that suspected or accused persons have
% knowledge of the case against them and are able to exercise
% their right of defence.

%% auxiliary_right(_art4, PersonId, _cost, _state)
%
% Article 4
%
% Costs of interpretation and translation
% Member States shall meet the costs of interpretation and translation
% resulting from the application of Articles 2 and 3, irrespective
% of the outcome of the proceedings.

auxiliary_right_scope(art4, [art2_1, art2_2, art2_7, art3_1, art3_6]).

auxiliary_right(art4, PersonId, cost, state).

%% right_property(_art5, PersonId, _quality, _)
%
% Article 5
%
% Quality of the interpretation and translation
% 1. Member States shall take concrete measures to ensure that the
% interpretation and translation provided meets the quality required under Article 2(8) and Article 3(9).
% 2. In order to promote the adequacy of interpretation and translation
% and efficient access thereto, Member States shall endeavour to establish
% a register or registers of independent translators and interpreters who are appropriately qualified.
% Once established, such register or registers shall, where appropriate, be made available to legal counsel and relevant authorities.
% 3. Member States shall ensure that interpreters and translators be required to
% observe confidentiality regarding interpretation and translation provided under this Directive.

right_property_scope(art5, [art2_1, art2_2, art2_7, art3_1, art3_6]).

right_property(art5, PersonId, quality, register_qualified_staff).
right_property(art5, PersonId, quality, confidentiality).

%% right_property(_art6, PersonId, _training, _effective_communication)
%
% Article 6
%
% Training
% Without prejudice to judicial independence and differences in the organisation of the judiciary across the Union,
% Member States shall request those responsible for the training of judges, prosecutors and judicial staff involved
% in criminal proceedings to pay special attention to the particularities of communicating with the assistance of
% an interpreter so as to ensure efficient and effective communication.

right_property_scope(art6, [art2_1, art2_2, art2_7, art3_1, art3_6]).

right_property(art6, PersonId, training, effective_communication).

%% auxiliary_right(_art7, PersonId, _record, _recording_procedure)
%
% Article 7
%
% Record-keeping
% Member States shall ensure that when a suspected or accused person has been subject to questioning or
% hearings by an investigative or judicial authority with the assistance of an interpreter pursuant to Article 2,
% when an oral translation or oral summary of essential documents has been provided in the presence of such an
% authority pursuant to Article 3(7), or when a person has waived the right to translation pursuant to Article 3(8),
% it will be noted that these events have occurred, using the recording procedure in accordance with the law of the
% Member State concerned.
auxiliary_right_scope(art7, [art2_1, art2_2, art2_7, art3_1, art3_6]).

auxiliary_right(art7, PersonId, record, recording_procedure) :-
    proceeding_matter(PersonId, questioning);
    proceeding_matter(PersonId, hearing);
    right_property(art3_7, PersonId, form, written);
    right_property(art3_7, PersonId, form, oral);
    auxiliary_right(art3_8, PersonId, waiver, translation).
