:- module(directive_2010_64_bg, [has_right/5, auxiliary_right/5, auxiliary_right_checked/5, right_property/5, right_property_checked/5, explain/2]).

:- include('./../../utils.pl').

% Importable functor
has_right(Right, bg, Article, PersonId, Matter) :-
	has_right(Article, PersonId, Right, Matter).

%% has_right(_art21, PersonId, _right_to_interpretation, _trial)
%
% Article 21 Criminal Procedure Code
%
% Language of criminal proceedings
% (1) Criminal proceedings shall be conducted in the Bulgarian language.
% (2) Persons who do not have command of the Bulgarian language can make use of their native or another language.
% An interpreter shall be appointed in this case.
has_right(art21, PersonId, right_to_interpretation, trial) :-
    proceeding_language(PersonId, bulgarian),
    \+ person_language(PersonId, bulgarian).

%% has_right(_art55_4, PersonId, _right_to_translation, _trial)
%
% Article 55(4), 1 sentence Criminal Procedure Code
%
% Rights of the accused party
% (4) Where the accused party does not speak Bulgarian, he shall be provided oral and written translation of the criminal proceedings in a
% language he understands. (...)
has_right(art55_4, PersonId, right_to_translation, trial) :-
    person_status(PersonId, accused),
    proceeding_language(PersonId, bulgarian),
    \+ person_language(PersonId, bulgarian).

%% person_document(PersonId, _essential_document)
%
% Article 55(4), 2 sentence Criminal Procedure Code
%
% (4) (...) The accused party shall be provided a written translation of the decree for constitution of the accused party; the court's rulings imposing
% a remand measure; the indictment; the conviction ruled; the judgment of the intermediate appellate review instance; and the judgment of the cassation
% instance. (...)
person_document(PersonId, essential_document) :-
    person_document(PersonId, decree_constitution);
    person_document(PersonId, remand_measure);
    person_document(PersonId, indictment);
    person_document(PersonId, conviction);
    person_document(PersonId, appeal);
    person_document(PersonId, judgement).

%% auxiliary_right(_art128, PersonId, _record, _recording_procedure)
%
% Article 128 Criminal Procedure Code
%
% Drawing up record
% For every investigative action and judicial trial action a record shall be drawn up at the place where it is performed.
auxiliary_right_scope(art128, [art21, art43_4, art55_4]).

auxiliary_right(art128, PersonId, record, recording_procedure).

%% auxiliary_right(_art189, PersonId, _cost, _state)
%
% Article 189(2) Criminal Procedure Code
%
% Decision on costs
% (2) Costs for translation during pre-trial proceedings shall be at the expense of the respective body, and those during court proceedings shall be at the expense of the court.
% (3) Where the accused party is found guilty, the court shall sentence him/her to pay the costs for the trial including attorney fees and other expenses for
% the defence counsel appointed ex officio, as well as the expenses incurred by the private prosecutor and the civil claimant, where the latter have made a request to this effect.
% In presence of several sentenced persons, the court shall apportion the costs payable by each of them.
auxiliary_right_scope(art189, [art21, art43_4, art55_4]).

auxiliary_right(art189, PersonId, cost, state) :-
    \+ person_event(PersonId, guilty).

%% has_right(_art395a_1, PersonId, _right_to_translation, _trial)
%
% Article 395a(1) Criminal Procedure Code
%
% Provision of interpretation and written translation in criminal proceedings
% (1) Where the accused party does not speak the Bulgarian language, the court and the pre-trial authorities shall ensure
% oral translation in a language he understands as well as written translation of the acts under Article 55, Paragraph (4).
has_right(art395a_1, PersonId, right_to_translation, trial) :-
    person_status(PersonId, accused),
    person_document(PersonId, essential_document),
    \+ person_language(PersonId, bulgarian).

%% person_document(PersonId, _essential_document)
%
% Article 395a(2) Criminal Procedure Code
%
% Provision of interpretation and written translation in criminal proceedings
% (2) The court and the pre-trial authorities, acting on their own initiative or on a reasoned request of the accused party or the defence counsel,
% may also provide written translation of other documents within the case but the acts under Article 55, Paragraph (4), where they are of substantial
% importance for exercising the right to defence.
person_document(PersonId, essential_document) :-
    person_request_submitted(PersonId, essential_document),
    \+ exception(person_document(PersonId, essential_document)).

%% right_property(_art395a_3, PersonId, _form, _oral)
%
% Article 395a(3) Criminal Procedure Code
%
% Provision of interpretation and written translation in criminal proceedings
% (3) By exception, instead of the written translation under paragraphs (1) and (2), oral translation or oral summary may be provided, when the accused party has agreed thereto,
% has defence counsel and his procedural rights are not violated.
right_property_scope(art395a_3, [art21, art43_4, art55_4]).

