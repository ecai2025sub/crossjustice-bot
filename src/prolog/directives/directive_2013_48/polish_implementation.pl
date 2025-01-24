:- module(directive_2013_48_pl, [has_right/5, auxiliary_right/5, auxiliary_right_checked/5, right_property/5, right_property_checked/5, explain/2]).

:- include('./../../utils.pl').

% Importable functor
has_right(Right, pl, Article, PersonId, Matter) :-
    has_right(Article, PersonId, Right, Matter).

%%%% Code of Criminal Procedure %%%%

%% has_right(_art6, PersonId, _right_to_defence, _access_lawyer)
%
% Article 6 code of criminal procedure
%
% The accused has the right to defend himself, including the use of a defence counsel.
% The accused should be advised of this right.
has_right(art6, PersonId, right_to_defence, access_lawyer) :-
    person_status(PersonId, accused).

%% has_right(_art73_1, PersonId, _right_to_access_lawyer, _private_communication)
%
% Article 73(1-3) code of criminal procedure
%
% 1. An accused, who is detained on remand, may communicate with his defence counsel without the presence of other persons and by
% correspondence.
has_right(art73_1, PersonId, right_to_access_lawyer, private_communication):-
    person_status(PersonId, accused),
    proceeding_matter(PersonId, detention_on_remand).

%2. In preparatory proceedings, the public prosecutor, allowing the communication, may, in a particularly justified case, make a
%restriction that he personally, or another person authorised by him, will be present at the time.
%3. If the interest of preparatory proceedings so requires, in a particularly justified case the public prosecutor may order that
%the correspondence of the accused with his defence counsel be controlled.
%4. Restrictions mentioned in § 2 and 3 may not last longer or be imposed later than fourteen days of the date, when the suspect
%was detained on remand.

%% has_right(_art87_1, PersonId, _right_to_defence, _appoint_lawyer)
%
% Article 87(1,2 and 3) code of criminal procedure
%
% 1. A party other than the accused may appoint an attorney.
has_right(art87_1, PersonId, right_to_defence, appoint_lawyer) :-
    \+ person_status(PersonId, accused).

%% has_right(_art156_5, PersonId, _right_to_access_materials, _preparatory_proceedings)
%
% Article 156(5) code of criminal procedure
%
% If there is no need for ensuring the correct course of proceedings or protecting an important state interest - in the course
% of preparatory proceedings - parties, defence counsels, attorneys and legal representatives are allowed to review case files,
% make certified copies or copies or may obtain certified copies or copies of case files; this right is also vested in the parties
% after the conclusion of preparatory proceedings. The agency conducting preparatory proceedings rules with respect to granting
% access to case files, making certified copies and copies by issuing orders. If the aggrieved party is denied access to case files,
% he should be informed about the possibility of obtaining such access in another date. After the suspect or his defence counsel
% have been notified about the possibility of being acquainted, at the end of preparatory proceedings, with the material gathered
% in its course, the aggrieved party, his attorney or legal representative cannot be denied access to case files or the right of
% making copies or certified copies or obtaining copies or certified copies. In exceptional cases, with the consent of the public
% prosecutor, access to the files of preparatory proceedings may be granted to other persons. The public prosecutor may grant
% access to data in electronic version.
has_right(art156_5, PersonId, right_to_access_materials, preparatory_proceedings):-
    person_status(PersonId, suspect),
    proceeding_matter(PersonId, preparatory_proceedings).

%% has_right(_art245_1, PersonId, _right_to_access_lawyer, _pretrial)
%
% Article 245(1) code of criminal procedure
%
% 1. The arrestee, at his request, should be allowed to contact an advocate or legal counsel in an available form and have a direct
% conversation with him. In exceptional cases, justified by particular circumstances, the arresting authority may reserve that it will
% be present during said conversation.
has_right(art245_1, PersonId, right_to_access_lawyer, pretrial):-
    person_status(PersonId, arrested),
    person_request_submitted(PersonId, defence_counsel).

%% auxiliary_right(_art246_1, PersonId, _remedy, _arrest)
%
% Article 246.1 code of criminal procedure
%
% 1. An arrestee may submit an interlocutory appeal, in which he may demand that the grounds, legality
% and propriety of the arrest be examined.
auxiliary_right_scope(art246_1, [art245_1]).

auxiliary_right(art246_1, PersonId, remedy, arrest) :-
    person_status(PersonId, arrested).

