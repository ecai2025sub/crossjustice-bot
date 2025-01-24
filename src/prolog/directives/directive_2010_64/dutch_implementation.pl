:- module(directive_2010_64_nl, [has_right/5, auxiliary_right/5, auxiliary_right_checked/5, right_property/5, right_property_checked/5, explain/2]).

:- include('./../../utils.pl').

% Importable functor
has_right(Right, nl, Article, PersonId, Matter) :-
	has_right(Article, PersonId, Right, Matter).

%% has_right(_art23_4, PersonId, _right_to_interpretation, _trial)
%
% Article 23(4) Dutch Code of Criminal Procedure
%
% If the suspect has no or insufficient command of the Dutch language, the assistance of an interpreter shall be sought.
% The public prosecutor shall call in the interpreter. Article 276(3) shall apply mutatis mutandis.
has_right(art23_4, PersonId, right_to_interpretation, trial) :-
    person_status(PersonId, suspect),
    \+ person_language(PersonId, dutch).

%% has_right(_art28_5, PersonId, _right_to_interpretation, _lawyer)
%
% Article 28(5) Dutch Code of Criminal Procedure
%
% The suspect who has no or insufficient command of the Dutch language may, for the purpose of conferring with his counsel, rely
% on the assistance of an interpreter. The counsel is responsible for summoning an interpreter.
has_right(art28_5, PersonId, right_to_interpretation, lawyer) :-
    person_status(PersonId, suspect),
    \+ person_language(PersonId, dutch).

%% has_right(_art29b, PersonId, _right_to_interpretation, _questioning)
%
% Article 29b(1-2) Dutch Code of Criminal Procedure
%
% In all cases where a suspect who does not speak the Dutch language or has insufficient command thereof is heard,
% the assistance of an interpreter shall be sought.
% The interpreter shall be called upon by the officer conducting the questioning, unless otherwise provided by law.
% During the investigation, the interpreter may be called upon orally. In all other cases, the call shall be in writing.
has_right(art29b, PersonId, right_to_interpretation, questioning) :-
    person_status(PersonId, suspect),
    proceeding_matter(PersonId, questioning),
    \+ person_language(PersonId, dutch).

right_property_scope(art29b2, [art29]).

right_property(art29b2, PersonId, form, orally) :-
    proceeding_matter(PersonId, investigation).

right_property(art29b2, PersonId, form, writing) :-
    \+ proceeding_matter(PersonId, investigation).

%% right_property(_art29_3, PersonId, _record, _recording_procedure)
%
% Article 29(3) Dutch Code of Criminal Procedure
%
% The assistance of an interpreter shall be reported in the official record.
right_property_scope(art29_3, [art23_4, art32a_1]).
right_property(art29_3, PersonId, record, recording_procedure).

%% has_right(_art32a_1, PersonId, _right_to_translation, _essentialDocument)
%
% Article 32a(1) Dutch Code of Criminal Procedure
%
% A suspected or accused person who has no or insufficient command of the Dutch language may request that case documents to which he has been
% granted access and which he deems necessary for his defence be translated, in whole or in part, in writing into a language which he understands.
% The request shall be made in writing, shall state as clearly as possible the documents or parts of documents to which it relates and shall state
% the reasons on which it is based.
has_right(art32a_1, PersonId, right_to_translation, essentialDocument) :-
    (   person_status(PersonId, suspect)
    ;   person_status(PersonId, accused)
    ),
    person_request_submitted(PersonId, essential_document).

%% auxiliary_right(_art32a_3, PersonId, _remedy, _decision)
%
% Article 32a(3) Dutch Code of Criminal Procedure
%
% If the public prosecutor rejects the request referred to in paragraph 1, the suspect shall be notified thereof in writing. The suspect may submit
% a notice of objection to the investigative judge within fourteen days after the date of the notification. The investigative judge shall hear the accused
% and the public prosecutor, before making a decision.
auxiliary_right_scope(art32a_3, [art32a_1]).

auxiliary_right(art32a_3, PersonId, remedy, decision) :-
    person_challenges_decision(PersonId, essential_document).

%% has_right(_art56b_3, PersonId, _right_to_translation, _europeanArrestWarrant)
%
% Article 56b(3) Dutch Code of Criminal Procedure
%
% The suspect shall be identified by name or, if his name is unknown, as clearly as possible in the warrant. A copy of the warrant shall be served on him without delay.
% If the suspect does not know or has insufficient command of Dutch, the content of the warrant shall be communicated to him orally in a language he understands.
has_right(art56b_3, PersonId, right_to_translation, europeanArrestWarrant) :-
    (   person_status(PersonId, requested)
    ,   proceeding_matter(PersonId, europeanArrestWarrant)
    );
    proceeding_type(PersonId, europeanArrestWarrant),
    \+ person_language(PersonId, dutch).

