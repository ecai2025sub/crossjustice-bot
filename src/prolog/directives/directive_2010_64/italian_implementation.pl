:- module(directive_2010_64_it, [has_right/5, auxiliary_right/5, auxiliary_right_checked/5, right_property/5, right_property_checked/5, explain/2]).

:- include('./../../utils.pl').

% Importable functor
has_right(Right, it, Article, PersonId, Matter) :-
	has_right(Article, PersonId, Right, Matter).

% Art. 61.
%
% Estensione dei diritti e delle garanzie dell'imputato.
%
% 1. I diritti e le garanzie dell'imputato si estendono alla persona sottoposta alle indagini preliminari.

%% has_right(_art143_1_1, PersonId, _right_to_interpretation, _trial)
%
% Article 143.1.1 code of criminal procedure
%
% The accused who does not know the Italian language is
% entitled to be assisted by an interpreter – free of charge
% and regardless of the outcome of proceedings – to understand
% the accusations against him and follow the actions and hearings
% in which he participates.

has_right(art143_1_1, PersonId, right_to_interpretation, trial):-
	proceeding_language(PersonId, italian),
	\+ person_language(PersonId, italian).

%% has_right(_art143_1_2, PersonId, _right_to_interpretation, _lawyer)
%
% Article 143.1.2 code of criminal procedure
%
% The accused is also entitled to be assisted by an interpreter
% – free of charge – to be able to confer with his lawyer prior
% to questioning or for the submission of a request or brief during proceedings.

has_right(art143_1_2, PersonId, right_to_interpretation, lawyer):-
	lawyer_language(PersonId, Language),
	\+ person_language(PersonId, Language).

%% auxiliary_right(_art119, PersonId, _assistance, _mute)
%
% Article 119 code of criminal procedure
%
% Participation of deaf or mute persons in the actions of the proceedings
% If a deaf or mute person wants or has to make statements, any questions,
% warnings and admonitions shall be submitted in writing to the deaf person
% who shall reply orally; any questions, warnings and admonitions shall be
% submitted orally to the mute person who shall reply in writing; any questions,
% warnings and admonitions shall be submitted in writing to the deaf-mute
% person, who shall reply in writing.

auxiliary_right_scope(art119, [art143_1_1, art143_1_2]).

auxiliary_right(art119, PersonId, assistance, mute) :-
	person_condition(PersonId, speechImpediment).

%% auxiliary_right(_art119, PersonId, _assistance, _deaf)
%
% Article 119 code of criminal procedure
%
% Participation of deaf or mute persons in the actions of the proceedings
% If a deaf or mute person wants or has to make statements, any questions,
% warnings and admonitions shall be submitted in writing to the deaf person
% who shall reply orally; any questions, warnings and admonitions shall be
% submitted orally to the mute person who shall reply in writing; any questions,
% warnings and admonitions shall be submitted in writing to the deaf-mute
% person, who shall reply in writing.

auxiliary_right(art119, PersonId, assistance, deaf) :-
	person_condition(PersonId, hearingImpediment).

%% person_language(_PersonId, italian)
%
% Knowledge of the Italian language shall be assessed by the judicial authority.
% knowledge of the Italian language by Italian citizens shall be presumed unless proven otherwise.
right_property_scope(art143_4, [art143_1_1, art143_1_2, art143_bis1, art143_3]).

right_property(art143_4, PersonId, judicialAuthority, languageAssmessment).

person_language(PersonId, italian):-
    right_property(_, A, languageAssmessment),
    person_language_verified_by(PersonId, italian, A).

% Unnecessary rule?
person_language(art143_4, PersonId, italian):-
	person_nationality(PersonId, italian),
	\+ person_language_unknown_verified_by(PersonId, italian, judicialAuthority).

%% right_property(_art143_3bis, PersonId, _means, _technology)
%
% Article 143 code of criminal procedure
%
% The assistance of an interpreter may be provided, if possible, also by means of telecommunication
% technologies, unless the physical presence of the interpreter is necessary for the victim to be able to
% correctly exercise his rights or to thoroughly understand how proceedings are conducted.

