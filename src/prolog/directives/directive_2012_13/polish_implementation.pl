
:- module(directive_2012_13_pl, [has_right/5, auxiliary_right/5, auxiliary_right_checked/5, right_property/5, right_property_checked/5, explain/2]).

:- include('./../../utils.pl').

has_right(Right, pl, Article, PersonId, Matter) :-
    has_right(Article, PersonId, Right, Matter).

%% has_right(_art300_1, PersonId, _right_to_information, _)
%
% Article 300(1) code of criminal procedure
%
% Prior to the first interrogation, the suspect should be instructed of his rights: to give or to
% refuse giving testimony or to decline to answer questions, to be informed of the charges and any
% changes thereof, to submit requests for investigatory acts to be undertaken in investigation or
% inquiry, to be assisted by defence counsel, including the right to request the appointment of
% the defence counsel ex officio in the case specified in Article 78 and the content of Article 338b
% and to be acquainted, at the end of the proceedings, with the material gathered in its course, as
% well as of the rights defined under Article 23a § 1, Article 72 § 1, Article 156 § 5 and 5a,
% Article 301, Article 335, Article 338a and Article 387 and of the duties and consequences mentioned
% in Article 74, Article 75, Article 133 § 2, Article 138 and Article 139. This instruction should be
% given to the suspen writing, who acknowledges receipt with his signature.

has_right(art300_1, PersonId, right_to_information, refuse_testimony) :-
    person_status(PersonId, suspect),
    \+ proceeding_matter(PersonId, interrogation).

has_right(art300_1, PersonId, right_to_information, decline_answer_questions) :-
    person_status(PersonId, suspect),
    \+ proceeding_matter(PersonId, interrogation).

has_right(art300_1, PersonId, right_to_information, accusation) :-
    person_status(PersonId, suspect),
    \+ proceeding_matter(PersonId, interrogation).

has_right(art300_1, PersonId, right_to_information, changes) :-
    person_status(PersonId, suspect),
    \+ proceeding_matter(PersonId, interrogation).

has_right(art300_1, PersonId, right_to_information, request_investigation) :-
    person_status(PersonId, suspect),
    \+ proceeding_matter(PersonId, interrogation).

has_right(art300_1, PersonId, right_to_information, lawyer) :-
    person_status(PersonId, suspect),
    \+ proceeding_matter(PersonId, interrogation).

has_right(art300_1, PersonId, right_to_information, access_materials) :-
    person_status(PersonId, suspect),
    \+ proceeding_matter(PersonId, interrogation).

%TODO - check for the rights to individual articles.

%% auxiliary_right(_art300_1i, PersonId, _form, _written)
%
% Article 300(1) code of criminal procedure
%
% Prior to the first interrogation, the suspect should be instructed of his rights: to give or to
% refuse giving testimony or to decline to answer questions, to be informed of the charges and any
% changes thereof, to submit requests for investigatory acts to be undertaken in investigation or
% inquiry, to be assisted by defence counsel, including the right to request the appointment of
% the defence counsel ex officio in the case specified in Article 78 and the content of Article 338b
% and to be acquainted, at the end of the proceedings, with the material gathered in its course, as
% well as of the rights defined under Article 23a § 1, Article 72 § 1, Article 156 § 5 and 5a,
% Article 301, Article 335, Article 338a and Article 387 and of the duties and consequences mentioned
% in Article 74, Article 75, Article 133 § 2, Article 138 and Article 139. This instruction should be
% given to the suspen writing, who acknowledges receipt with his signature.
auxiliary_right_scope(art300_1i, [art300_1]).

auxiliary_right(art300_1i, PersonId, form, written).

%% has_right(_art244_2, PersonId, _right_to_information, _)
%
% Article 244(2) code of criminal procedure
%
% The arrestee is immediately informed of the reasons for the arrest and of his rights, including the
% right to use the assistance of an advocate or legal counsel and a gratuitous help of an interpreter,
% if the arrestee does not have a sufficient command of Polish, to make statements and to refuse making
% statements, to obtain copy of an arrest report, to have access to medical first aid, as well as of
% his rights indicated in Article 245, Article 246 § 1 and Article 612 § 2 and of the contents of
% Article 248 § 1 and 2. The arrestee’s explanations should also be heard.

has_right(art244_2, PersonId, right_to_information, accusation) :-
    person_status(PersonId, arrested).

has_right(art244_2, PersonId, right_to_information, lawyer) :-
    person_status(PersonId, arrested).