% 2. The appeal is immediately referred to the district court having the jurisdiction over the place
% where the arrest was made or the proceedings are conducted.
% 3. If the arrest is found groundless or unlawful, the court orders the immediate release of the
% arrestee.
% 4. If the arrest is found groundless, unlawful or improper, the court notifies the public prosecutor
% thereof and the supervisory body of the arresting authority.
% 5. If appeals have been lodged both against an arrest and an order of detention on remand, they may
% be considered by the court jointly.

%% auxiliary_right(_art252_1, PersonId, _remedy, _preventive_measure)
%
% Article 252(1) code of criminal procedure
%
% 1. A decision concerning preventive measures is subject to appeal in accordance with general
% principles, unless the law provides otherwise.
auxiliary_right_scope(art246_1, [art215_2, art245_1]).

auxiliary_right(art252_1, PersonId, remedy, preventive_measure).

% 2. The public prosecutor’s decision to order a preventive measure is subject to interlocutory appeal,
% which should be filed with the district court in whose judicial circuit the proceedings are conducted.
% 3. Interlocutory appeals against decisions concerning preventive measures are considered by the court
% without delay, however an interlocutory appeal against the decision imposing detention on remand is
% considered not later than seven days of the appeal being handed over to the court together with
% indispensable case files.

%% has_right(_art261, PersonId, _right_to_inform, _)
%
% Article 261(1, 2) code of criminal procedure
%
% 1. The court immediately notifies the next of kin of the accused, or the person indicated by the
% accused, of the decision on detention on remand.
% 2. Upon the request of the accused, another person may be notified in addition to or instead of the
% person referred to in § 1.
has_right(art261_1, PersonId, right_to_inform, next_of_kin) :-
    person_status(PersonId, accused),
    proceeding_matter(PersonId, detention_on_remand).

has_right(art261_2, PersonId, right_to_inform, another_person) :-
    person_status(PersonId, accused),
    proceeding_matter(PersonId, detention_on_remand),
    person_request_submitted(PersonId, new_notice).

% 2a. The court notifies the agency conducting proceedings against the accused in another case of the
% imposition of detention on remand, if it has acquired knowledge of said proceedings.
% The court instructs the accused of the content of Article 75 § 1.
% 3. The court immediately notifies the employer, the school or another higher educational
% establishment, and - in case of a soldier - the commanding officer of the accused of the detention
% on remand. If the accused is an entrepreneur or a non-employee member of a management board of a
% business enterprise, the court, upon his request notifies the manager of the enterprise.

%% has_right(_art300, PersonId, _right_to_information, _lawyer)
%
% Article 300
%
% Prior to the first interrogation, the suspect should be instructed of his rights: (…) to be assisted
% by defence counsel, including the right to request the appointment of the defence counsel ex officio
% in the case specified in Article 78 and to be acquainted,
has_right(art300, PersonId, right_to_information, lawyer) :-
    person_status(PersonId, suspect),
    \+ proceeding_matter(PersonId, interrogation).

%% has_right(_art301, PersonId, _right_to_access_lawyer, _interrogation)
%
% Article 301
%
% At the request of the suspect, the interrogation should be conducted with the participation of the
% appointed defence counsel. Failure of defence counsel to appear does not halt the examination.
has_right(art301, PersonId, right_to_access_lawyer, interrogation):-
    person_status(PersonId, suspect),
    proceeding_matter(PersonId, interrogation),
    person_request_submitted(PersonId, defence_counsel).

%% has_right(_art313, PersonId, _right_to_information, _rights)
%
% Article 313(1-4) code of criminal procedure
%
% § 1. If information existing at the moment of initiating the investigation or collected during the investigation,
% sufficiently justifies the suspicion that the offence was committed by a specific individual, the decision to present
% charges is drawn up and announced to the suspect. The suspect is interrogated, unless the announcement of the decision
% and the examination of the suspect are not possible because he is in hiding or absent from the country.
% § 2. The decision to present charges indicates the suspect, an exact description of the offence with which he is charged
% and its legal qualification.
% § 3. The suspect may, until such time that he is notified of the date to examine files gathered during the investigation,
% demand that the grounds for the charges be explained to him verbally and the statement of reasons be drawn up in writing.
% The suspect should be advised of these rights. The statement of reasons is served upon the suspect and the appointed defence
% counsel within 14 days.
% § 4. The statement of reasons should clarify in particular on what facts and evidence the charges are based.