right_property_scope(art143_3bis, [art143_1_1, art143_1_2]).

right_property(art143_3bis, PersonId, means, technology) :-
	\+ physical_presence_required(PersonId, interpreter, correct_exercise_right).

%% has_right(_art12_1, PersonId, _right_to_interpretation, _europeanArrestWarrant)
%
% Article 12.1 legislative decree 22 april 2005, n. 69
%
% Provisions to adapt national legislation to the Council Framework Decision 2002/584/JHA of 13 June 2002 on the European arrest warrant and the surrender procedures between Member States
% The criminal police officer who arrests the accused under Art 11 informs the person, using a language he can understand,
% about the warrant, its contents and delivers a written document, clearly and precisely drafted, which informs him of the
% possibility of consenting to surrender to the issuing judicial authority and advise the person he can appoint a lawyer
% and he has the right to be assisted by an interpreter.

has_right(art12_1, PersonId, right_to_interpretation, europeanArrestWarrant):-
	proceeding_type(PersonId, europeanArrestWarrant),
	proceeding_language(PersonId, Language),
	\+ person_language(PersonId, Language).

%% auxiliary_right(art293_1_c, PersonId, phase, precautionary_detention)
%
% Article 293.1.c code of criminal procedure
%
% Enforcement requirements
% Without prejudice to Article 156, the official or officer in charge of enforcing the
% order of precautionary detention shall provide the accused person with a copy of the
% decision along with a clear and precise written notice. If the accused does not know
% the Italian language, the notice shall be translated into a language he understands.
% The notice shall contain the following information:
% c) his right to an interpreter and to the translation of essential documents

auxiliary_right_scope(art293_1_c, [art143_1_1, art143_1_2, art143_3, art143_bis1]).

auxiliary_right(art293_1_c, PersonId, phase, precautionary_detention) :-
	proceeding_matter(PersonId, precautionary_detention).

%article outside implementation
person_document(PersonId, decision_precautionary_measure):-
	person_document(PersonId, order_precautionary_detention).

%% auxiliary_right(_art386_1_c, PersonId, _phase, _arrest)
%
% Article 386.1.c code of criminal procedure
%
% Duties of the criminal police in case of arrest or temporary detention
% The criminal police officials and officers who have arrested or placed under temporary
% detention the perpetrator or to whom the arrested person has been surrendered, shall
% immediately inform the Public Prosecutor of the place where the perpetrator has been
% arrested or placed under temporary detention. They shall provide the arrested or temporarily
% detained person with a written notice, drafted clearly and precisely. If the arrested or
% temporarily detained person does not know the Italian language, the notice shall be translated into a language he understands.
% The notice shall contain the following information:
% c) his right to an interpreter and to the translation of essential

auxiliary_right_scope(art386_1_c, [art143_1_1, art143_1_2, art143_3, art143_bis1]).

auxiliary_right(art386_1_c, PersonId, phase, arrest) :-
	proceeding_matter(PersonId, arrest).

%% auxiliary_right(_art386_1_c, PersonId, _phase, _temporary_detention)
%
% Article 386.1.c code of criminal procedure
%
% Duties of the criminal police in case of arrest or temporary detention
% The criminal police officials and officers who have arrested or placed under temporary
% detention the perpetrator or to whom the arrested person has been surrendered, shall
% immediately inform the Public Prosecutor of the place where the perpetrator has been
% arrested or placed under temporary detention. They shall provide the arrested or temporarily
% detained person with a written notice, drafted clearly and precisely. If the arrested or
% temporarily detained person does not know the Italian language, the notice shall be translated into a language he understands.
% The notice shall contain the following information:
% c) his right to an interpreter and to the translation of essential

auxiliary_right(art386_1_c, PersonId, phase, temporary_detention) :-
	proceeding_matter(PersonId, temporary_detention).