%% has_right(_art59_7, PersonId, _right_to_translation, _arrest)
%
% Article 59(7) Dutch Code of Criminal Procedure
%
% If the suspect has no or insufficient command of the Dutch language, he shall be informed as soon as possible in writing, in a language he understands,
% of the offence in respect of which the suspicion has arisen, the grounds for issuing the order [to be taken into police custody] and the period of validity
% of the order.
has_right(art59_7, PersonId, right_to_translation, arrest) :-
    (   person_status(PersonId, suspect)
    ;   person_status(PersonId, requested)
    ),
    proceeding_matter(PersonId, police_custody),
    \+ person_language(PersonId, dutch).

%% has_right(_art78_6, PersonId, _right_to_translation, _pretrial_detention)
%
% Article 78(6) Dutch Code of Criminal Procedure
%
% If the suspect does not or insufficiently master the Dutch language, he shall be informed as soon as possible in writing, in a language comprehensible to him,
% of the offence in respect of which the suspicion has arisen, the grounds for issuing the order [to be taken into pretrial detention] and the period of validity of the order.
has_right(art78_6, PersonId, right_to_translation, pretrial_detention) :-
    person_status(PersonId, suspect),
    proceeding_matter(PersonId, pretrial_detention),
    \+ person_language(PersonId, dutch).

%% auxiliary_right(_art131b, PersonId, _assistance, _vulnerablePersons)
%
% Article 131b Dutch Code of Criminal Procedure
%
% Where reference is made to the assistance of an interpreter to a suspect who has no or insufficient command of the Dutch language, .
% this shall also include the assistance of a suitable person as an interpreter to a suspect who cannot hear or speak, or can hear or speak only very poorly.
auxiliary_right_scope(art131b, [art23_4, art28_5, art29b, art191, art257a_7, art275_1]).

auxiliary_right(art131b, PersonId, assistance, vulnerablePersons) :-
    person_condition(PersonId, hearingSpeechImpediments).

%% has_right(_art191, PersonId, _right_to_interpretation, _questioning)
%
% Article 191(1-2) Dutch Code of Criminal Procedure
%
% If a suspect, witness or expert does not know the Dutch language or does not know it sufficiently, the examining magistrate may summon an interpreter.
% If a suspect or witness cannot hear or speak or only very poorly, the examining magistrate shall determine that the assistance of an
% appropriate person as an interpreter shall be called or that the questions or answers shall be in writing.
has_right(art191, PersonId, right_to_interpretation, questioning) :-
    person_status(PersonId, suspect),
    proceeding_matter(PersonId, questioning),
    \+ person_language(PersonId, dutch).

%% has_right(_art257a_7, PersonId, _right_to_translation, _penal_order)
%
% Article 257a(7) Dutch Code of Criminal Procedure
%
% If it appears that the accused has no or insufficient command of the Dutch language and the penal order has been issued
% because of a crime [not a minor offence], such order, or at least the parts of it referred to in paragraph 6, shall be translated
% into a language the accused understands. The suspect who has no or insufficient command of the Dutch language may request that the penal
% order be translated into a language that he understands.
has_right(art257a_7, PersonId, right_to_translation, penal_order) :-
    (   person_status(PersonId, suspect)
    ;   person_status(PersonId, accused)
    ),
    person_document(PersonId, penal_order),
    \+ proceeding_matter(PersonId, minor_offence),
    \+ person_language(PersonId, dutch).

%% has_right(_art260_5, PersonId, _right_to_translation, _summons)
%
% Article 260(5) Dutch Code of Criminal Procedure
%
% If the suspect does not or insufficiently master the Dutch language, a written translation of the summons shall be provided to him without delay, or
% he shall be informed in writing, in a language understandable to him, of the place, date and time at which the accused must appear at the hearing,
% as well as a brief description of the offence and the communications referred to in paragraph 3, second sentence, and paragraph 4.
has_right(art260_5, PersonId, right_to_translation, summons) :-
    person_status(PersonId, suspect),
    proceeding_matter(PersonId, summoned_court),
    \+ person_language(PersonId, dutch).

%% has_right(_art275_1, PersonId, _right_to_interpretation, _hearing)
%
% Article 275(1) Dutch Code of Criminal Procedure
%
% If a defendant is not or is not sufficiently fluent in the Dutch language, the hearing shall not be continued without the assistance of an interpreter.
% In cases where the assistance of an interpreter is requested, that which has been said or read out and has not been interpreted for the defendant shall
% not be taken into account to his detriment.
has_right(art275_1, PersonId, right_to_interpretation, hearing) :-
    person_status(PersonId, accused),
    proceeding_matter(PersonId, court_hearing),
    \+ person_language(PersonId, dutch).

