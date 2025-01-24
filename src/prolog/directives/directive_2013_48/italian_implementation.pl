:- module(directive_2013_48_it, [has_right/5, auxiliary_right/5, auxiliary_right_checked/5, right_property/5, right_property_checked/5, explain/2]).

:- include('./../../utils.pl').

has_right(Right, it, Article, PersonId, Matter) :-
    has_right(Article, PersonId, Right, Matter).

% TODO - Do we need all these rights to information? only 5_1 directive

% Article 61 code of criminal procedure
% 1. The rights and safeguards of the accused person extend to the suspected person.
% 2. Any other provision concerning the accused extends to the suspect, unless otherwise provided.

% Article 63 code of criminal procedure
% 1. If a person who is not accused or suspected makes statements before the judicial authority or the police that raise suspicion
% of guilt against him, the proceeding authority shall interrupt the examination, warn him that, following such statements,
% investigations may be carried out on him, and advise him to appoint a lawyer.
% Such statements shall not be used against the person who has made them.
% 2. If the person should have been heard as an accused or a suspect from the beginning, his statements shall not be used.
person_status(PersonId, suspect):-
%    proceeding_matter(PersonId, questioning),
    person_status(PersonId, raise_suspicion).

% 2. If the requested person should have been heard as an accused or a suspect from the beginning, her/his statements shall not be used.

%% right_property(_art96_2, PersonId, _appoint, _lawyer)
%
% Article 96(2) code of criminal procedure
%
% The accused person is entlitled to appoint no more than two retained lawyers.
% The retained lawyer shall be appointed by a statement either given to the proceeding authority by the accused or her/his lawyer or
% forwarded by registred letter.
% If the person who is temporarily detained, arrest or held under precautionary detention does not appoint a retained lawyer, the latter
% may be appointed by his next of kin according to paragraph 2.
right_property_scope(art96_2, [art97_1]).

right_property(art96_2, PersonId, appoint, lawyer):-
    person_status(PersonId, accused),
    person_document(PersonId, statement, appoint_lawyer).

%% has_right(_art97_1, PersonId, _right_to_access_lawyer, _trial_defence)
%
% Article 97(1) code of criminal procedure
%
% The accused person who has not appointed or no longer has a retained lawyer shall be assisted by a court-appointed lawyer.
has_right(art97_1, PersonId, right_to_access_lawyer, trial_defence):-
    person_status(PersonId, accused).

%In order to ensure the effectiveness of the court-appointed defence, the Board of the Bar Association of each Court of Appeal district,
%through a dedicated centralised office, shall draw lists of lawyers who may be appointed by the court upon request of the judicial
%authority or the police. The Boards of the Bar Association shall set the criteria for the appointment of lawyers on the basis of their
%specific competencies, their proximity to the place of the proceedings and their availability.
%If the judge, the Public Prosecutor and the police must carry out an action requiring the assistance of a lawyer and the suspect or
%the accused does not have a lawyer, thay shall inform the lawyer, whose name is notified by the office referred to in paragraph 2,
%of this particular action.
%When the presence of the lawyer of the accused is required and the retained or court-appointed lawyer chosen according to paragraphs
%2 and 3 have not been found or have not appeared or have left the defence, the judge shall appoint an immediately available substitute
%lawyer to whom the provisions of Article 102 shall apply. Under the same circumstances, the Public Prosecutor and the police shall
%request the office referred to in paragraph 2 to provide the name of another lawyer, except for urgent cases in which another lawyer
%who is immediately available is appointed by a reasoned decision specifying the reasons for urgency.
%During the trial only a lawyer in the list referred to in paragraph 2 may be appointed as a substitute lawyer.

%% has_right(_art103_5, PersonId, _right_to_access_lawyer, _private_communication)
%
% Article 103(5-6) code of criminal procedure
%
% 5.Intercepting conversations and communications of lawyers, authorised private detectives responsible for the proceeding,
% technical consultants and their assistants, is not allowed, nor are such interceptions allowed between them and the persons they are
% assisting.
% 6.Seizure and any form of control of correspondance between the accused and her/his lawyer, if acknowledged by the prescribed
% indications, are forbidden, except if the judicial authority has reasonable grounds to believe that it involves the corpus delicti.
% 7.Without prejudice to paragraph 3 and Article 271, the results of inspections, searches, seizures, interceptions of conversations or
% communications carried out in violations of the above provisions shall not be used.
has_right(art103_5, PersonId, right_to_access_lawyer, private_communication):-
    person_status(PersonId, accused),
    \+ authority_decision(PersonId, grounds_to_consider_communication_corpus_delicti).

