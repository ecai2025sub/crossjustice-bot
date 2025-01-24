
:- module(directive_2012_13_it, [has_right/5, auxiliary_right/5, auxiliary_right_checked/5, right_property/5, right_property_checked/5, explain/2]).

:- include('./../../utils.pl').

has_right(Right, it, Article, PersonId, Matter) :-
    has_right(Article, PersonId, Right, Matter).

%Italian implementation directive 2012/13

%% has_right(_art369_1, PersonId, _right_to_information, _)
%
% Article 369.1 code of criminal procedure
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

%% has_right(_art369_bis, PersonId, _right_to_access_lawyer, _trial)
%
% Article 369bis code of criminal procedure
%
% 1. During the first activity in which the lawyer has the right to be present and, in any case, prior to
% sending the summons to appear for questioning according to the conjunction of Articles 375, paragraph 3,
% and 416, or no later than the service of the notice on the conclusion of preliminary investigations according
% to Article 415-bis, the Public Prosecutor, under penalty of nullity of subsequent acts, shall serve on the
% suspected person the notification on the designation of a court-appointed lawyer.
% 2. The notification referred to in paragraph 1 shall contain:
% a) the information that technical defence in criminal proceedings is mandatory, along with the specification
% of the rights assigned by law to the suspected person;
% b) the name of the court-appointed lawyer, his/her address and his/her telephone number;
% c) the specification of the right to appoint a retained lawyer, along with the notice that, if the suspect does not
% have a retained lawyer, he/she shall be assisted by the court-appointed lawyer;
% d) the specification of the obligation to remunerate the court-appointed lawyer, unless the conditions for accessing
% the benefit referred to in letter e) are met, along with the warning that, in case the lawyer is not paid,
% mandatory enforcement shall be imposed;
has_right(art369_bis, PersonId, right_to_access_lawyer, trial) :-
    person_status(PersonId, suspect),
    physical_presence_required(PersonId, lawyer),
    \+ proceeding_matter(PersonId, conclusion_preliminary_investigation).

%% has_right(_art369_bis_2_e, PersonId, _right_to_access_lawyer, _trial)
%
% Article 369bis.2.e code of criminal procedure
%
% 1. During the first activity in which the lawyer has the right to be present and, in any case, prior to
% sending the summons to appear for questioning according to the conjunction of Articles 375, paragraph 3,
% and 416, or no later than the service of the notice on the conclusion of preliminary investigations according
% to Article 415-bis, the Public Prosecutor, under penalty of nullity of subsequent acts, shall serve on the
% suspected person the notification on the designation of a court-appointed lawyer.
% 2. The notification referred to in paragraph 1 shall contain:
% e) the specification of the conditions for accessing legal aid at the expense of the State.
auxiliary_right_scope(art369_bis_2_e, [art369_bis]).

auxiliary_right(art369_bis_2_e, PersonId, legal_aid, free) :-
    person_status(PersonId, suspect),
    physical_presence_required(PersonId, lawyer),
    \+ proceeding_matter(PersonId, conclusion_preliminary_investigation).

%% has_right(_art369_bis_2_d, PersonId, _right_to_interpretation, _trial)
%
% Article 369bis.2.d code of criminal procedure
%
% 1. During the first activity in which the lawyer has the right to be present and, in any case, prior to
% sending the summons to appear for questioning according to the conjunction of Articles 375, paragraph 3,
% and 416, or no later than the service of the notice on the conclusion of preliminary investigations according
% to Article 415-bis, the Public Prosecutor, under penalty of nullity of subsequent acts, shall serve on the
% suspected person the notification on the designation of a court-appointed lawyer.
% 2. The notification referred to in paragraph 1 shall contain:
% d-bis) the information that the suspect has the right to an interpreter and to the translation of essential documents;
has_right(art369_bis_2_dbis, PersonId, right_to_interpretation, trial) :-
    person_status(PersonId, suspect),
    physical_presence_required(PersonId, lawyer).