right_property(art395a_3, PersonId, form, oral) :-
    person_event(PersonId, accepted_translation_oral),
    person_event(PersonId, lawyer_appointed),
    authority_decision(PersonId, procedural_rights_not_violated).

%% right_property(_art395b_1, PersonId, _nationalAuthority, _languageAssmessment)
%
% Article 395b(1) Criminal Procedure Code
%
% Checking the Bulgarian language knowledge of the accuses party
% (1) The court and the pre-trial authorities may, at any stage of the case, establish the circumstance that the accused
% party does not speak the Bulgarian language.
right_property_scope(art395b_1, [art21, art43_4, art55_4]).

right_property(art395b_1, PersonId, nationalAuthority, languageAssmessment).

%% auxiliary_right(_art395b_2, PersonId, _remedy, _decision)
%
% Article 395b(2-3) Criminal Procedure Code
%
% Checking the Bulgarian language knowledge of the accuses party
% (2) The decree of the investigating authority establishing that the accused party speaks Bulgarian is subject to appeal before the supervising prosecutor.
% (3) The ruling or order establishing that the accused party speaks Bulgarian shall be appealed under Chapter twenty-two.
auxiliary_right_scope(art395b_2, [art21, art43_4, art55_4]).

auxiliary_right(art395b_2, PersonId, remedy, decision) :-
    person_challenges_decision(PersonId, interpretation).

%% auxiliary_right(_art395c, PersonId, _waiver, _translation)
%
% Article 395c Criminal Procedure Code
%
% Waiver of the right to translation of documents
%
% (1) The court and the pre-trial authorities explain to the accused party his right to waive written or oral translation of the acts and documents under Article 395a.
% (2) The waiver is reflected in a protocol, signed by the accused party and his defence counsel unless it has been drafted in a court hearing.
auxiliary_right_scope(art395c, [art21, art43_4, art55_4]).

auxiliary_right(art395c, PersonId, waiver, translation).

%% exception(_person_document(PersonId, _essential_document))
%
% Article 395d(1-3) Criminal Procedure Code
%
% Denial of written or oral translation of documents
% (1) The court and the investigating authority may deny the provision of written or oral translation of the documents under Article 395a (2), where they are not
% of substantial importance for the exercise of the right to defence or to deny written translation of parts thereof, where they are not relevant to the right to defence of the accused party.
% (2) The decree of the investigating authority whereby the accused party is denied written or oral translation of documents or parts thereof is subject to appeal before the supervising prosecutor
% within a three-day term. The decree of the supervising authority shall be final.
% (3) A court's ruling or order whereby the accused party is denied written or oral translation of documents or parts thereof shall be appealed under Chapter twenty-two.
exception(person_document(PersonId, essential_document)) :-
    authority_decision(PersonId, document_not_important).

auxiliary_right_scope(art395d_2, [art21, art43_4, art55_4]).

auxiliary_right(art395d_2, PersonId, remedy, decision) :-
    person_challenges_decision(PersonId, essential_document).

%% auxiliary_right(_art395e, PersonId, _remedy, _quality)
%
% Article 395e Criminal Procedure Code
%
% Objection against accuracy of translation
% (1) The accused party has the right to objection against the accuracy of the translation at any stage of the case.
% (2) Where the competent authority finds the objection to be grounded, it shall remove the translator and appoint a new one or order a repeated translation.
auxiliary_right_scope(art395e, [art21, art43_4, art55_4]).

auxiliary_right(art395e, PersonId, remedy, quality) :-
    quality_not_sufficient(PersonId, interpreter);
    quality_not_sufficient(PersonId, document_translation).

%% has_right(_art395g_1, PersonId, _right_to_translation, _lawyer)
%
% Article 395g(1) Criminal Procedure Code
%
% Rules for involvement of the translator
% (1) The translator shall be involved in all actions, in which the accused party is also involved and during his meetings with the
% defence counsel regarding interrogation of the accused party or requests, remarks, objections and appeals thereof.
has_right(art395g_1, PersonId, right_to_translation, lawyer) :-
    person_status(PersonId, accused),
    proceeding_matter(PersonId, interrogation),
    proceeding_language(PersonId, bulgarian),
    \+ person_language(PersonId, bulgarian).