%% has_right(_art104, PersonId, _right_to_access_lawyer, _)
%
% Article 104(1-2) code of criminal procedure
%
% 1. The accused who is under precautionary detention has the right to consult with her/his lawyer as of the start of the enforcement
% of such measure.
% 2. A person who is arrested in flagrante delicto or placed under temporary detention (fermo) under Article 384 has the right to
% consult with her/his lawyer immediately after s/he is arrested or temporarily detained.
has_right(art104_1, PersonId, right_to_access_lawyer, precautionary_detention):-
    person_status(PersonId, detained),
    proceeding_matter(PersonId, precautionary_detention).

has_right(art104_2, PersonId, right_to_access_lawyer, arrest):-
    person_status(PersonId, arrested);
    (   person_status(PersonId, detained)
    ,   proceeding_matter(PersonId, temporary_detention)
    ).

% 3. During preliminary investigations for crimes referred to in Article 51,
% paragraphs 3 -bis and 3 -quater, when there are specific and exceptional reasons of caution, the court
% may, upon request of the Public Prosecutor, defer, by reasoned decree, the exercise of the
% right to consult with a lawyer for a period of time not exceeding five days.
% TODO - Fix as exception

% 4. In case the accused person is arrested or placed under temporary detention (fermo), the power
% established in paragraph 3 shall be exercised by the Public Prosecutor until the arrested or
% temporarily detained person is brought before the court.

%% has_right(_article293_1, PersonId, _right_to_information, _)
%
% Article 293.1.a code of criminal procedure
%
% Without prejudice to Article 156, the official or officer in charge of enforcing the order of precautionary detention
% shall provide the accused person with a copy of the decision along with a clear and precise written notice.
% If the accused does not know the Italian language, the notice shall be translated into a language he/she understands.
% The notice shall contain the following information:
% a) his/her right to appoint a retained lawyer and to access legal aid at the expense of the State according to the provisions of the law
% b) his/her right to obtain information on the accusations raised;
% c) his/her right to an interpreter and to the translation of essential documents;
% e) his/her right to access documents on which the decision is based;
% f) his/her right to inform consular authorities and his/her relatives;
% g) his/her right to access emergency medical assistance;
% h) his/her right to be brought before the judicial authority within five days of enforcement of precautionary
% detention in prison or within ten days if a different precautionary measure is applied;
% i) his right to appear before a court for questioning, to appeal the order directing
% the precautionary measure and to request its substitution or revocation.

has_right(art293_1_a, PersonId, right_to_information, access_lawyer):-
    person_status(PersonId, accused),
    proceeding_matter(PersonId, precautionary_detention).

has_right(art293_1_a, PersonId, right_to_information, legal_aid):-
    person_status(PersonId, accused),
    proceeding_matter(PersonId, precautionary_detention).

has_right(art293_1_b, PersonId, right_to_information, accusation):-
    person_status(PersonId, accused),
    proceeding_matter(PersonId, precautionary_detention).

has_right(art293_1_c, PersonId, right_to_information, interpretation):-
    person_status(PersonId, accused),
    proceeding_matter(PersonId, precautionary_detention).

has_right(art293_1_c, PersonId, right_to_information, translation):-
    person_status(PersonId, accused),
    proceeding_matter(PersonId, precautionary_detention),
    person_document(PersonId, essential).

has_right(art293_1_e, PersonId, right_to_information, access_materials):-
    person_status(PersonId, accused),
    proceeding_matter(PersonId, precautionary_detention).

has_right(art293_1_f, PersonId, right_to_information, inform_consul):-
    person_status(PersonId, accused),
    proceeding_matter(PersonId, precautionary_detention).

has_right(art293_1_f, PersonId, right_to_information, inform_relatives):-
    person_status(PersonId, accused),
    proceeding_matter(PersonId, precautionary_detention).

has_right(art293_1_g, PersonId, right_to_information, medical_assistance):-
    person_status(PersonId, accused),
    proceeding_matter(PersonId, precautionary_detention).

has_right(art293_1_h_i, PersonId, right_to_information, be_summoned_in_5_days):-
    person_status(PersonId, accused),
    proceeding_matter(PersonId, precautionary_detention).

has_right(art293_1_h_i, PersonId, right_to_information, be_summoned_in_10_days):-
    person_status(PersonId, accused),
    proceeding_matter(PersonId, precautionary_measure).

has_right(art293_1_i, PersonId, right_to_information, appear_court):-
    person_status(PersonId, accused),
    proceeding_matter(PersonId, precautionary_detention),
    proceeding_matter(PersonId, questioning).

has_right(art293_1_i, PersonId, right_to_information, appeal_precautionary_measure):-
    person_status(PersonId, accused),
    proceeding_matter(PersonId, precautionary_detention),
    proceeding_matter(PersonId, precautionary_measure).

has_right(art293_1_i, PersonId, right_to_information, substitute_precautionary_measure):-
    person_status(PersonId, accused),
    proceeding_matter(PersonId, precautionary_detention),
    proceeding_matter(PersonId, precautionary_measure).

