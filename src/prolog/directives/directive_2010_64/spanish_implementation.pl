:- module(directive_2010_64_es, [has_right/5, auxiliary_right/5, auxiliary_right_checked/5, right_property/5, right_property_checked/5, explain/2]).

:- include('./../../utils.pl').

% Importable functor
has_right(Right, es, Article, PersonId, Matter) :-
    has_right(Article, PersonId, Right, Matter).

%% has_right(_art123_1_a, PersonId, _right_to_interpretation, _trial)
%
% Article 123.1.a criminal procedural law
%
% Those defendants who do not speak or understand Spanish or the official language in which the action takes
% place shall have the following rights: a) Right to be assisted by an interpreter who uses a language that s/he
% understands during all the proceedings in which his/her presence is necessary, including police interrogation
% or by the Prosecutor's Office and all judicial hearings.

has_right(art123_1_a, PersonId, right_to_interpretation, trial):-
	proceeding_language(PersonId, Language),
	\+ person_language(PersonId, Language).

%% has_right(_art123_1_b, PersonId, _right_to_interpretation, _lawyer)
%
% Article 123.1.b criminal procedural law
%
% The defendants who do not speak or understand Spanish or the official language
% in which the action takes place will have the following rights (...)
% b) The right to have an interpreter in the conversations that s/he has with
% his/her lawyer and that are directly related to his/her subsequent
% interrogation or declaration, or that are necessary for the presentation
% of an appeal or for other procedural requests.

has_right(art123_1_b, PersonId, right_to_interpretation, lawyer):-
	lawyer_language(PersonId, Language),
	\+ person_language(PersonId, Language).

% Article 118(f) - Partially implemented
% “Any person to whom a punishable act is attributed may exercise the right of defense, intervening in the proceedings,
% since its existence is communicated, has been subject to detention or any other precautionary measure or has been indicted,
% for which, s/he will be informed, without undue delay, of the following rights: (…) f) The right to free translation
% and interpretation in accordance with the provisions of articles 123 and 127"

%% auxiliary_right(_art127, PersonId, _assistance, _sensoryDisability)
%
% Article 127 criminal procedural law
%
% The provisions contained in the preceding articles are equally applicable to people with sensory disabilities,
% who shall have available means of support for oral communication.

auxiliary_right_scope(art127, [art123_1_a, art123_1_b, art51_1, art123_1_d]).

auxiliary_right(art127, PersonId, assistance, sensoryDisability):-
    person_condition(PersonId, sensoryDisability).

% TODO - article 51 Ley 23/2014 not included, need to add a specific provision?

%% person_language(PersonId, Language)
%
% Article 125.1 criminal procedural law
%
% When the need for assistance of an interpreter or translator arises from the circumstances,
% the President of the Court or the Judge, ex officio or at the request of the Defense Attorney,
% shall ascertain whether the defendant knows and understands sufficiently the official language
% in which proceedings are being carried out and, where appropriate, shall order the appointment of
% an interpreter or a translator in accordance with the provisions of the previous article and
% preceding Article and shall determine which documents must be translated.

duty(art125_1, presidentCourt, languageAssmessment).
duty(art125_1, judge, languageAssmessment).

person_language(PersonId, Language):-
    duty(_, A, languageAssmessment),
    person_language_verified_by(PersonId, Language, A).

%% auxiliary_right(_art125_2, PersonId, _remedy, _decision)
%
% Article 125.2 criminal procedural law
%
% The decision of the Judge or Court that denies the right to interpretation or translation of any document
% or passage thereof that the defense considers essential, or by which the complaints of the defense in relation to
% lack of quality of the interpretation or translation are rejected, will be documented in writing.
% If the decision had been taken during the trial, the defense of the accused may ask for the record of his/her protest in the minutes.
% An appeal may be lodged against these judicial decisions in accordance with the provisions of this Law.

auxiliary_right_scope(art125_2, [art123_1_a, art123_1_b, art51_1, art123_1_d]).

auxiliary_right(art125_2, PersonId, remedy, decision) :-
	person_challenges_decision(PersonId, interpretation).
auxiliary_right(art125_2, PersonId, remedy, decision) :-
	person_challenges_decision(PersonId, essential_document).

%% auxiliary_right(_art125_2, PersonId, _remedy, _quality)
%
% Article 125.2 criminal procedural law
%
% The decision of the Judge or Court that denies the right to interpretation or translation of any document
% or passage thereof that the defense considers essential, or by which the complaints of the defense in relation to
% lack of quality of the interpretation or translation are rejected, will be documented in writing.
% If the decision had been taken during the trial, the defense of the accused may ask for the record of his/her protest in the minutes.
% An appeal may be lodged against these judicial decisions in accordance with the provisions of this Law.

auxiliary_right(art125_2, PersonId, remedy, quality) :-
    quality_not_sufficient(PersonId, interpreter).
auxiliary_right(art125_2, PersonId, remedy, quality) :-
    quality_not_sufficient(PersonId, document_translation).

%% right_property(_art123_5, PersonId, _means, _technology)
%
% Article 123.5 criminal procedural law
%
% The assistance of the interpreter may be provided through videoconference or by any means of telecommunication,
% unless the Court or the Judge or the Public Prosecutor, ex officio or at the request of the interested party or
% his/her defense lawyer, agrees the physical presence of the interpreter in order to safeguard the rights of the accused.