has_right(art244_2, PersonId, right_to_information, interpretation) :-
    person_status(PersonId, arrested),
    \+ person_language(PersonId, polish).

has_right(art244_2, PersonId, right_to_information, statements) :-
    person_status(PersonId, arrested).

has_right(art244_2, PersonId, right_to_information, receive_copy_arrestWarrant) :-
    person_status(PersonId, arrested).

has_right(art244_2, PersonId, right_to_information, medical_assistance) :-
    person_status(PersonId, arrested).

has_right(art244_2, PersonId, right_to_information, right_to_be_heard) :-
    person_status(PersonId, arrested).

% TODO - check individual rights articles

%% has_right(_article263_8, PersonId, _right_to_information, _)
%
% Article 263(8) code of criminal procedure
%
% The Minister of Justice shall define by way of a regulation the form of instruction about the rights of
% the accused in case of imposition of detention on remand: to give explanations, to refuse to give
% testimony or answer questions, to obtain information on the charges, to review case files in the part
% containing evidence indicated in the motion to order detention on remand, to have access to medical first
% aid, as well as of the rights indicated in Article 72 § 1, Article 78 § 1, Article 249 § 5, Article 252,
% Article 254 § 1 i 2, Article 261 § 1, 2 and 2a and Article 612 § 1, bearing in mind also the necessity of
% making the instruction comprehensible to the persons not using the assistance of an attorney.

has_right(art263, PersonId, right_to_information, accusation):-
    person_status(PersonId, accused),
    proceeding_matter(PersonId, detention_on_remand).

has_right(art263, PersonId, right_to_information, give_explanation):-
    person_status(PersonId, accused),
    proceeding_matter(PersonId, detention_on_remand).

has_right(art263, PersonId, right_to_information, refuse_testimony):-
    person_status(PersonId, accused),
    proceeding_matter(PersonId, detention_on_remand).

has_right(art263, PersonId, right_to_information, review_case_files):-
    person_status(PersonId, accused),
    proceeding_matter(PersonId, detention_on_remand).

has_right(art263, PersonId, right_to_information, medical_assistance):-
    person_status(PersonId, accused),
    proceeding_matter(PersonId, detention_on_remand).

% TODO - check right to individual articles

%% auxiliary_right(_art263_8, PersonId, _language, _comprehensible)
%
% Article 263(8) code of criminal procedure
%
% The Minister of Justice shall define by way of a regulation the form of instruction about the rights of
% the accused in case of imposition of detention on remand: to give explanations, to refuse to give
% testimony or answer questions, to obtain information on the charges, to review case files in the part
% containing evidence indicated in the motion to order detention on remand, to have access to medical first
% aid, as well as of the rights indicated in Article 72 § 1, Article 78 § 1, Article 249 § 5, Article 252,
% Article 254 § 1 i 2, Article 261 § 1, 2 and 2a and Article 612 § 1, bearing in mind also the necessity of
% making the instruction comprehensible to the persons not using the assistance of an attorney.
auxiliary_right_scope(art263, [art263_8]).

auxiliary_right(art263_8, PersonId, language, comprehensible).

%Article 250(3) code of criminal procedure
%The public prosecutor, sending the motion referred to in § 2 together with the case files, instructs the
%suspect of his rights in case of application of detention on remand and at the same time orders that he
%be brought to the court.

%Article 250(3a) code of criminal procedure
%If the detention on remand is imposed in court proceedings, the court instructs the accused of his rights in
%case of application of detention on remand immediately after the announcement or service of the decision on
%the application of this preventive measure.

%% has_right(_article612_2, PersonId, _right_to_information, _)
%
% Article 612(2) code of criminal procedure
%
% In case of the arrest of a citizen of a foreign State, the arrestee, at his request, is allowed to contact a
% locally competent consular office or diplomatic mission in any available form, and in case of a stateless
% person - a diplomatic mission of a State, where this person permanently resides.
has_right(art612_2, PersonId, right_to_information, consul):-
    person_status(PersonId, arrested),
    person_request_submitted(PersonId, communicate_consul),
    \+ person_nationality(PersonId, poland).

has_right(art612_2, PersonId, right_to_information, diplomat):-
    person_status(PersonId, arrested),
    person_request_submitted(PersonId, diplomat),
    \+ person_nationality(PersonId, poland).

has_right(art612_2, PersonId, right_to_information, diplomat):-
    person_status(PersonId, arrested),
    person_request_submitted(PersonId, diplomat),
    person_nationality(PersonId, stateless).