%% auxiliary_right(_art293_1bis, PersonId, _form, _orally)
%
% Article 293.1bis code of criminal procedure
%
% 1-bis. If the written notice referred to in paragraph 1 is not promptly available in a language that the accused understands,
% the information is provided orally, without prejudice to the obligation to provide the accused with the aforementioned
% written notice without delay.
auxiliary_right_scope(art293_1bis, [art293_1_a, art293_1_b, art293_1_c, art293_1_e, art293_1_f, art293_1_g, art293_1_h, art293_1_i]).

auxiliary_right(art293_1bis, PersonId, form, orally) :-
    proceeding_language(PersonId, Language),
    \+ person_language(PersonId, Language).

%% auxiliary_right(_art293_1bis, PersonId, _form, _written)
%
% Article 293.1bis code of criminal procedure
%
% 1-bis. If the written notice referred to in paragraph 1 is not promptly available in a language that the accused understands,
% the information is provided orally, without prejudice to the obligation to provide the accused with the aforementioned
% written notice without delay.
auxiliary_right_scope(art293_1bis, [art293_1_a, art293_1_b, art293_1_c, art293_1_e, art293_1_f, art293_1_g, art293_1_h, art293_1_i]).

auxiliary_right(art293_1bis, PersonId, form, written).

% Article 349(4) code of criminal procedure
% If any of the persons referred to in paragraph 1 [the suspect and the persons who may be able to
% provide information relevant for the reconstructions of the events] refuse to be identified or
% provide personal data or identification documents for which there are sufficient reasons to
% believe they are false, the criminal police shall escort them to their offices and keep them
% there solely for the time needed to check their identity and, in any case, for no longer than
% twelve hours or, after informing the Public Prosecutor even orally, no longer than twenty-four
% hours if the identity checks are particularly complex or the assistance of the consular authority
% or an interpreter is required and, in such cases, the person concerned has the right to inform a
% relative or a cohabitee.

% has_right(_art350, PersonId, _right_to_access_lawyer, _questioning)
%
% Article 350(1-4) code of criminal procedure
%
% 1. Police officials shall collect, as provided for in Article 64, summary information useful for investigative purposes
% from the suspect who has not been placed under arrest or temporary detention according to Article 384 and in the cases
% referred to in Article 384-bis.
% 2. Prior to the investigative questioning, the criminal police shall require the suspect to appoint a retained lawyer and,
% if he does not do so, the police shall follow the provisions of Article 97, paragraph 3.
% 3. Investigative questioning shall be performed with the necessary assistance of the lawyer who shall be promptly informed
% by the criminal police. The lawyer must be present during investigative questioning.
% 4. If the lawyer has not been found or he did not appear, the criminal police shall require the Public Prosecutor to
% take a decision according to Article 97, paragraph 4.

has_right(art350, PersonId, right_to_access_lawyer, questioning) :-
    person_status(PersonId, suspect),
    proceeding_matter(PersonId, investigative_questioning),
    \+ person_status(PersonId, arrested),
    \+ person_status(PersonId, detained).

% Article 350 (5-6) code of criminal procedure
% 5. At the scene or immediately after the offence has occurred, police officials may, even in the
% absence of the lawyer, gather information and details from the suspect, which may be useful for
% the immediate continuation of investigations, even if the suspect was arrested in flagrante delicto
% or placed under temporary detention (fermo) according to Article 384.
% 6. No record or use shall be made of any information or detail gathered in the absence of the lawyer
% at the scene or immediately after the offence has occurred according to paragraph 5.

% Article 357(2)(b) code of criminal procedure
% Without prejudice to the provisions regarding specific activities, the police shall record the following acts:
% b) summary information provided and spontaneous statements made by the suspected person;

%% has_right(_art364, PersonId, _right_to_access_lawyer, _questioning)
%
% Article 364 code of criminal procedure
%
% 1. If the Public Prosecutor must carry out a questioning, inspection, informal identification or line-up in which the
% suspect must participate, the Public Prosecutor shall require the suspect to appear according to Article 375.
% 2. The suspected person who does not have a lawyer shall also be informed that he shall be assisted by a
% court-appointed lawyer, but that he may also appoint a retained lawyer.
% 3. The court-appointed lawyer or the retained lawyer appointed by the suspect shall be informed, at least twenty-four hours in advance,
% of the activities that are to be performed as specified in paragraph 1 and of the inspections which do not require the suspect's presence.

has_right(art364, PersonId, right_to_access_lawyer, investigation) :-
    person_status(PersonId, suspect),
    (   proceeding_matter(PersonId, questioning)
    ;   proceeding_matter(PersonId, inspection)
    ;   proceeding_matter(PersonId, informal_identification)
    ).