%% has_right(_art369_bis_2_d, PersonId, _right_to_translation, _trial)
%
% Article 369bis.2.d code of criminal procedure
%
% 1. During the first activity in which the lawyer has the right to be present and, in any case, prior to
% sending the summons to appear for questioning according to the conjunction of Articles 375, paragraph 3,
% and 416, or no later than the service of the notice on the conclusion of preliminary investigations according
% to Article 415-bis, the Public Prosecutor, under penalty of nullity of subsequent acts, shall serve on the
% suspected person the notification on the designation of a court-appointed lawyer.
% 2. The notification referred to in paragraph 1 shall contain:
% d-bis) the information that the suspect has the right to an interpreter and to the translation of essential documents;
has_right(art369_bis_2_dbis, PersonId, right_to_translation, trial) :-
    person_status(PersonId, suspect),
    physical_presence_required(PersonId, lawyer),
    \+ proceeding_matter(PersonId, conclusion_preliminary_investigation).

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

has_right(art293_1_h, PersonId, right_to_information, be_summoned_in_5_days):-
    person_status(PersonId, accused),
    proceeding_matter(PersonId, precautionary_detention).

has_right(art293_1_h, PersonId, right_to_information, be_summoned_in_10_days):-
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
auxiliary_right(art293_1bis, PersonId, form, written).

%Article 293(1 ter) code of criminal procedure
%The official or officer in charge of enforcing the order shall immediately inform the retained lawyer or the lawyer
%appointed by the court in accordance with Article 97 and shall draft a record of all the activities carried out,
%including the delivery of the written notice referred to in paragraph 1 or the information provided orally in
%accordance with paragraph 1 -bis. The record shall be immediately forwarded to the court who has issued the order
%and to the Public Prosecutor.

%Article 293(3) code of criminal procedure
%The orders referred to in paragraphs 1 and 2 [ndr: orders applying pre-trial measures, including pre-trial detention] shall,
%after service or enforcement, be deposited at the Registry of the court which issued them, together with the request of
%the public prosecutor [to apply the pre-trial measure] and the documents submitted with it. Notice of the filing shall
%be served on the lawyer.

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
    ),
    person_document(PersonId, essential).

has_right(art386_1_d, PersonId, right_to_information, remain_silent):-
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

has_right(art386_1_h, PersonId, right_to_information, be_summoned_in_98_hours):-
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

%If the case envisaged in Article 389, paragraph 2, does not occur, police officials and officers shall place the
%arrested or temporarily detained person ("fermato") at the disposal of the Public Prosecutor as soon as possible and,
%in any case, within twenty-four hours of the arrest or start of temporary detention. Within the same time limit they
%shall forward the relevant record, also electronically, unless the Public Prosecutor authorises a longer time limit.
%The record shall contain the possible appointment of a retained lawyer, the specification of the day, time and place
%in which the person was arrested or placed under temporary detention and a list of the reasons thereof, as well as
%the specification that the arrested or temporarily detained person was provided with the written notice or orally
%informed according to paragraph 1 -bis.

%% has_right(_art388, PersonId, _right_to_information, _accusation)
%
% Article 388 code of criminal procedure
%
% 1. The Public Prosecutor may proceed with the interrogation of the arrested or detained person, giving timely notice
% to the appointed lawyer or, failing that, to the public defender.
% 2. During the interrogation, having observed the forms provided for in Article 64, the Public Prosecutor shall inform
% the arrested or detained person of the fact for which the arrest or detention is being carried out; of the reasons
% which led to the measure; and of the elements against her/him, as well as, if it is not prejudicial to the investigation,
% of the sources from which such elements have been obtained.
has_right(art388, PersonId, right_to_information, accusation):-
    (   person_status(PersonId, arrested)
    ;   person_status(PersonId, detained)
    ),
    proceeding_matter(PersonId, questioning).