%% has_right(_art248, PersonId, _right_to_limitation_to_deprivation_of_liberty, _)
%
% Article 248(1-2) code of criminal procedure
%
% § 1. The arrestee is released immediately if the reasons for his arrest cease to exist and also if, within 48 hours
% from the arrest by the authorised agency, the arrestee was not surrendered to the jurisdiction of the court with a
% motion to order detention on remand. The arrestee is also released upon the order of the court or the public prosecutor.
% § 2. The arrestee is released if, within 24 hours of being surrendered to the jurisdiction of the court, the motion to
% order detention on remand was not granted.
has_right(art248, PersonId, right_to_limitation_to_deprivation_of_liberty, none) :-
    person_status(PersonId, arrested).

%% has_right(_art607l_4, PersonId, _right_to_information, _europeanArrestWarrant)
%
% Article 607l(4) code of criminal procedure
%
% The Minister of Justice shall define by way of a regulation the form of the instruction for a person requested by
% a European warrant, informing him of his rights in case of arrest: to obtain information on the contents of the warrant,
% to consent to the surrender, to make statements concerning the surrender, to be assisted by a defence counsel, to provide
% explanations and to refuse providing explanations, to review the files in the part concerning the reasons for the arrest,
% to obtain access to the medical first aid, as well as of the rights specified in in § 3, in Article 72 § 1, Article 78 § 1,
% Article 261 § 1, 2 and 2a, Article 612 and of the contents of Article 607k § 3 and 3a, bearing in mind also the necessity
% of making the instruction comprehensible to the persons not assisted by an attorney.

has_right(art607, PersonId, right_to_information, europeanArrestWarrant):-
    proceeding_type(PersonId, europeanArrestWarrant).

% TODO - check right to individual articles

%% auxiliary_right(_art607l_4, PersonId, _right_to_information, _)
%
% Article 607l(4) code of criminal procedure
%
% The Minister of Justice shall define by way of a regulation the form of the instruction for a person requested by
% a European warrant, informing him of his rights in case of arrest: to obtain information on the contents of the warrant,
% to consent to the surrender, to make statements concerning the surrender, to be assisted by a defence counsel, to provide
% explanations and to refuse providing explanations, to review the files in the part concerning the reasons for the arrest,
% to obtain access to the medical first aid, as well as of the rights specified in in § 3, in Article 72 § 1, Article 78 § 1,
% Article 261 § 1, 2 and 2a, Article 612 and of the contents of Article 607k § 3 and 3a, bearing in mind also the necessity
% of making the instruction comprehensible to the persons not assisted by an attorney.
auxiliary_right_scope(art607l_4, [art607]).

auxiliary_right(art607l_4, PersonId, right_to_information, accusation).

auxiliary_right(art607l_4, PersonId, right_to_information, consent_surrender).

auxiliary_right(art607l_4, PersonId, right_to_information, statements).

auxiliary_right(art607l_4, PersonId, right_to_information, lawyer).

auxiliary_right(art607l_4, PersonId, right_to_information, explanations).

auxiliary_right(art607l_4, PersonId, right_to_information, access_materials).

auxiliary_right(art607l_4, PersonId, right_to_information, medical_assistance).

auxiliary_right(art607l_4, PersonId, language, comprehensible).

% TODO - in the transposition tables there is a letter of rights with additional articles, probably needs to be coded?

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

% person_status(PersonId, art313):-
%    person_status(PersonId, suspect),
%    person_status(PersonId, raise_suspicion).

% has_right(art313, PersonId, right_to_information, rights):-
%    person_status(PersonId, art313).

% has_right(art313, PersonId, right_to_information, accusation):-
%    person_status(PersonId, art313).

%Article 338(1) code of criminal procedure
%If the act of indictment meets the formal requirements, the president of the court or the court referendary immediately
%orders that a copy be served upon the accused summoning him to submit evidentiary motions within seven days of the service
%of the act of indictment.

%Article 385(1) code of criminal procedure
%Judicial process begins with a concise presentation of charges by the public prosecutor.

%% has_right(_art314, PersonId, _right_to_information, _changes)
%
% Article 314 code of criminal procedure
%
% If in course of the investigation it transpires that the suspect should be charged with an offence not included in the
% decision to bring charges already issued, with an offence in the significantly changed form or that the offence should
% be qualified under a more severe provision, a new decision should be issued immediately, announced to the suspect and
% the suspect should be questioned. Article 313 § 3 and 4 applies accordingly (right to demand oral and written justification).
has_right(art314, PersonId, right_to_information, changes):-
    person_status(PersonId, suspect),
    proceeding_matter(PersonId, investigation).