% 4. In any case, the lawyer has the right to be present during the activities referred to in
% paragraphs 1 and 3, without prejudice to the provisions of Article 245.

% 7. It is forbidden for anyone participating in the activities to show signs of approval or disapproval. If the lawyer is present while the actions are carried out, s/he may submit to the Public Prosecutor requests, observations and reservations, which shall be included in the record.

%% has_right(_art369_1, PersonId, _right_to_information, _)
%
% Article 369(1) code of criminal procedure
%
% 1. Only when the Public Prosecutor must carry out an activity in which the lawyer has the right to be present,
% shall he/she send a notice of investigation to the suspect and the victim by mail, in a sealed registered envelope
% with return receipt.
% The notice of investigation shall contain the legal provisions which have allegedly been violated as well
% as the date and place in which the criminal act was committed along with a request to exercise the right
% of appointing a retained lawyer.

has_right(art369_1, PersonId, right_to_information, accusation) :-
    person_status(PersonId, suspect),
    physical_presence_required(PersonId, lawyer).

has_right(art369_1, PersonId, right_to_information, access_lawyer) :-
    person_status(PersonId, suspect),
    physical_presence_required(PersonId, lawyer).

%% has_right(_art369_bis, PersonId, _right_to_access_lawyer, _)
%
% Article 369 bis (1- 2)(a) code of criminal procedure
%
% Notice to the suspect about his right to defence
% During the first activity in which the lawyer has the right to be present and, in any case, prior to sending
% the summons to appear for questioning according to the conjunction of Articles 375, paragraph 3, and 416, or no
% later than the service of the notice on the conclusion of preliminary investigations according to Article 415-bis,
% the Public Prosecutor, under penalty of nullity of subsequent acts, shall serve on the suspected person the
% notification of the designation of a court-appointed lawyer.
% The notification referred to in paragraph 1 shall contain:
% a) the information that technical defence in criminal proceedings is mandatory, along with the specification of the rights assigned
% by law to the suspected person;
% b) the name of the court-appointed lawyer, his/her address and his/her telephone number;
% c) the specification of the right to appoint a retained lawyer, along with the notice that, if the suspect does not have a
% retained lawyer, he/she shall be assisted by the court-appointed lawyer;
% d) the specification of the obligation to remunerate the court-appointed lawyer, unless the conditions for accessing the benefit
% referred to in letter e) are met, along with the warning that, in case the lawyer is not paid, mandatory enforcement shall be imposed;
% e) the specification of the conditions for accessing legal aid at the expense of the State.
has_right(art369_bis, PersonId, right_to_access_lawyer, trial) :-
    person_status(PersonId, suspect),
    physical_presence_required(PersonId, lawyer).

has_right(art369_bis, PersonId, right_to_access_lawyer, appoint_lawyer) :-
    person_status(PersonId, suspect),
    physical_presence_required(PersonId, lawyer).

has_right(art369_bis_e, PersonId, right_to_information, free_legal_aid):-
    person_status(PersonId, suspect),
    proceeding_matter(PersonId, lawyer_presence_required).

% Article 373(1)(b) code of criminal procedure
% 1. Without prejudice to the provisions concerning specific documents, the following acts shall be recorded:
% b) questionings and line-ups involving the suspect;

%% has_right(_article386_1, PersonId, _right_to_information, _access_lawyer)
%
% Article 386(1) code of criminal procedure
%
% The police officials and officers who have arrested or placed under temporary detention ("fermo")
% the perpetrator or to whom the arrested person has been surrendered, shall immediately inform the Public Prosecutor
% of the place where the perpetrator has been arrested or placed under temporary detention.
% They shall provide the arrested or temporarily detained person ("fermato") with a written notice, drafted clearly and precisely.
% If the arrested or temporarily detained person does not know the Italian language, the notice shall be translated
% into a language he understands. The notice shall contain the following information:
% a) his/her right to appoint a retained lawyer and to access legal aid at the expense of the State according to the provisions of the law
% b) his/her right to obtain information on the accusations raised;
% c) his/her right to an interpreter and to the translation of essential documents;
% d) his/her right to silence;
% e) his/her right to access documents on which the decision is based;
% f) his/her right to inform consular authorities and his/her relatives;
% g) his/her right to access emergency medical assistance;
% h) his/her right to be brought before the judicial authority for the confirmation
% of the arrest or temporary detention within ninety-eight hours of the arrest or start of temporary detention;
% i) his right to appear before a court for questioning, to appeal the order directing
% the precautionary measure and to request its substitution or revocation.

has_right(art386_1_a, PersonId, right_to_information, access_lawyer):-
    (   person_status(PersonId, arrested)
    ;   person_status(PersonId, detained)
    ).

has_right(art386_1_a, PersonId, right_to_information, legal_aid):-
    (   person_status(PersonId, arrested)
    ;   person_status(PersonId, detained)
    ).