%% has_right(_art350, PersonId, _right_to_access_lawyer, _questioning)
%
% Article 350 code of criminal procedure
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

%% has_right(_art364, PersonId, _right_to_access_lawyer, _questioning)
%
% Article 364 code of criminal procedure
%
% 1. If the Public Prosecutor must carry out a questioning, inspection, informal identification or line-up in which the
% suspect must participate, the Public Prosecutor shall require the suspect to appear according to Article 375.
% 2. The suspected person who does not have a lawyer shall also be informed that he shall be assisted by a
% court-appointed lawyer, but that he may also appoint a retained lawyer.

has_right(art364, PersonId, right_to_access_lawyer, investigation) :-
    person_status(PersonId, suspect),
    (   proceeding_matter(PersonId, questioning)
    ;   proceeding_matter(PersonId, inspection)
    ;   proceeding_matter(PersonId, informal_identification)
    ).

%% has_right(_art365, PersonId, _right_to_access_lawyer, _investigation)
%
% Article 365 code of criminal procedure
%
% 1. If the Public Prosecutor performs searches or seizures, he shall ask the suspect, when the latter is present,
% whether he is assisted by a retained lawyer and, if he does not have one, the Public Prosecutor shall appoint a
% court-appointed lawyer according to Article 97, paragraph 3.
has_right(art365, PersonId, right_to_access_lawyer, investigation) :-
    person_status(PersonId, suspect),
    (   proceeding_matter(PersonId, search)
    ;   proceeding_matter(PersonId, seizure)
    ).


%% has_right(_art360, PersonId, _right_to_access_lawyer, _investigation)
%
% Article 360 code of criminal procedure
%
% 1. If the ascertainment provided for in Article 359 involves persons, objects or places which are subject to change,
% the Public Prosecutor shall inform, without delay, the suspect, the victim and the lawyers of the day, time and
% place set for the assignment of the non-repeatable technical ascertainment and of the right to appoint technical consultants.
% 2. The provisions of Article 364, paragraph 2, shall apply.
% 3. The lawyers as well as the possibly appointed technical consultants have the right to be present during the
% assignment of the non-repeatable technical ascertainment, participate in the ascertainment and make their own
% observations and reservations.
has_right(art360, PersonId, right_to_access_lawyer, investigation) :-
    person_status(PersonId, suspect),
    proceeding_matter(PersonId, technical_ascertainment).

%% has_right(_art114, PersonId, _right_to_access_lawyer, _investigation)
%
% Article 114 code of criminal procedure
%
% In carrying out the acts indicated in article 356 of the criminal procedure code, the police warns the person
% under investigation, if present, that he/she has the right to be assisted by the retained lawyer.

%has_right(art114, PersonId, right_to_access_lawyer, investigation) :-
%    person_status(PersonId, suspect),
%    proceeding_matter(PersonId, urgent_check_scene).

%% has_right(_art64_3_b, PersonId, _right_to_remain_silent, _trial)
%
% Article 64.3.b code of criminal procedure
%
% Prior to the questioning, the person must be warned that:
% b) without prejudice to the provisions of Article 66, paragraph 1, he has the right to silence, but the
% proceedings will in any case continue their course;
%has_right(art64_3_b, PersonId, right_to_remain_silent, trial) :-
%    person_status(PersonId, suspect);
%    person_status(PersonId, accused).

%% person_status(PersonId, _suspect)
%
% Article 63 code of criminal procedure
%
% 1. If a person who is not accused or suspected makes statements before the judicial authority or the criminal
% police that raise suspicion of guilt against him, the proceeding authority shall interrupt the examination,
% warn him that, following such statements, investigations may be carried out on him, and advise him to appoint a lawyer.
% Such statements shall not be used against the person who has made them.
% 2. If the person should have been heard as an accused or a suspect from the beginning, his statements shall not be used.
% person_status(PersonId, suspect):-
%    person_status(PersonId, raise_suspicion).