person_status(PersonId, art313):-
%    person_status(PersonId, suspect),
    person_status(PersonId, raise_suspicion).

has_right(art313, PersonId, right_to_information, rights):-
    person_status(PersonId, art313).

has_right(art313, PersonId, right_to_information, accusation):-
    person_status(PersonId, art313).

%% has_right(_art315_1, PersonId, _right_to_request, _conduct_investigation_procedure)
%
% Article 315(1) code of criminal procedure
%
% 1. A suspect and his defence counsel, as well as the aggrieved party and his attorney may submit requests that certain procedures
% of the investigation be conducted.
has_right(art315_1, PersonId, right_to_request, conduct_investigation_procedure):-
    person_status(PersonId, suspect),
    person_request_submitted(PersonId, conduct_investigation_procedure).

%% has_right(_art315_2, PersonId, _right_to_participate, _trial)
%
% Article 315(2) code of criminal procedure
%
% 2. A party, who submitted a request, his defence counsel or attorney cannot be denied the right to participate in the procedure,
% if they so demand. Article 318, the second sentence, applies accordingly.
has_right(art315_2, PersonId, right_to_participate, trial):-
    person_status(PersonId, party_to_proceeding),
    person_request_submitted(PersonId, participate_investigation).

%% has_right(_art317_1, PersonId, _right_to_participate, _investigation)
%
% Article 317(1) code of criminal procedure
%
% 1. Parties and their defence counsels or attorneys, if such have already been appointed, should also, upon their demand,
% be allowed to participate in other procedures of the investigation.
has_right(art317_1, PersonId, right_to_participate, investigation):-
    person_status(PersonId, party_to_proceeding),
    person_request_submitted(PersonId, participate_investigation),
    \+ exception(has_right(article317_1, PersonId, right_to_participate, investigation), _).

%% exception(_has_right(_art317_1, PersonId, _right_to_participate, _investigation), _)
%
% Article 317(2) code of criminal procedure
%
% 2. In a particularly justified case, the public prosecutor may, by way of a decision, deny participation in a procedure due to the
% important interests of the investigation or decline to bring the accused in custody if this would cause serious difficulties.
exception(has_right(art317_1, PersonId, right_to_participate, investigation), _):-
    authority_decision(PersonId, deny_participation).

%Article 318 code of criminal procedure
%If an expert opinion or an opinion of a scientific or specialised institution is admitted, the suspect and his defence counsel,
%as well as the aggrieved party and his attorney receive a copy of the decision admitting evidence and they are allowed to participate
%in the examination of experts and to review the opinion, if it was given in writing. A suspect in custody is not brought to the court,
%if it would cause serious difficulties.

%% has_right(_art370_1, PersonId, _right_to_defence, _ask_questions)
%
% Article 370(1) code of criminal procedure
%
% 1. After an examined individual, summoned by the presiding judge, has expressed himself freely,
% pursuant to Article 171 § 1 the following persons may ask questions in the following order:t he
% public prosecutor, the subsidiary prosecutor, the subsidiary prosecutor’s attorney, the private
% prosecutor, the private prosecutor’s attorney, the expert, the defence counsel, the accused and the
% members of the adjudicating panel.
has_right(art370_1, PersonId, right_to_defence, ask_questions) :-
    proceeding_matter(PersonId, summoned_court),
    proceeding_matter(PersonId, interrogation).

%% auxiliary_right(_art438_2, PersonId, _remedy, _judgement)
%
% Article 438(2) code of criminal procedure
%
% The judgment is reversed or changed if it is found that:
% 2) the provisions of procedural law were violated, if this might have affected the contents of the judgment.
auxiliary_right_scope(art438_2, [art6, art73_1, art87_1, art156_5, art215_2, art245_1, art261_1, art261_2, art300, art301, art313, art315_1, art315_2, art317_1, art517, art612_1, art612_2]).

auxiliary_right(art438_2, PersonId, remedy, judgement) :-
    proceeding_matter(PersonId, violation_procedural_law).

%% has_right(_art517, PersonId, _right_to_access_lawyer, _accelerated_proceedings)
%
% Article 517(1 and 2) code of criminal procedure
%
% 1. In order to make it possible for the accused to use the assistance of a defence counsel, in accelerated proceedings advocates and
% legal advisors shall be on duty in the time and place determined in separate provisions.
% 2. The Minister of Justice shall determine by way of a regulation the manner of ensuring the assistance of a defence counsel to the
% accused, and the possibility of appointing one in accelerated proceedings, including the organisation of on-call duties referred to
% in § 1, bearing in mind the need for the proper course of the accelerated proceedings and the necessity of ensuring the possibility
% of appointing a defence counsel to the accused.
has_right(art517, PersonId, right_to_access_lawyer, accelerated_proceedings):-
    person_status_poland(PersonId, accused),
    proceeding_type(PersonId, accelerated_proceedings).