has_right(art386_1_b, PersonId, right_to_information, accusation):-
    (   person_status(PersonId, arrested)
    ;   person_status(PersonId, detained)
    ).

has_right(art386_1_c, PersonId, right_to_information, interpretation):-
    (   person_status(PersonId, arrested)
    ;   person_status(PersonId, detained)
    ).

has_right(art386_1_c, PersonId, right_to_information, translation):-
    (   person_status(PersonId, arrested)
    ;   person_status(PersonId, detained)
    ).
    person_document(PersonId, essential).

has_right(art386_1_c, PersonId, right_to_information, remain_silent):-
    (   person_status(PersonId, arrested)
    ;   person_status(PersonId, detained)
    ).

has_right(art386_1_e, PersonId, right_to_information, access_materials):-
    (   person_status(PersonId, arrested)
    ;   person_status(PersonId, detained)
    ).

has_right(art386_1_f, PersonId, right_to_information, inform_consul):-
    (   person_status(PersonId, arrested)
    ;   person_status(PersonId, detained)
    ).

has_right(art386_1_f, PersonId, right_to_information, inform_relatives):-
    (   person_status(PersonId, arrested)
    ;   person_status(PersonId, detained)
    ).

has_right(art386_1_g, PersonId, right_to_information, medical_assistance):-
    (   person_status(PersonId, arrested)
    ;   person_status(PersonId, detained)
).

has_right(art386_1_h_i, PersonId, right_to_information, be_summoned_in_98_hours):-
    (   person_status(PersonId, arrested)
    ;   person_status(PersonId, detained)
    ).

has_right(art386_1_i, PersonId, right_to_information, appear_court):-
    (   person_status(PersonId, arrested)
    ;   person_status(PersonId, detained)
    ),
    proceeding_matter(PersonId, precautionary_detention),
    proceeding_matter(PersonId, questioning).

has_right(art386_1_i, PersonId, right_to_information, appeal_precautionary_measure):-
    (   person_status(PersonId, arrested)
    ;   person_status(PersonId, detained)
    ),
    proceeding_matter(PersonId, precautionary_detention),
    proceeding_matter(PersonId, precautionary_measure).

has_right(art386_1_i, PersonId, right_to_information, substitute_precautionary_measure):-
    (   person_status(PersonId, arrested)
    ;   person_status(PersonId, detained)
    ),
    proceeding_matter(PersonId, precautionary_detention),
    proceeding_matter(PersonId, precautionary_measure).

%% auxiliary_right(_art386_1bis, PersonId, _form, _orally)
%
% Article 386.1bis code of criminal procedure
%
% 1-bis. If the written notice referred to in paragraph 1 is not promptly available in a language that the arrested or
% temporarily detained person understands, the information is provided orally, without prejudice to the obligation to
% provide the arrested or temporarily detained person with the aforementioned written notice without delay.
auxiliary_right_scope(art386_1bis, [art386_1_a, art386_1_b, art386_1_c, art386_1_d, art386_1_e, art386_1_f, art386_1_g, art386_1_h, art386_1_i]).

auxiliary_right(art386_1bis, PersonId, form, orally) :-
    proceeding_language(PersonId, Language),
    \+ person_language(PersonId, Language).

%% auxiliary_right(_art386_1bis, PersonId, _form, _orally)
%
% Article 386.1bis code of criminal procedure
%
% 1-bis. If the written notice referred to in paragraph 1 is not promptly available in a language that the arrested or
% temporarily detained person understands, the information is provided orally, without prejudice to the obligation to
% provide the arrested or temporarily detained person with the aforementioned written notice without delay.

auxiliary_right(art386_1bis, PersonId, form, written).

%Article 386(2) code of criminal procedure
%Police officers and agents shall immediately inform of the arrest/the stop the lawyer appointed by the arrested person,
%or, if lacking, the public defendant appointed by the public prosecutor pursuant to Article 97 c.p.p.

%% has_right(_art387, PersonId, _right_to_inform, _family_members)
%
% Article 387 code of criminal procedure
%
% With the consent of the arrested or temporarily detained person, the criminal police must inform
% without delay the person's family members of his arrest or temporary detention.
has_right(art387, PersonId, right_to_inform, family_members) :-
    person_status(PersonId, arrested);
    person_status(PersonId, temporary_detention).

% Article 392(1)(e-f) code of criminal procedure
% 1. During preliminary investigations, the Public Prosecutor and the suspect may request that the court proceed by means of special
% evidentiary hearing to:
% e) the confrontation of persons who, in a different special evidentiary hearing or before the Public Prosecutor, have made contrasting
% statements, if one of the circumstances provided for in letters a) and b) occurs;
% f) an expert report or a judicial simulation, if evidence concerns a person, an object or a place subject to unavoidable modification;