%Article 294(1-bis) code of criminal procedure
%1. In the stages of the proceedings prior to the opening of the trial, the court that has decided on the application
%of the precautionary measure shall question the person under precautionary detention in prison immediately and in any case
%by the fifth day after the enforcement of detention, if it has not done so during the hearing which confirmed the arrest
%or temporary detention of the crime suspect, except for the case in which he/she cannot be questioned in any way whatsoever.
%1 -bis. If the person is subject to a different precautionary measure, either coercive or disqualifying, the questioning
%shall take place no later than ten days after enforcement of the decision or its service. The court shall verify, also
%of its own motion, that the accused person under precautionary detention in prison or house arrest has received the
%notice referred to in Article 293, paragraph 1, or has been informed according to paragraph 1 -bis of the same Article,
%and shall give or complete the written notice or the oral information, if necessary.

%% has_right(_article391_2, PersonId, _right_to_access_lawyer, _confirmation_hearing)
%
% Article 391.2 code of criminal procedure
%
% 1. Confirmation hearings are held in closed session with the necessary participation of the lawyer of the arrested or
% temporarily detained person.
% 2. If the retained or court-appointed lawyer cannot be reached or has not appeared, the Preliminary Investigation Judge
% shall decide on the designation of a substitute according to Article 97, paragraph 4.
% The Judge shall verify, also of his/her own motion, that the arrested or temporarily detained person ("fermato") has
% received the notice referred to in Article 386, paragraph 1, or has been informed according to paragraph 1-bis of
% the same Article, and shall give or complete the written notice or the oral information, if necessary.

has_right(art391_2, PersonId, right_to_access_lawyer, confirmation_hearing):-
    proceeding_matter(PersonId, confirmation_hearing),
    (   person_status(PersonId, arrested)
    ;   person_status(PersonId, detained)
    ).

%% has_right(_article391_3, PersonId, _right_to_information, _accusation)
%
% Article 391.3 code of criminal procedure
%
% 3. The Public Prosecutor, if s/he appears, shall state the reasons for the arrest or detention and shall explain her/his
% requests concerning personal freedom. The judge then proceeds to question the arrested or detained person, unless s/he
% could not or refused to appear; in any case, the judge will hear her/his defence counsel.
has_right(art391_3, PersonId, right_to_information, accusation):-
    person_status(PersonId, arrested);
    person_status(PersonId, detained).

%% auxiliary_right(_art391_4, PersonId, _remedy, _arrest)
%
% Article 391.4 code of criminal procedure
%
% 4. When it appears that the arrest or detention has been lawfully carried out and the terms provided for in articles
% 386(3) and 390(1) have been observed, the judge shall validate the arrest or detention by order.
% The public prosecutor and the arrested or detained person may appeal against the order that decides on such validation.
auxiliary_right_scope(art391_4, [art388, art391_2, art391_3]).

auxiliary_right(art391_4, PersonId, remedy, arrest):-
    person_status(PersonId, arrested).

%% auxiliary_right(_art391_4, PersonId, _remedy, _detention)
%
% Article 391.4 code of criminal procedure
%
% 4. When it appears that the arrest or detention has been lawfully carried out and the terms provided for in articles
% 386(3) and 390(1) have been observed, the judge shall validate the arrest or detention by order.
% The public prosecutor and the arrested or detained person may appeal against the order that decides on such validation.

auxiliary_right(art391_4, PersonId, remedy, detention):-
    person_status(PersonId, detained).

%% has_right(_art116, PersonId, _right_to_access_materials, _trial)
%
% Article 116.1-2 code of criminal procedure
%
% 1. During the proceedings and after they have been settled, anyone interested in them may obtain copies, extracts or
% certificates of individual documents at their own expense.
% 2. The request shall be dealt with by the public prosecutor's office or the judge proceeding at the time the request
% is made or, after the proceedings have been concluded, by the chairperson of the panel or the judge who issued the
% order to close the case or the judgment.
has_right(art116, PersonId, right_to_access_materials, trial):-
    authority_decision(PersonId, access_materials).