% TODO - does the fact that a person is still a suspect imply we are still in the investigation process?

%% has_right(_art399, PersonId, _right_to_information, _changes)
%
% Article 399(1-2) code of criminal procedure
%
% § 1. If in course of the court hearing it transpires that, without exceeding the limits of the indictment, the criminal act
% should be classified under a different provision of law, the court notifies the parties attending the trial thereof.
% § 2. On a motion of the accused, the trial may be adjourned in order to enable him to prepare the defence.
has_right(art399, PersonId, right_to_information, changes):-
    person_status(PersonId, accused),
    proceeding_matter(PersonId, court_hearing),
    \+ proceeding_event(PersonId, exceed_indictment_limits).

%
% multiple articles as stated in the transposition tables regarding access to the case materials
%
% need to code 249 and 250?
%

%% has_right(_art156_1, PersonId, _right_to_access_materials, _trial)
%
% Article 156(1) code of criminal procedure
%
% Parties, defence counsels, attorneys and legal representatives are granted access to the files of a court case and given
% the possibility of making copies thereof. Upon the consent of the president of the court, access to court files may also
% be granted to other persons. Information on court files can also be made available by means of an information system,
% unless it is not possible for technical reasons.
has_right(art156_1, PersonId, right_to_access_materials, trial):-
    person_status(PersonId, accused).

%% has_right(_art156_2, PersonId, _right_to_access_materials, _trial)
%
% Article 156() code of criminal procedure
%
% § 2. At the request of the accused or his defence counsel, paid for copies of case file documents can be obtained.
% Paid for copies may also be issued, upon request, to other parties, attorneys and legal representatives.
% An order concerning the request may also be issued by a court referendary. Copies made by the parties themselves are free of charge.
has_right(art156_2, PersonId, right_to_access_materials, trial):-
    person_status(PersonId, accused),
    person_request_submitted(PersonId, access_materials).

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

%% has_right(_art321, PersonId, _right_to_access_materials, _investigation)
%
% Article 321(1-6) code of criminal procedure
%
% § 1. If there are grounds to close an investigation, at the request of the suspect and his defence counsel to be allowed to review
% the material of the proceedings, the entity conducting the proceedings informs the suspect and the defence counsel of the date on
% which they may review the said material. They are also instructed that prior to reviewing the material of the proceedings, they
% may review the case files within the time limit set forth by the agency conducting the proceedings, adequate to the importance
% and complexity of the case. For the purpose of the revision the files may be rendered available in electronic form.
% § 2. The date, on which the suspect may review the material of the proceedings, should be set no earlier than after at least seven
% days from the notification of the suspect and his defence counsel thereof.
% § 3. The defence counsel is entitled to participate in the procedure of informing the suspect of the material of the proceedings
% before the closure of the investigation.
% § 4. An unjustified failure of the suspect or his defence counsel to appear does not stop the proceedings.
% § 5. Within three days of reviewing the material of the investigation, the parties may submit requests for the investigation to be
% supplemented. Article 315 § 2 applies accordingly.
% § 6. If there is no need for the investigation to be supplemented, the decision on its closure is issued and announced, or its
% content is communicated, to the suspect and his defence counsel.
has_right(art321, PersonId, right_to_access_materials, investigation):-
    person_status(PersonId, suspect),
    person_request_submitted(PersonId, access_materials),
    proceeding_matter(PersonId, grounds_close_investigation).

%% auxiliary_right(_art159, PersonId, _remedy, _decision)
%
% Article 159 code of criminal procedure
%
% The parties who were denied access to the files of preparatory proceedings may appeal against this decision.
% Interlocutory appeal against the decision of a public prosecutor is submitted to the court.
auxiliary_right_scope(art159, [art156_1, art156_2, art156_5, art321]).

auxiliary_right(art159, PersonId, remedy, decision) :-
    authority_decision(PersonId, denied_access).

%Article 16(1) code of criminal procedure
%If the authority in charge of the proceedings is obliged to instruct the parties to the proceedings of their duties and rights,
%the lack of such an instruction or an incorrect instruction may not result in any adverse consequences either to the participant
%or any other person concerned with the proceedings.

% doesnt this go against what the directive art 8_2 states?