%% has_right(_article401, PersonId, _right_to_access_lawyer, _hearing)
%
% Article 401(1-2) code of criminal procedure
%
% 1. Hearings take place in chambers with the necessary participation of the Public Prosecutor and the lawyer of the suspected person.
% The lawyer of the victim is also entitled to participate.
% 2. If the lawyer of the suspected person does not appear, the court shall appoint a different lawyer under the provision of Article
% 97, paragraph 4.
has_right(article401, PersonId, right_to_access_lawyer, hearing):-
    person_status(PersonId, suspect),
    proceeding_matter(PersonId, hearing).

%% has_right(_art415bis_1, PersonId, _right_to_information, _conclusion_preliminary_investigation)
%
% Article 415 bis(1 and 2) code of criminal procedure
%
% 1. Prior to the expiry of the time limit provided for in paragraph 2 of Article 405, also if extended, when the
% case must not be discontinued under Articles 408 and 411, the Public Prosecutor shall serve the notice on the
% conclusion of preliminary investigations on the suspect and his/her lawyer. When any of the offences referred
% to in Articles 572 and 612-bis of the Criminal Code are prosecuted, the same notice shall be served on the
% victim's lawyer or, in his/her absence, the victim himself.
has_right(art415bis_1, PersonId, right_to_information, conclusion_preliminary_investigation) :-
    person_status(PersonId, suspect),
    proceeding_matter(PersonId, preliminary_investigation).

% Article 416(1) code of criminal procedure
% 1. The request to proceed to trial shall be filed by the Public Prosecutor with the Court Registry.
% The request shall be considered null if it is not preceded by the warnings provided for in Article 415-bis, as well as
% by the summons to appear for questioning according to Article 375, paragraph 3, if the suspect has requested the
% questioning within the time limit referred to in Article 415-bis, paragraph 3.

%%% Disposizioni Attuative %%%
% Article 9 disp. att.(5 - 5-bis) disposizioni attuative
% 5.Provided that they are applicable, the provisions of Title I of Book IV of the Criminal Procedure
% Code on precautionary measures apply, except for Articles 273, paragraph 1 and 1-bis, 274, paragraph 1,
% letters a) and c), 280.
% 5-bis. Upon execution of the judicial order referred to in paragraph 4, the police official or
% officer shall also inform the person whose surrender has been requested that s/he is entlitled
% to appoint a retained lawyer in the requesting State. The President of the Court of Appeals shall
% immediately inform the competent authority that the concerned person has appointed or wants to
% appoint a lawyer in the requesting State.

%% has_right(_art12_1, PersonId, _right_to_information, _)
%
% Article 12(1 - 1-bis) disposizioni attuative
%
% 1.The police official or officer that has proceeded with the arrest under the provision of
% Article 11 shall inform the person, in a language that s/he understands, of the warrant issued
% against her/him or and of its content and shall serve on her/him a written notice, drafted in a
% clear and precise manner, that informs her/him of the possibility to consent to her/his surrender
% to the requesting judicial authority and warns her/him of his right to appoint a retained lawyer
% and of her/his right to be assisted by an interpreter.
has_right(art12_1, PersonId, right_to_information, consent_surrender) :-
    person_status(PersonId, arrested).

has_right(art12_1, PersonId, right_to_information, appoint_lawyer) :-
    person_status(PersonId, arrested).

has_right(art12_1, PersonId, right_to_information, interpreter) :-
    person_status(PersonId, arrested).

% 1-bis. The provision of Article 9, paragraph 5-bis, first phrase applies.

%% has_right(_art29_1, PersonId, _right_to_inform, _relatives)
%
% Article 29 (1-4) disposizioni attuative
%
% Detainees and inmates shall be provided with the possibility to immediately inform their relatives
% or other indicated persons about the entrance in the institute or the occurred transfer.
has_right(art29_1, PersonId, right_to_inform, relatives) :-
    person_status(PersonId, detained);
    person_status(PersonId, inmate).

% 4.The informatic system referred to in paragraph 2 shall ensure:
% c) the institution of differentiated shifts, for suspected and accused persons, or for persons
% arrested due to enforcement of an European Arrest Warrant in the framework of the active procedures
% of surrender, in order to facilitate the timely appointment of a lawyer that shall assist the
% appointed lawyer in the executing State, and to ensure, through daily rounds, the availability of
% a number of court-appointed lawyers in accordance with the circumstances of the case.

% Article 220 disp. att. disposizioni attuative
% When indications of guilt emerge in the course of inspection or supervision activities foreseen
% by laws or decrees, the acts which are deemed to be necessary to secure sources of evidence or
% to gather any other element that may serve to the application of the law are carried out under
% the provisions of the present code.

%%% law no 354 of 26 July 1975 %%%