%% auxiliary_right(_art369bis_2_dbis, PersonId, _phase, _notice_of_right_to_defence)
%
% Article 369bis.2dbis
%
% Notice to the suspect about his right to defence
% During the first activity in which the lawyer has the right to be present and, in any case, prior to sending
% the summons to appear for questioning according to the conjunction of Articles 375, paragraph 3, and 416, or no
% later than the service of the notice on the conclusion of preliminary investigations according to Article 415-bis,
% the Public Prosecutor, under penalty of nullity of subsequent acts, shall serve on the suspected person the
% notification of the designation of a court-appointed lawyer.
% The notification referred to in paragraph 1 shall contain:
% d-bis) the information that the suspect has the right to an interpreter and to the translation of essential documents

auxiliary_right_scope(art369bis_2_dbis, [art143_1_1, art143_1_2, art143_3, art143_bis1]).

auxiliary_right(art369bis_2_dbis, PersonId, phase, notice_of_right_to_defence) :-
	person_status(PersonId, suspect),
	proceeding_matter(PersonId, lawyer_presence_required).

%% has_right(_art104_4bis, PersonId, _right_to_interpretation, _lawyer)
%
% Article 104.4bis code of criminal procedure
%
% Communication between the lawyer and the accused person under precautionary detention
% The accused who is either under arrest or under temporary or precautionary detention
% and does not know the Italian language is entitled to be assisted by an interpreter
% - free of charge - to be able to consult with his lawyer, in line with the previous paragraphs.
% The interpreter shall be appointed according to the provisions of Title IV, Book II.

auxiliary_right_scope(art104_4bis, [art104_4bis]).

has_right(art104_4bis, PersonId, right_to_interpretation, lawyer):-
	(	proceeding_matter(PersonId, temporary_detention)
	;	proceeding_matter(PersonId, arrest)
	;	proceeding_matter(PersonId, precautionary_detention)
	),
	lawyer_language(PersonId, italian),
	\+ person_language(PersonId, italian).

%% auxiliary_right(_art104_4bis, PersonId, _phase, _precautionary_detention)
%
% Article 104.4bis code of criminal procedure
%
% Communication between the lawyer and the accused person under precautionary detention
% The accused who is either under arrest or under temporary or precautionary detention
% and does not know the Italian language is entitled to be assisted by an interpreter
% - free of charge - to be able to consult with his lawyer, in line with the previous paragraphs.
% The interpreter shall be appointed according to the provisions of Title IV, Book II.

auxiliary_right(art104_4bis, PersonId, phase, precautionary_detention) :-
	proceeding_matter(PersonId, temporary_detention).

%% auxiliary_right(_art104_4bis, PersonId, _phase, _arrest)
%
% Article 104.4bis code of criminal procedure
%
% Communication between the lawyer and the accused person under precautionary detention
% The accused who is either under arrest or under temporary or precautionary detention
% and does not know the Italian language is entitled to be assisted by an interpreter
% - free of charge - to be able to consult with his lawyer, in line with the previous paragraphs.
% The interpreter shall be appointed according to the provisions of Title IV, Book II.

auxiliary_right(art104_4bis, PersonId, phase, arrest) :-
	proceeding_matter(PersonId, arrest).

%% auxiliary_right(_art104_4bis, PersonId, _phase, _temporary_detention)
%
% Article 104.4bis code of criminal procedure
%
% Communication between the lawyer and the accused person under precautionary detention
% The accused who is either under arrest or under temporary or precautionary detention
% and does not know the Italian language is entitled to be assisted by an interpreter
% - free of charge - to be able to consult with his lawyer, in line with the previous paragraphs.
% The interpreter shall be appointed according to the provisions of Title IV, Book II.

auxiliary_right(art104_4bis, PersonId, phase, temporary_detention) :-
	proceeding_matter(PersonId, precautionary_detention).

%% essential_document(_art143_2, PersonId, _documents)
%
% Article 143.2 code of criminal procedure
%
% In the aforementioned circumstances, the proceeding authority shall order the written
% translation of the notice of investigation, the notice of the right to defence,
% the decision ordering personal precautionary measures, the notice of the conclusion of
% preliminary investigations, the decrees ordering the preliminary hearing and the decrees
% of summons for trial, the judgements and the criminal decrees of conviction.
% The translation of the mentioned documents must be provided within suitable period of
% time so as to enable the defence to exercise its rights and powers

essential_document(art143_2, PersonId, documents):-
	person_document(PersonId, notice_of_investigation).