right_property_scope(art123_5, [art123_1_a, art123_1_b, art51_1]).

right_property(art123_5, PersonId, means, technology) :-
    \+ physical_presence_required(PersonId, interpreter, safeguard_rights).

%% has_right(_art51_1, PersonId, _right_to_interpretation, _europeanArrestWarrant)
%
% Article 51.1 Law on mutual recognition of criminal decisions in the European Union
%
% The hearing of the arrested person shall be held within a maximum period of seventy-two hours after being brought
% to justice, with the assistance of the Prosecutor, the lawyer of the detained person and, where appropriate,
% an interpreter, and must be carried out in accordance with provided for the questioning of the person detained
% by the Criminal Procedure Act

has_right(art51_1, PersonId, right_to_interpretation, europeanArrestWarrant):-
	proceeding_language(PersonId, Language),
	proceeding_type(PersonId, europeanArrestWarrant),
	\+ person_language(PersonId, Language).

% TODO according to the email, judge decides but usually only when there is a request made by the accused, should we map that?

%% has_right(_art123_1_d, PersonId, _right_to_translation, _essentialDocument)
%
% Article 123.1.d criminal procedural law
%
% Defendants who do not speak or understand Spanish or the official language in which the action takes place
% will have the following rights (...):
% d) Right to the written translation of the documents that are essential to guarantee the exercise of the right to defense.
% Decision on depirivation of liberty of the accused, the indictment and the sentence must be always translated.

has_right(art123_1_d, PersonId, right_to_translation, essentialDocument):-
	essential_document(_, PersonId, documents),
	proceeding_language(PersonId, Language),
    \+ person_language(PersonId, Language).

%% essential_document(_art123_1, PersonId, _documents)
%
% Article 123.1 criminal procedural law
%
% Defendants who do not speak or understand Spanish or the official language in which the action takes place
% will have the following rights (...):
% d) Right to the written translation of the documents that are essential to guarantee the exercise of the right to defense.
% Decision on depirivation of liberty of the accused, the indictment and the sentence must be always translated.

essential_document(art123_1, PersonId, documents):-
	person_document(PersonId, document_deprives_liberty).

essential_document(art123_1, PersonId, documents):-
    person_document(PersonId, indictment).

essential_document(art123_1, PersonId, documents):-
    person_document(PersonId, judgement).

%% essential_document(_art123_1_e, PersonId, _documents)
%
% Article 123.1.e criminal procedural law
%
% Defendants who do not speak or understand Spanish or the official language in which the procedure are taking
% place will have the following rights: (...)
% e) the right to submit a reasoned request for a document to be considered essential.

essential_document(art123_1_e, PersonId, documents):-
    authority_decision(PersonId, essential_document),
    person_request_submitted(PersonId, essential_document).

%% auxiliary_right(_art123_1_e, PersonId, _remedy, _decision)
%
% Article 123.1.e criminal procedural law
%
% Defendants who do not speak or understand Spanish or the official language in which the procedure are taking
% place will have the following rights: (...)
% e) the right to submit a reasoned request for a document to be considered essential.

auxiliary_right_scope(art123_1_e, [art123_1_d]).

auxiliary_right(art123_1_e, PersonId, remedy, decision) :-
	person_request_submitted(PersonId, essential_document).

%% right_property(_art123_3, PersonId, _form, _written)
%
% Article 123.3 criminal procedural law
%
% Exceptionally, the written translation of documents may be replaced by an oral summary of their content in
% a language that the defendant understands, provided that the right of defense of the accused is
% sufficiently guaranteed also in this way.

right_property_scope(art123_3, [art123_1_d]).

right_property(art123_3, PersonId, form, written) :-
    \+ right_property(art123_3, PersonId, form, oral).

%% right_property(_art123_3, PersonId, _form, _oral)
%
% Article 123.3 criminal procedural law
%
% Exceptionally, the written translation of documents may be replaced by an oral summary of their content in
% a language that the defendant understands, provided that the right of defense of the accused is
% sufficiently guaranteed also in this way.

right_property(art123_3, PersonId, form, oral) :- \+ proceeding_event(PersonId, prejudice_fairness).

%% auxiliary_right(_art126, PersonId, _waiver, _translation)
%
% Article 126 criminal procedural law
%
% The waiver of the rights referred to in article 123 must be express and free, and will only be valid
% if it occurs after the accused has received sufficient and accessible legal advice to enable him/her
% to become aware of the consequences of his renunciation. In any event, the rights referred to in
% Article 123(1)(a) and (c) may not be waived.

auxiliary_right_scope(art126, [art123_1_b, art123_1_d]).

auxiliary_right(art126, PersonId, waiver, translation):-
    person_status(PersonId, priorAdviceReceived),
    waiver_status(PersonId, express_free).

%% auxiliary_right(_art123_1, PersonId, _cost, _state)
%
% Article 123.1.viii criminal procedural lagw
%
% Translation and interpretation expenses arising from the exercise of these rights will be paid by the Administration,
% regardless of the outcome of the procedure.

auxiliary_right_scope(art123_1, [art123_1_a, art123_1_b, art51_1, art123_1_d]).

auxiliary_right(art123_1, PersonId, cost, state).