%% has_right(_article18_1, PersonId, _right_to_correspondence, _relatives_lawyer)
%
% Article 18(1) law 354/1975
%
% 1. Detainees and inmates are allowed to have conversations and correspondence with relatives and other persons, as well as with the
% guarantor of prisoners' rights, also for the purpose of carrying out legal acts.
has_right(article18_1, PersonId, right_to_correspondence, relatives_lawyer):-
    person_status(PersonId, detained);
    person_status(PersonId, inmate).

% 2. Interviews take place in special premises, under the visual and non-audible control of the penitentiary facility.
% 3. (...)
% 4. The prison administration provides prisoners and inmates who do not have it with the necessary stationery for correspondence.
% 5. In relations with family members and, in special cases, with third parties, telephone correspondence may be authorised in
% a manner and with the precautions laid down in the regulation.
%% 11. Without prejudice to art. 18-bis c.p.p., before the decision of first instance, communications,
% correspondence and other means of communication are allowed by the judicial authority referred to in art. 11 paragraph 4 c.p.p. After the decision of first instance in charge of the decision is the Director of the penitentiary institute.

%% has_right(_art29_1, PersonId, _right_to_inform, relatives)
%
% Article 29(1) law 354/1975
%
% Detainees and inmates shall be provided with the possibility to immediately inform their relatives
% or other indicated persons about the entrance in the institute or the occurred transfer.
has_right(art29_1, PersonId, right_to_inform, relatives) :-
    (   person_status(PersonId, detained)
    ;   person_status(PersonId, inmate)
    ).

% Article 41-bis(2) law 354/1975
% When serious reasons related to public order or public security occur, also upon the request of the
% Ministry of Internal Affairs, the Ministry of Justice may suspend, in whole or in part, in relation to
% detainees and inmates for one of the crimes indicated in Article 4-bis, first paragraph, first part,
% or a crime committed taking advantage or with the aim of strengthening the Mafia-type association, in
% case there are elements showing the existence of connections with a criminal association, the
% application of the rules of treatment that may be in contrast with the needs of order and security.
% The suspension imposes the restrictions that are necessary in order to achieve the indicated purposes
% and sever the connections with the criminal association. […]
% TODO - Fix as exception?

%%% Decree no 230 of the President of the Repubblic of 30 June 2000 %%%
% Article 35(1) Decree no 230 of the President of the Repubblic of 30 June 2000
% While the measure limiting the liberty is in force, linguistic difficulties and cultural
% differences of foreign citizens must be considered. Contacts with consular authorities
% shall be promoted.

%% has_right(_art37_1, PersonId, _right_to_be_visited, _relatives)
%
% Article 37(1) Decree no 230 of the President of the Repubblic of 30 June 2000
%
% 1. Visits of convicted persons, inmates and defendants after the verdict of the first stage
% are authorized by the Head of the institute. Visits with persons different from relatives and
% cohabitees are authorized when sensible reasons occur.
has_right(art37_1, PersonId, right_to_be_visited, relatives) :-
    (person_status(PersonId, convicted);
    person_status(PersonId, inmate)),
    authority_decision(PersonId, authorized).

% 2. As for visits with defendants before the verdict of the first stage, applicants shall exhibit
% the authorization provided by the judicial authority.
% 8. Detainees and inmates are entitled to six visits per month. Visits cannot be more than four for
% persons detained for one of the crimes enumerated in the first part of paragraph 4-bis of the Law
% no 354 of 26 July 1975 to whom the prohibition of benefits therein provided apply.

% Article 39(4) Decree no 230 of the President of the Repubblic of 30 June 2000
% Defendants may be authorized to telephonic correspondence, with the frequency and the modalities
% indicated at paragraph 2 and 3, by the judicial authority or, after the verdict of the first stage,
% by the Sentence Supervision Judge.

%% has_right(_art62_1, PersonId, _right_to_inform, _)
%
% Article 62(1,3) Decree no 230 of the President of the Repubblic of 30 June 2000
%
% 1. Immediately after the entrance in the penitentiary institute, the detained person, both in
% cases/he was previously free or detained elsewhere, is asked if s/he wish to inform about the fact
% a relative or other person of his/her choice and, if so, whether by post or by means of telegraphic
% communication.
% 3. In case of foreign detainee, the entrance in the institute is communicated to consular
% authorities according to the current legislation.
has_right(art62_1, PersonId, right_to_inform, relatives) :-
    person_status(PersonId, detained).

has_right(art62_3, PersonId, right_to_inform, consular_authority) :-
    person_status(PersonId, detained),
    proceeding_location(PersonId, Country),
    \+ person_nationality(PersonId, Country).

%%% Decree no 448 of the President of the Republic of 22 settembre 1988 %%%