essential_document(art143_2, PersonId, documents):-
	person_document(PersonId, notice_of_right_to_defence).

essential_document(art143_2, PersonId, documents):-
	person_document(PersonId, decision_precautionary_measure).

essential_document(art143_2, PersonId, documents):-
	person_document(PersonId, notice_conclusion_investigation).

essential_document(art143_2, PersonId, documents):-
	person_document(PersonId, decree_preliminary_hearing).

essential_document(art143_2, PersonId, documents):-
	person_document(PersonId, decree_trial_summons).

essential_document(art143_2, PersonId, documents):-
	person_document(PersonId, judgement).

essential_document(art143_2, PersonId, documents):-
	person_document(PersonId, decree_conviction).

%% has_right(_art143_3, PersonId, _right_to_translation, _document)
%
% Article 143.3 code of criminal procedure
%
% The free-of charge translation of any other document or part thereof which is deemed
% essential for the accused to understand the accusations against him may be ordered
% by the court, also upon request of a party, by means of a reasoned decision,
% appealable together with the judgement

has_right(art143_3, PersonId, right_to_translation, document) :-
	essential_document(_, PersonId, documents),
	proceeding_language(PersonId, Language),
    \+ person_language(PersonId, Language).

%% essential_document(_art143_3, PersonId, _documents)
%
% Article 143.3 code of criminal procedure
%
% The free-of charge translation of any other document or part thereof which is deemed
% essential for the accused to understand the accusations against him may be ordered
% by the court, also upon request of a party, by means of a reasoned decision,
% appealable together with the judgement

essential_document(art143_3, PersonId, documents) :-
	authority_decision(PersonId, essential_document),
    person_request_submitted(PersonId, essential_document).

essential_document(art143_3, PersonId, documents) :-
	authority_decision(PersonId, essential_document).

auxiliary_right_scope(art143_3, [art143_3]).

%% auxiliary_right(_art143_3, PersonId, _remedy, _essential)
%
% Article 143.3 code of criminal procedure
%
% The free-of charge translation of any other document or part thereof which is deemed
% essential for the accused to understand the accusations against him may be ordered
% by the court, also upon request of a party, by means of a reasoned decision,
% appealable together with the judgement

auxiliary_right(art143_3, PersonId, remedy, essential) :-
	person_challenges_decision(PersonId, essential_document).

%% auxiliary_right(_art143_3, PersonId, _cost, _state)
%
% Article 143.3 code of criminal procedure
%
% The free-of charge translation of any other document or part thereof which is deemed
% essential for the accused to understand the accusations against him may be ordered
% by the court, also upon request of a party, by means of a reasoned decision,
% appealable together with the judgement

auxiliary_right(art143_3, PersonId, cost, state).

% TODO - add person_appeals(judgement)?

%Article 51 bis - Fully implemented Legislative Decree 28 July 1989, no 272
%For each of the cases provided for in article 143, paragraph 1, second sentence, of the code, the defendant is entitled to the free
%assistance of the interpreter for one interview with the defence counsel. If, for particular facts or circumstances, the exercise of
%the right of defence requires the conduct of more than one interview in relation to the performance of the same procedural act, the
%free assistance of the interpreter may be provided for more than one interview.

%auxiliary_right_scope(article51bis_dlgs272_89, [art143_1_1, art143_1_2]).

% auxiliary_right(article51bis_dlgs272_89, PersonId, communications, lawyer).
%auxiliary_right(article51bis_dlgs272_89, PersonId, cost, state).

%% has_right(_art143_bis1, PersonId, _right_to_translation, _document)
%
% Article 143.bis1 code of criminal procedure
%
% The proceeding authority shall appoint a translator for the translation of a document written in either a foreign language or a
% dialect that is not easily understandable or if the person who is willing to or has to make a statement does not know the Italian language.
% The statement may also be made in writing and, in such case, it shall be enclosed in the record together with the translation provided by
% the translator.

has_right(art143_bis1, PersonId, right_to_translation, document):-
	essential_document(_, PersonId, documents),
	proceeding_language(PersonId, Language),
    \+ person_language(PersonId, Language).