%% has_right(_art12, PersonId, _right_to_access_lawyer, _trial)
%
% Article 12 Decision 2002/584/JHA of 13 June 2002 on the European arrest warrant and the surrender procedures between Member States
%
% 1. The police official who arrested the individual pursuant to Article 11 shall inform him/her, in a language he
% understands, of the warrant issued and of its content and provide him/her with a written notice, drafted clearly
% and precisely, which informs him/her of the possibility of consenting to his/her surrender to the issuing judicial
% authority and warns him/her of the right to appoint a retained lawyer and to be assisted by an interpreter.
% If the arrested person fails to appoint a lawyer, the police immediately identifies a court-appointed lawyer
% pursuant to article 97 of the criminal procedure code.
% 1-bis. The provision of article 9, paragraph 5-bis, first sentence applies.
% 2. The judicial police shall promptly inform the lawyer of the arrest.
% 3. The report of the arrest acknowledges, under penalty of nullity, the fulfilments indicated in paragraphs 1 and 2,
% as well as checks made on the identification of the arrested person.
has_right(art12, PersonId, right_to_access_lawyer, trial):-
    person_status(PersonId, arrested).

%% auxiliary_right(_art12_1, PersonId, _form, _written)
%
% Article 12.1 Decision 2002/584/JHA of 13 June 2002 on the European arrest warrant and the surrender procedures between Member States
%
% 1. The police official who arrested the individual pursuant to Article 11 shall inform him/her, in a language he
% understands, of the warrant issued and of its content and provide him/her with a written notice, drafted clearly
% and precisely, which informs him/her of the possibility of consenting to his/her surrender to the issuing judicial
% authority and warns him/her of the right to appoint a retained lawyer and to be assisted by an interpreter.
% If the arrested person fails to appoint a lawyer, the police immediately identifies a court-appointed lawyer
% pursuant to article 97 of the criminal procedure code.
auxiliary_right_scope(art12_1, [art12, art12_2]).

auxiliary_right(art12_1, PersonId, form, written).

%% auxiliary_right(_art12_1, PersonId, _language, _comprehensible)
%
% Article 12.1 Decision 2002/584/JHA of 13 June 2002 on the European arrest warrant and the surrender procedures between Member States
%
% 1. The police official who arrested the individual pursuant to Article 11 shall inform him/her, in a language he
% understands, of the warrant issued and of its content and provide him/her with a written notice, drafted clearly
% and precisely, which informs him/her of the possibility of consenting to his/her surrender to the issuing judicial
% authority and warns him/her of the right to appoint a retained lawyer and to be assisted by an interpreter.
% If the arrested person fails to appoint a lawyer, the police immediately identifies a court-appointed lawyer
% pursuant to article 97 of the criminal procedure code.
auxiliary_right(art12_1, PersonId, language, comprehensible).

%% has_right(_art12_2, PersonId, _right_to_information, _lawyer)
%
% Article 12 Decision 2002/584/JHA of 13 June 2002 on the European arrest warrant and the surrender procedures between Member States
%
% 2. The judicial police shall promptly inform the lawyer of the arrest.
has_right(art12_2, PersonId, right_to_information, lawyer):-
    person_status(PersonId, arrested).

%% has_right(_art9_5bis, PersonId, _right_to_access_lawyer, _trial)
%
% Article 9.5 Decision 2002/584/JHA of 13 June 2002 on the European arrest warrant and the surrender procedures between Member States
%
% When executing the order referred to in paragraph 4, the police official or agent also informs the requested
% person of the faculty to appoint a lawyer in the issuing State. The President of the Court of Appeal gives
% immediate notice to the competent authority of the issuing State of such appointment or of the will of the
% interested person to make use of a lawyer in the issuing State.
%has_right(art9_5bis, PersonId, right_to_access_lawyer, trial):-
%    person_status(PersonId, arrested).

