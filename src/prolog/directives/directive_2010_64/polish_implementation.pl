:- module(directive_2010_64_pl, [has_right/5, auxiliary_right/5, auxiliary_right_checked/5, right_property/5, right_property_checked/5, explain/2]).

:- include('./../../utils.pl').

% Importable functor
has_right(Right, pl, Article, PersonId, Matter) :-
    has_right(Article, PersonId, Right, Matter).

%according to doctrine, the 'suspect', as interpreted according to Directive, does not have any rights

% Article 71(1-3) - Fully implemented
% 1. A suspect is a person, with regard to whom a decision presenting charges was issued,
% or who, without the issuance of such a decision, was informed about the charges in connection
% with his interrogation in the capacity of a suspect.
person_status_poland(PersonId, suspect):-
    person_document(PersonId, charge);
    person_status(PersonId, informed_about_charge).

%2. An accused is a person, against whom an indictment was submitted to a court, and also a person,
%with regard to whom a public prosecutor has filed a request referred to in Article 335 § 1 or a request
%for a conditional discontinuation of proceedings.
person_status_poland(PersonId, accused):-
    person_document(PersonId, indictment);
    person_document(PersonId, request_discontinuation_proceedings).

%3. If the term “accused” is used in this Code with a general meaning, relevant provisions apply also to the suspect.
person_status_poland(PersonId, accused):-
    person_status_poland(PersonId, suspect).

% TODO - Change suspect definition!

%% has_right(_article72_1, PersonId, _right_to_interpretation, _trial)
%
% Article 72.1 code of criminal procedure
%
% 1. An accused, who does not have a sufficient command of Polish, is entitled to the gratuitous help of an interpreter (translator).

has_right(article72_1, PersonId, right_to_interpretation, trial):-
    proceeding_language(PersonId, polish),
    \+ person_language(PersonId, polish).

%% auxiliary_right(_article204_1, PersonId, _assistance, _deaf)
%
% Article 204.1 code of crminial procedure
%
% 1. An interpreter (translator) is summoned if there is a need for the examination of:
% 1) a person, who is deaf or mute and written communication is not sufficient,

auxiliary_right(article204_1, [article72_1, art72_2, article244_2, article607l_4]).

auxiliary_right(article204_1, PersonId, assistance, deaf) :-
    person_condition(PersonId, hearingImpediment),
    written_communication_not_sufficient(PersonId, interpreter).

%% auxiliary_right(_article204_1, PersonId, _assistance, _mute)
%
% Article 204.1 code of crminial procedure
%
% 1. An interpreter (translator) is summoned if there is a need for the examination of:
% 1) a person, who is deaf or mute and written communication is not sufficient,

auxiliary_right(article204_1, PersonId, assistance, mute) :-
    person_condition(PersonId, speechImpediment),
    written_communication_not_sufficient(PersonId, interpreter).

%2) a person who has no command of Polish.

%% has_right(_article204_2, PersonId, _right_to_translation, _documents)
%
% Article 204.2 code of criminal procedure
%
% 2. An interpreter (translator) should also be summoned if there is a need to translate a document drawn up 
% in a foreign language to Polish or vice versa or to familiarise a party to the proceedings with the content of the evidence.

has_right(article204_2, PersonId, right_to_translation, documents):-
    proceeding_language(PersonId, Language),
    \+ person_understands(PersonId, Language),
    (   person_document(PersonId, translation_needed)
    ;   familiarise_with_evidence_content(PersonId, translation)
    ).

%% has_right(_article244_2, PersonId, _right_to_interpretation, _arrest)
%
% Article 244.2-5 code of criminal procedure
%
% 2. The arrestee is immediately informed of the reasons for the arrest and of his rights,
% including the right to use the assistance of an advocate or legal counsel and a gratuitous help of an interpreter,
% if the arrestee does not have a sufficient command of Polish, to make statements and to refuse making statements,
% to obtain copy of an arrest report, to have access to medical first aid, as well as of his rights indicated in
% Article 245, Article 246 § 1 and Article 612 § 2 and of the contents of Article 248 § 1 and 2.
% The arrestee’s explanations should also be heard.

has_right(article244_2, PersonId, right_to_interpretation, arrest):-
    proceeding_language(PersonId, polish),
    proceeding_matter(PersonId, arrest),
    \+ person_language(PersonId, polish).

%% has_right(_art72_2, PersonId, _right_to_interpretation, _lawyer)
%
% Article 72.2 code of criminal procedure
%
% Upon request of the accused or his defence counsel, the interpreter (translator) should also be summoned in order
% to assist in communication between the accused and defence counsel in connection with any step (action) in proceedings,
% in which the accused is entitled to participate.

has_right(art72_2, PersonId, right_to_interpretation, lawyer):-
    lawyer_language(PersonId, Language),
    \+ person_language(PersonId, Language).