%% auxiliary_right(_art395h, PersonId, _assistance, _vulnerablePersons)
%
% Article 395h Criminal Procedure Code
%
% Interpreter
% (1) Where the accused party is deaf or dumb, an interpreter shall be appointed.
% (2) The provisions of this chapter shall also apply in regards to the interpreter.
auxiliary_right_scope(art395h, [art21, art43_4, art55_4]).

auxiliary_right(art395h, PersonId, assistance, vulnerablePersons) :-
    person_condition(PersonId, hearingSpeechImpediments).

%% right_property(_art395g_2, PersonId, _means, _technology)
%
% Article 395g(2) Criminal Procedure Code
%
% Rules for involvement of the translator
% (2) Where this will not hinder the exercise of the right to defence, the oral translation may be performed through a video or phone
% conference or another technical means.
right_property_scope(art395g_2, [art21, art43_4, art55_4]).

right_property(art395g_2, PersonId, means, technology) :-
    \+ physical_presence_required(PersonId, interpreter, hinder_right_defence).

%% has_right(_art43_4, PersonId, _right_to_interpretation, _europeanArrestWarrant)
%
% Article 43(4) Extradition and European Arrest Warrant Act
%
% Remand in Custody
% (4) The court shall appoint a defence counsel and an interpreter for the person if the latter has no command of the Bulgarian language
% and shall explain the grounds for his/her detention, the content of the European arrest warrant and his/her right to give consent to
% surrender to the competent authorities of the issuing Member States and the implications thereof.
has_right(art43_4, PersonId, right_to_interpretation, europeanArrestWarrant) :-
    proceeding_type(PersonId, europeanArrestWarrant),
    proceeding_language(PersonId, bulgarian),
    \+ person_language(PersonId, bulgarian).

%% right_property(_art249_1, PersonId, _training, _judges)
%
% Article 249(1) Judiciary System Act
%
% (1) The National Institute of Justice shall implement:
% 1. mandatory initial training of candidates for junior judge, junior prosecutor, and junior investigating magistrate;
% 2. mandatory induction training of judges, prosecutors and investigating magistrates when they are appointed for the first time in judicial authorities and when
% court assessors are elected for their first term of office;
% 3. maintaining and upgrading the qualification of judges, prosecutors and investigating magistrates, of members of the Supreme Judicial Council, of the Inspector
% General and inspectors of the Inspectorate with the Supreme Judicial Council, of public enforcement agents, recording magistrates, judicial assistants, prosecutorial assistants,
% judicial officers, court assessors, of the inspectors at the Inspectorate with the Minister of Justice and of other employees of the Ministry of Justice;
% 4. e-learning, and shall organise empirical legal research and analysis.
right_property_scope(art249_1, [art21, art43_4, art55_4]).

right_property(art249_1, PersonId, training, judges).

%% right_property(_art398, PersonId, _quality, _register_qualified_staff)
%
% Article 398 Judiciary System Act
%
% (1) Lists of experts endorsed as expert witnesses and as interpreters shall be compiled for each judicial district of a regional court and
% of an administrative court, as well as for the specialised criminal court.
% (2) The Supreme Court of Cassation, the Supreme Administrative Court, the Supreme Cassation Prosecution Office, the Supreme Administrative
% Prosecution Office and the National Investigation Service shall, where necessary, endorse separate lists for the needs of the operation thereof.
% (3) Where the needs of the respective judicial authority so require, the said authority may appoint an expert witness or an interpreter from the lists of other judicial districts.
% (4) The lists under Paragraphs (1) and (2) shall be public.
right_property_scope(art398, [art21, art43_4, art55_4]).

right_property(art398, PersonId, quality, register_qualified_staff).

%%
%
% Article 44(3) - Partially implemented
%
% Judicial Proceedings
% (3) The court shall appoint a defence counsel for the person claimed, if the latter has none, and an interpreter if he/she has no command
% of the Bulgarian language, and it shall explain to him/her the right to give consent to surrender to the issuing Member State, as well as to
% renounce entitlement to the speciality rule under Article 61 and the consequences of these steps.

%%
%
% Article 48(2) - Partially implemented
%
% Proceedings before Appellate Court
% (2) The appeal and protest shall be examined within five days after their receipt at the court according to the procedure established by Article 44.
% The court shall announce its decision in public session, with the parties attending.

%% right_property(_art2_3, PersonId, _quality, _)
%
% Article 2(3) Ordinance No. Н-1 of 16 May 2014 on the court interpreters
%
% The activity of translators in court proceedings is based on the following principles:
% 3. good faith, objectivity, accuracy and completeness of the translation
right_property_scope(art2_3, [art21, art43_4, art55_4]).

right_property(art2_3, PersonId, quality, objectivity).