%% has_right(_art335_3, PersonId, _right_to_information, _accusation)
%
% Article 335.3 code of criminal procedure
%
% With the exception of the crimes referred to in Article 407, paragraph 2, letter a.), the alleged perpetrator
% of the offence, the victim and the lawyers, upon their own request, shall be informed of the entering of
% notitiae criminis according to paragraphs 1 and 2.
has_right(art335_3, PersonId, right_to_information, accusation):-
    person_status(PersonId, accused).

%% has_right(_art415bis_1, PersonId, _right_to_information, _conclusion_preliminary_investigation)
%
% Article 415bis.1 code of criminal procedure
%
% 1. Prior to the expiry of the time limit provided for in paragraph 2 of Article 405, also if extended, when the
% case must not be discontinued under Articles 408 and 411, the Public Prosecutor shall serve the notice on the
% conclusion of preliminary investigations on the suspect and his/her lawyer. When any of the offences referred
% to in Articles 572 and 612-bis of the Criminal Code are prosecuted, the same notice shall be served on the
% victim's lawyer or, in his/her absence, the victim himself.
has_right(art415bis_1, PersonId, right_to_information, conclusion_preliminary_investigation) :-
    person_status(PersonId, suspect),
    proceeding_matter(PersonId, preliminary_investigation).

%% has_right(_art415bis_2, PersonId, _right_to_information, _accusation)
%
% Article 415bis.2 code of criminal procedure
%
% 2. The notice shall contain a brief description of the criminal act under prosecution, the rules of law allegedly
% violated, the date and place of the act, along with the notice that the record of the completed investigations
% is filed with the Clerk‟s Office of the Public Prosecutor and the suspect and his/her lawyer shall be
% entitled to examine it and copy it.

has_right(art415bis_2, PersonId, right_to_information, accusation) :-
    person_status(PersonId, suspect),
    proceeding_matter(PersonId, preliminary_investigation).

%% has_right(_art415_2a, PersonId, _right_to_access_materials, _electronic_means)
%
% Article 415.2.a code of criminal procedure
%
% 2a. If no action has been taken pursuant to article 268, paragraphs 4, 5 and 6, the notice shall also contain
% the warning that the suspect and her/his defence counsel have the right to examine by electronic means the acts
% relating to interceptions and listen to the recordings, or to take cognizance of the computer or telematic
% communication flows and that they have the right to extract copies of the recordings or flows indicated as
% relevant by the Public Prosecutor. The defence lawyer may, within twenty days, file the list of further
% recordings considered relevant and of which he requests a copy. The Public Prosecutor shall provide for the
% request by means of a reasoned decree. In the event of rejection of the request, or if there are objections to the
% indications relating to the registrations considered relevant, the defence lawyer may submit the request to the
% judge to proceed in the manner set out in article 268, paragraph 6.
has_right(art415_2a, PersonId, right_to_access_materials, electronic_means) :-
    person_request_submitted(PersonId, access_materials).

%% has_right(_art429, PersonId, _right_to_information, _accusation)
%
% Article 429 code of criminal procedure
%
% 1. The decree for committal to trial shall contain:
% c) the clear and precise description of the criminal act, the aggravating circumstances and those that may result
% in the application of security measures, indicating the relevant Articles of law;
% 2. The decree shall be considered null if the accused is not identified in a certain way or if one of the
% requirements provided for in paragraph 1, letters c) and f), are missing or insufficient.
has_right(art429, PersonId, right_to_information, accusation) :-
    person_status(PersonId, accused),
    proceeding_matter(PersonId, committal_to_trial).