% TODO should we add person_request_submitted(PersonId, lawyer)? Does this apply without the request?

%% auxiliary_right(_article201, PersonId, _remedy, _quality)
%
% Article 204.3 code of criminal procedure
% The provisions concerning expert witnesses apply accordingly to interpreters (translators).
% This is quite an interpretative leap, it is according to doctrine (sometimes) but not the law?
% Article 201 - Partially implemented
% If the expert witness’s statement is incomplete, unclear or contradictory or if there are contradictions between
% different statements issued in the same case, the court may summon the same experts again or appoint new ones.

auxiliary_right_scope(article201, [article72_1, art72_2, article607l_1a, article607l_4, article244_2, article204_2]).

auxiliary_right(article201, PersonId, remedy, quality) :-
    quality_not_sufficient(PersonId, interpreter).

auxiliary_right(article201, PersonId, remedy, quality) :-
    quality_not_sufficient(PersonId, document_translation).

%% has_right(_article607l_4, PersonId, _right_to_interpretation, _europeanArrestWarrant)
%
% Article 607l.4 code of criminal procedure
%
% The Minister of Justice shall define by way of a regulation the form of the instruction for a person requested by a European warrant,
% informing him of his rights in case of arrest: to obtain information on the contents of the warrant, [...], as well as of the rights
% specified in in § 3, in Article 72 § 1, Article 78 § 1, Article 261 § 1, 2 and 2a, Article 612 and of the contents of Article 607k § 3
% and 3a, bearing in mind also the necessity of making the instruction comprehensible to the persons not assisted by an attorney.

has_right(article607l_4, PersonId, right_to_interpretation, europeanArrestWarrant):-
    proceeding_type(PersonId, europeanArrestWarrant),
    proceeding_language(PersonId, Language),
    \+ person_language(PersonId, Language).

%[according to doctrine this exists, although the article does not express it clearly]

%% has_right(_article72_1, PersonId, _right_to_translation, _document_translation)
%
% Article 72.1 code of criminal procedure
%
% 1. An accused, who does not have a sufficient command of Polish, is entitled to the gratuitous help of an interpreter (translator).

has_right(article72_1, PersonId, right_to_translation, document_translation):-
    proceeding_language(PersonId, polish),
    person_document(PersonId, translation_needed),
    \+ person_language(PersonId, polish).

person_document(PersonId, translation_needed):-
    authority_decision(PersonId, translation_needed).

%% person_document(PersonId, _translation_needed)
%
% Article 72.3 code of criminal procedure
%
% 3. The decision presenting, supplementing or changing charges, an indictment, as well as a judgment which may be subject to
% an appeal or which ends the proceedings must be served upon the accused referred to in § 1 with a translation.
% With the consent of the accused, it is sufficient to announce the translated judgment ending the proceedings,
% if it is not subject to appeal.

person_document(PersonId, translation_needed):-
    person_document(PersonId, decision_supplementing_charge).

person_document(PersonId, translation_needed):-
    person_document(PersonId, decision_changing_charge).

person_document(PersonId, translation_needed):-
    person_document(PersonId, charge).

person_document(PersonId, translation_needed):-
    person_document(PersonId, indictment).

person_document(PersonId, translation_needed):-
    person_document(PersonId, judgement).
%[according to doctrine, there is a problem with judges decisions that are not subject to appeal or ending proceedings, do we care? There is a general clause!]

%% has_right(_article607l_1a, PersonId, _right_to_translation, _document_translation)
%
% Article 607l.1-1a code of criminal procedure
%
% 1. The court adjudicates with respect to the surrender and detention on remand in a hearing, in which the public prosecutor
% and the defence counsel may participate.
% 1a. When notifying the prosecuted person of the hearing referred to in § 1, the court serves the European warrant together
% with the translation obtained from the public prosecutor. If due to particular circumstances it is not possible to prepare
% the translation before the hearing, the translation is ordered by the court. The court may limit itself to the notification
% of the prosecuted person of the contents of the European warrant if it does not hinder the realisation of this person’s rights,
% including those mentioned under § 2.

has_right(article607l_1a, PersonId, right_to_translation, document_translation):-
    proceeding_type(PersonId, europeanArrestWarrant),
    proceeding_language(PersonId, Language),
    \+ person_understands(PersonId, Language).

%% auxiliary_right(_article618_7, PersonId, _cost, _state)
%
% Article 618.1.7 code of criminal procedure
%
% 1. The expenses of the State Treasury include in particular expenses incurred in connection with:
% 7) fees of witnesses and interpreters (translators)

auxiliary_right_scope(article618_7, [article72_1, art72_2, article607l_1a, article607l_4, article244_2, article204_2]).

auxiliary_right(article618_7, PersonId, cost, state).

% TODO should we add 302(2 and 3) [302.2 only applies to suspect?] and change it accordingly to our right? Appeal necessary for 438, person_challenges is enough or not?