%% has_right(_art18_1, PersonId, _right_to_inform, _juvenile_services)
%
% Article 18(1) Decree no 448 of the President of the Republic of 22 settembre 1988
%
% The criminal police officials and officers who have arrested or placed under temporary custody
% the minor shall immediately give notice to the Public Prosecutor, the holder the parental
% responsibility and the legal guardian (if any); they promptly inform the juvenile services
% of the Ministry of Justice.
has_right(art18_1, PersonId, right_to_inform, juvenile_services) :-
    person_status(PersonId, arrested);
    person_status(PersonId, temporary_custody).

%%% Legislative Decree no 286 of 25 July 1998 %%%
% Article 2(7) Decree no 448 of the President of the Republic of 22 settembre 1988
% The judicial authority, the public security authority and any other public official have the
% duty to inform, in respect of the terms and limits established by the rules, the diplomatic or
% consular delegation closest to the home country of the foreigner in case of adoption of
% coercive measures.

%%% Decree of the President of the Republic no 394 of 31 August 1999 %%%
% Article 4(1) Decree of the President of the Republic no 394 of 31 August 1999
%The information prescribed by Article 2 paragraph 7 of the legislative decree no 286 of 25
%July 1998 contains:
%a) The indication of the judicial or administrative authority providing the information;
%b) The personal details and nationality of the foreigner, including, if possible, the details of the passport or other identity document or, in the absence, any identification detail collected;
%c) The indication of the circumstances that impose the release of the information, with particular reference to the date of their assessment and, in case an order against the foreigner is ruled, the details of it;
%d) The place where the foreigner is located, in case a coercive measure is applied, the place of death or hospitalisation.

% Article 4(3,4) Decree of the President of the Republic no 394 of 31 August 1999
% 3. The information to the diplomatic or consular authority is not given when the foreigner
% […] declares his/her intention to not take advantage of the intervention of those authorities.
% As for the foreigner whit an age of less than fourteen years, the forfeiture is expressed by
% the holder of parental responsibility.

% 4. The information to the diplomatic or consular authority is not given also in case it might
% cause the risk of persecution of the foreigner or his/her family members for reasons related to
% race, sex, language, religion, political opinion, national origins, personal or social conditions.

%%% Legislative Decree no 286 of 25 July 1998 %%%

%% has_right(_art2_7, PersonId, _right_to_inform, _consul)
%
% Article 2(7) Legislative Decree no 286 of 25 July 1998
%
% The judicial authority, the public security authority and any other public official have the duty to
% inform, in respect of the terms and limits established by the rules, the diplomatic or consular
% delegation closest to the home country of the foreigner in case of adoption of coercive measures.
has_right(art2_7, PersonId, right_to_inform, consul):-
    proceeding_location(PersonId, Country),
    \+ person_nationality(PersonId, Country).

%%%% Provisions to adapt national legislation to the Council Framework Decision 2002/584/JHA of 13 June %
% 2002 on the European arrest warrant and the surrender procedures between Member States %%%%

%% has_right(_art12_1, PersonId, _right_to_interpretation, _europeanArrestWarrant)
%
% Article 12(1) Provisions to adapt national legislation to the Council Framework Decision 2002/584/JHA
%
% The criminal police officer who arrests the accused under Art 11 informs the person, using a language he can understand,
% about the warrant, its contents and delivers a written document, clearly and precisely drafted, which informs him of the
% possibility of consenting to surrender to the issuing judicial authority and advise the person he can appoint a lawyer
% and he has the right to be assisted by an interpreter.
% 1-bis. The provision laid down in Article 9(5bis), first sentence shall apply.
% 2. Police shall give timely notice of the arrest to the lawyer.
% 3. The arrest report shall record, under penalty of nullity, the fulfilments indicated in paragraphs 1
% and 2, as well as the checks carried out on the identification of the arrested person
has_right(art12_1, PersonId, right_to_interpretation, europeanArrestWarrant):-
	proceeding_type(PersonId, 	europeanArrestWarrant),
	proceeding_language(PersonId, Language),
	\+ person_language(PersonId, Language).

%% has_right(_art9_5bis, PersonId, _right_to_appoint_lawyer, _coercive_measure)
%
% Article 9(5 bis) Provisions to adapt national legislation to the Council Framework Decision 2002/584/JHA
%
% When executing the order referred to in paragraph 4 [decision to apply a coercive measure], the police
% officer shall also inform the person whose surrender is requested that s/he is entitled to appoint a
% lawyer in the issuing State. The President of the Court of Appeal shall immediately inform the competent
% authority of the appointment or the willingness of the person concerned to have recourse to a lawyer in
% the issuing State.
has_right(art9_5bis, PersonId, right_to_appoint_lawyer, coercive_measure):-
	proceeding_matter(PersonId, coercive_measure),
	proceeding_issuing_state(PersonId, Country).