%% has_right(_art552, PersonId, _right_to_information, _accusation)
%
% Article 552 code of criminal procedure
%
% 1. The decree for direct summons for trial shall contain:
% c) the clear and precise description of the criminal act, the aggravating circumstances and those that may result
% in the application of security measures, indicating the relevant articles of law;
% 2. The decree shall be null if the accused is not identified appropriately or if one of the requirements provided
% for in letters c), d), e) and f) of paragraph 1 is missing or insufficient.
has_right(art552, PersonId, right_to_information, accusation) :-
    person_status(PersonId, accused),
    proceeding_matter(PersonId, summoned_court).

%Article 423 code of criminal procedure
%1. If, during the hearing, it emerges that the criminal act differs from the description provided thereof
%in the accusation or it is a joined offence under Article 12, paragraph 1, letter b), or an aggravating
%circumstance emerges, the Public Prosecutor shall modify the accusation and bring it against the accused who is present.
%If the accused is not present, the modified accusation shall be brought against the lawyer who represents the accused.
%2. If a new criminal act against the accused emerges, which is not listed in the request for committal to trial
%and is subject to prosecution of the Public Prosecutor‟s motion, the Preliminary Hearing Judge shall authorise
%its notification if the Public Prosecutor requests so and the accused gives his consent.

%Article 604 code of criminal procedure
%1. The appeal court, in the cases provided for in Article 522, shall declare the nullity of the appealed judgment,
%in whole or in part, and shall order that the case file be forwarded to the first-instance court, in the event
%of a conviction for a different criminal act or the application of an aggravating circumstance for which the
%law sets a type of penalty other than the standard one imposed for such offence or the application of an
%aggravating circumstance having special effect, provided that mitigating circumstances are not considered as prevailing or equivalent.
%2. If mitigating circumstances are considered as prevailing or equivalent or aggravating circumstances other than those
%provided for in paragraph 1 are applied, the appeal court shall exclude the aggravating circumstances, perform a new
%comparison, if necessary, and establish a new penalty.
%3. In case of conviction for a concurrent offence or a new criminal act, the appeal court shall declare the related
%section of the judgment null and eliminate the corresponding penalty, ordering that the new decision be forwarded
%to the Public Prosecutor for his decisions.

%Article 134 code of criminal procedure
%1. Acts shall be reported in records.
%2. Records shall be drafted, fully or in summary form, by means of either a stenotype machine, any other mechanical tool or,
%in case these tools are not available, handwritten notes.
%3. If records are drafted in summary form, audio recordings shall also be made.
%4. If the recording methods referred to in paragraphs 2 and 3 are considered insufficient, an audiovisual recording may
%be added, if absolutely essential. Audiovisual recordings of the statements made by a victim with specific protection
%needs may be made in any case, even when they are not absolutely essential.

%% auxiliary_right(_art141, PersonId, _record, _questioning)
%
% Article 141 bis code of criminal procedure
%
% 1. Any questioning conducted outside the hearing of a person who is detained for any reason is to be documented fully,
% under penalty of exclusion, by means of audio or audiovisual recording. If recording tools or technical personnel are
% unavailable, reports by either experts or technical consultants shall be required. The questioning shall also be
% recorded in summary form. The transcription of the recording shall be ordered only upon request of the parties.
auxiliary_right_scope(art141, [art388]).

auxiliary_right(art141, PersonId, record, questioning) :-
    person_status(PersonId, detained),
    proceeding_matter(PersonId, questioning).

%Article 416(1) code of criminal procedure
%1. The request to proceed to trial shall be filed by the Public Prosecutor with the Court Registry.
%The request shall be considered null if it is not preceded by the warnings provided for in Article 415-bis, as well as
%by the summons to appear for questioning according to Article 375, paragraph 3, if the suspect has requested the
%questioning within the time limit referred to in Article 415-bis, paragraph 3.

%Article 178(1)(c) code of criminal procedure
%1. Under penalty of nullity, compliance with the provisions regarding the following is always mandatory:
%c) the participation, assistance and representation of the accused person and other private parties as well as the
%summons for trial for the victim and the complainant.