%% has_right(_art607_1a, PersonId, _right_to_translation, _document_translation)
%
% Article 607(1-2) code of criminal procedure
%
% 1. The court adjudicates with respect to the surrender and detention on remand in a hearing, in which the public prosecutor
% and the defence counsel may participate.
% 1a. When notifying the prosecuted person of the hearing referred to in § 1, the court serves the European warrant together
% with the translation obtained from the public prosecutor. If due to particular circumstances it is not possible to prepare
% the translation before the hearing, the translation is ordered by the court. The court may limit itself to the notification
% of the prosecuted person of the contents of the European warrant if it does not hinder the realisation of this person’s rights,
% including those mentioned under § 2.
has_right(art607_1a, PersonId, right_to_translation, document_translation):-
    proceeding_type(PersonId, europeanArrestWarrant),
    proceeding_language(PersonId, Language),
    \+ person_understands(PersonId, Language).

%% has_right(_article612_, PersonId, _right_to_information, _)
%
% Article 612(1-2) code of criminal procedure
%
% 1. A locally competent consular office of a given State, and, in the absence of a consular office,
% a diplomatic mission, is notified immediately, at the request of its citizen, of the imposition of
% detention on remand on such a person.
% 2. In case of the arrest of a citizen of a foreign State, the arrestee, at his request, is allowed to contact a
% locally competent consular office or diplomatic mission in any available form, and in case of a stateless
% person - a diplomatic mission of a State, where this person permanently resides.
has_right(art612_1, PersonId, right_to_information, consul):-
    person_status(PersonId, detained_on_remand),
    person_request_submitted(PersonId, communicate_consul).

has_right(art612_2, PersonId, right_to_information, consul):-
    person_status(PersonId, arrested),
    person_request_submitted(PersonId, communicate_consul),
    \+ person_nationality(PersonId, polish).

has_right(art612_2, PersonId, right_to_information, diplomat):-
    person_status(PersonId, arrested),
    person_request_submitted(PersonId, diplomat),
    \+ person_nationality(PersonId, polish).

has_right(art612_2, PersonId, right_to_information, diplomat):-
    person_status(PersonId, arrested),
    person_request_submitted(PersonId, diplomat),
    person_nationality(PersonId, stateless).

%%%% Enforcement Proceedings Code %%%%

%% has_right(_art215, PersonId, _right_to_communication, _)
%
% Article 215(1) enforcement proceedings code
%
% 1. A detained person has a right to communicate with a defence lawyer or attorney, who is a an advocate or legal advisor
% and a representative who is not an advocate or legal adviser, who has been approved by the President of the Chamber of the
% European Court of Human Rights to represent the convicted person before this Tribunal, in the absence of other persons and by
% correspondence . If the authority at whose disposal the detainee is still staying reserves the presence of himself or an authorized
% person upon seeing - the visit shall take place in the manner indicated by that authority.
% 1a. If a foreign national is temporarily arrested, he / she has the right to communicate with the competent consular post or
% diplomatic mission, and if the person who is temporarily arrested is a person without any citizenship - with a representative
% of the country in which he / she has permanent residence, on the terms referred to in § 1.
has_right(art215_1, PersonId, right_to_communicate, access_lawyer):-
    person_status(PersonId, detained).

has_right(art215_1a, PersonId, right_to_communicate, consul):-
    person_status(PersonId, arrested),
    proceeding_location(PersonId, Country),
    \+ person_nationality(PersonId, Country).

has_right(art215_1a, PersonId, right_to_communicate, representativeCountryResidence):-
    proceeding_type(PersonId, europeanArrestWarrant),
    person_status(PersonId, arrested),
    person_nationality(PersonId, none).

%% has_right(_art215_2, PersonId, _right_to_prepare_defence, _pretrial)
%
% Article 215(2) enforcement proceedings code
%
% 2. A detainee should be allowed to prepare for defence.
has_right(art215_2, PersonId, right_to_prepare_defence, pretrial):-
    person_status(PersonId, detained).