%% has_right(_art366_4, PersonId, _right_to_translation, _judgement)
%
% Article 366(4) Dutch Code of Criminal Procedure
%
% If the accused has no or insufficient command of the Dutch language, he shall also be provided with a written translation of the notification
% [of the judgment issued in the absence of the accused] in a language he understands.
has_right(art366_4, PersonId, right_to_translation, judgement) :-
    person_status(PersonId, accused),
    person_document(PersonId, judgement),
    \+ person_language(PersonId, dutch).

%% has_right(_art404_1, PersonId, _right_to_appeal, _judgement)
%
% Article 404(1-2) Dutch Code of Criminal Procedure
%
% 1. Appeals may be filed against judgments concerning serious offences, rendered by the District Court as final judgment or in the course of the hearing,
% by the public prosecutor with the court which rendered the judgment, and by the defendant who was not acquitted of the entire indictment.
% 2. Appeal may be filed against judgments concerning minor offences, rendered by the District Court as final judgment or in the course
% of the hearing, by the public prosecutor with the court which rendered the judgment, and by the suspect who was not acquitted of the
% entire indictment, unless in this regard in the final judgment:
% a. under application of Article 9a of the Criminal Code, a punishment or measure was not imposed, or
% b. no other punishment or measure was imposed than a fine up to a maximum – or, where two or more fines were imposed in the judgment,
% fines up to a joint maximum – of € 50.
has_right(art404_1, PersonId, right_to_appeal, judgement):-
    person_document(PersonId, judgement),
    proceeding_matter(PersonId, serious_offence),
    \+ person_status(PersonId, acquitted),
    \+ exception(has_right(art404_2, PersonId, right_to_appeal, judgement), _).

exception(has_right(art404_1, PersonId, right_to_appeal, judgement), art404_2_a) :-
    person_punishment(PersonId, not_imposed).

exception(has_right(art404_1, PersonId, right_to_appeal, judgement), art404_2_b) :-
    person_punishment(PersonId, fine_max_50_euros).

%% has_right(_art275_1, PersonId, _right_to_interpretation, _hearing)
%
% Article 30 - Surrender of Persons Act
%
% Articles 260, paragraph 1, 268, 269, paragraph 5, 271, 272, 273, paragraph 3, 274 through 277, 279, 281, 286, 288, paragraph 4, 289, paragraphs 1 and 3,
% 290 through 301, 318 through 322, 324 through 327, 328 through 331, 345, paragraph 1, 346, 357, 362, 363 and 365, paragraphs 1 through 5 of the Code of
% Criminal Procedure shall apply accordingly.
%
% $
% Article 30 of the Surrender of Persons Act includes references to various articles of the Code of Criminal Procedure,
% among which Articles 274, 275 and 276 thereby extending the obligation to provide the assistance of an interpreter to surrender proceedings.
% $
has_right(art275_1, PersonId, right_to_interpretation, hearing) :-
    person_status(PersonId, requested),
    proceeding_matter(PersonId, court_hearing),
    \+ person_language(PersonId, dutch).

%% right_property(_art3, PersonId, _quality, _)
%
% Article 3 Sworn Interpreters and Translators Act
%
% In order to be eligible for registration, the interpreter or translator must meet the requirements laid down by or pursuant to an order in council with regard to the following competencies:
right_property_scope(art3, [art23_4, art32a_1]).
right_property(art3, PersonId, quality, interpreter).
right_property(art3, PersonId, quality, translator).

%% auxiliary_right(_art1_4, PersonId, _cost, _state)
%
% Article 1(4) The Criminal Cases Fees Act
%
% If the judicial authorities, whether or not at the request of the accused, have ordered the summoning and assistance of an interpreter or translator,
% or if the assistance of an interpreter has been granted on the basis of Article 28, fifth paragraph, of the Code of Criminal Procedure, these fees shall also be borne by the State treasury.
auxiliary_right_scope(art1_4, [art23_4, art32a_1]).

auxiliary_right(art1_4, PersonId, cost, state).

%% right_property(_art29, PersonId, _quality, _confidentiality)
%
% Article 29 Sworn Interpreters and Translators Act
%
% The sworn interpreter shall observe professional secrecy with regard to any information obtained in the course of his activities which he knows or
% should reasonably suspect to be of a confidential nature, except in so far as any legal requirement requires him to disclose it or the need to disclose it arises from his activities.
right_property_scope(art29, [art23_4, art32a_1]).
right_property(art29, PersonId, quality, confidentiality).

%% right_property(_art32, PersonId, _quality, _confidentiality)
%
% Article 32 Sworn Interpreters and Translators Act
%
% The sworn translator shall observe professional secrecy with regard to any information obtained in the course of his activities which he knows or should reasonably suspect to
% be of a confidential nature, except in so far as any legal requirement requires him to disclose it or the need to disclose it arises from his activities.
right_property_scope(art32, [art23_4, art32a_1]).
right_property(art32, PersonId, quality, confidentiality).

