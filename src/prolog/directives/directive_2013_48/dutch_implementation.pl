:- module(directive_2013_48_nl, [has_right/5, auxiliary_right/5, auxiliary_right_checked/5, right_property/5, right_property_checked/5, explain/2]).

:- include('./../../utils.pl').

has_right(Right, nl, Article, PersonId, Matter) :-
    has_right(Article, PersonId, Right, Matter).

%%%%%(Dutch) Code of Criminal Procedure%%%%%

%% has_right(_art27c_2, PersonId, _right_to_information, _)
%
% Article 27c(2) code of criminal procedure
%
% Preceding to the first interrogation and without prejudice to the provisions of Article 29(2), the suspect who has not been
% arrested shall be informed of his right to legal assistance, referred to in Article 28(1) and, if applicable, his right to
% interpretation and translation, referred to in Article 27(4).
has_right(art27c_2, PersonId, right_to_information, lawyer) :-
    person_status(PersonId, suspect),
    \+ person_status(PersonId, arrested).

has_right(art27c_2, PersonId, right_to_information, interpretation) :-
    person_status(PersonId, suspect),
    \+ person_status(PersonId, arrested).

has_right(art27c_2, PersonId, right_to_information, translation) :-
    person_status(PersonId, suspect),
    \+ person_status(PersonId, arrested).

%% has_right(_art27c_3, PersonId, _right_to_information, _)
%
% Article 27c(3) code of criminal procedure
%
% Promptly upon arrest, but at the latest preceding the first interrogation, the suspect shall be informed in writing of:
% b) the rights referred to in paragraph 2;
has_right(art27c_3_b, PersonId, right_to_information, lawyer) :-
    person_status(PersonId, arrested).

has_right(art27c_3_b, PersonId, right_to_information, interpretation) :-
    person_status(PersonId, arrested).

has_right(art27c_3_b, PersonId, right_to_information, translation) :-
    person_status(PersonId, arrested).

%Article 27d code of criminal procedure
%The law enforcement officer who invites a person to give a statement, shall inform him of whether he will be questioned
%as a witness or as a suspect.
%If a person who was initially questioned as a witness becomes, in the course of the interview, suspect in accordance
%with Article 27(1), the officer conducting the questioning shall provide this person with the information as referred to
%in Article 27c(1) and (2) if he wishes to continue the interview.
person_status(PersonId, suspect):-
%    proceeding_matter(PersonId, questioning),
    person_status(PersonId, raise_suspicion).

%% has_right(_art28, PersonId, _right_to_access_lawyer, _trial)
%
% Article 28 code of criminal procedure
%
% The suspect or accused shall have the right to be assisted by defence counsel in accordance with the provisions of this Code.
% Legal assistance shall be provided to the suspect or accused in accordance with the manner provided by law, by an assigned defence
% counsel or defence counsel of his choice.
% In special cases and upon reasoned request by the suspect or accused, more than one defence counsel may be assigned.
% On each occasion that he requests to speak to his defence counsel, the suspect or accused shall be given the opportunity to do so
% as much as possible.
has_right(art28, PersonId, right_to_access_lawyer, trial):-
    person_status(PersonId, suspect);
    person_status(PersonId, accused).

%% has_right(_art28b, PersonId, _right_to_access_lawyer, _trial)
%
% Article 28b code of criminal procedure
%
% 1. If a vulnerable suspect or a suspect of a crime punishable by twelve years' imprisonment
% or more has been arrested, the assistant public prosecutor to have ordered their detention for investigation at the arraignment
% shall notify the governing body of the Legal Aid Board of the arrest immediately, in order that the governing board assign a lawyer.
% This notification need not take place if the suspect or accused person has chosen a lawyer and this lawyer or their replacement
% is available promptly.
% 2. If a person suspected or accused of a crime in respect of which pre-trial detention is permitted to have been arrested has,
% in reply to a question put to him, requested legal assistance, the assistant public prosecutor to have ordered his detention
% for investigation at the arraignment shall inform the governing body of the Legal Aid Board of the arrest immediately, in order
% that the governing board assign a lawyer. The second sentence of the first paragraph shall apply mutatis mutandis.
% 3. If a person suspected or accused of a crime in respect of which pre-trial detention is not permitted to have been arrested has,
% in reply to a question put to him, requested legal assistance, he shall be given the opportunity to contact a lawyer of his own choice.
% 4. If the assigned lawyer is not available within two hours of the notification referred to in the first, second or third paragraph
% being given, and if the chosen lawyer is not available within two hours of the contact with the suspect or accused pursuant to
% the first, second and third paragraph, the assistant public prosecutor may, if the suspect or accused waives his right to legal
% assistance in connection with the questioning, decide to commence the questioning of the suspect or accused.

has_right(art28b_1, PersonId, right_to_access_lawyer, trial):-
    person_status(PersonId, suspect),
    person_status(PersonId, detained),
    person_status(PersonId, vulnerable),
    \+ exception(has_right(art28b_1, PersonId, right_to_access_lawyer, trial), _).

has_right(art28b_3, PersonId, right_to_access_lawyer, trial):-
    person_status(PersonId, arrested),
    proceeding_matter(PersonId, imprisonment_over_twelve_years),
    \+ proceeding_matter(PersonId, pre_trial_detention),
    \+ exception(has_right(art28b_3, PersonId, right_to_access_lawyer, trial), _).

exception(has_right(_, PersonId, right_to_access_lawyer, trial), art28b_4) :-
    proceeding_matter(PersonId, questioning),
    person_request_submitted(PersonId, waive_right).

%% exception(_has_right(_art28b_1, PersonId, _right_to_access_lawyer, _trial), _art28c)
%
% Article 28c code of criminal procedure
%
% The suspect or accused person to have been arrested and in respect of whom a lawyer is available pursuant to Article 28b, shall
% best round of questioning for a maximum of half an hour.
% If this time-limit appears to be insufficient, the assistant public pr given the opportunity to consult with their lawyer prior to the firosecutor may, upon the request of the suspect or accused
% person or their lawyer, extend it for a maximum of half an hour, unless it would be contrary to the interests of the investigation
% to do so. The consultation may also take place by telecommunication.
% The suspect or accused person as per Article 28b(1), may only waive the consultation provided for the in the first paragraph,
% after he has been informed by a lawyer of the consequences thereof.
exception(has_right(art28b_1, PersonId, right_to_access_lawyer, trial), art28c) :-
    person_request_submitted(PersonId, waive_right),
    person_status(PersonId, informed_consequences).

%% has_right(_art28d, PersonId, _right_to_access_lawyer, _questioning)
%
% Article 28d code of criminal procedure
%
% Upon request of the suspect or accused person to have been arrested and the suspect or accused person to have been invited
% to a place of questioning, the lawyer may attend the questioning and participate therein. The request shall be addressed to
% the officer conducting the questioning or the assistant public prosecutor.
has_right(art28d, PersonId, right_to_access_lawyer, questioning):-
    (   person_status(PersonId, suspect)
    ;   person_status(PersonId, accused)
    ),
    (   proceeding_matter(PersonId, europeanArrestWarrant)
    ;   proceeding_matter(PersonId, questioning)
    ),
    person_request_submitted(PersonId, lawyer_participation),
    \+ exception(has_right(art28d, PersonId, right_to_access_lawyer, questioning), _).

% does being arrested consitute a requirement?

%% exception(_has_right(_art28d, PersonId, _right_to_access_lawyer, _questioning), _art28d_2)
%
% Article 28d.2
%
% During questioning not attended by a lawyer, the suspect or accused person may request that it be suspended in order to consult
% with a lawyer. The officer conducting the questioning shall give him the opportunity to do so as much as possible, unless by
% granting repeated requests in this regard the order or progress of the questioning would be disrupted.
exception(has_right(art28d, PersonId, right_to_access_lawyer, questioning), art28d_2) :-
    proceeding_event(PersonId, disrupt_order).

%% auxiliary_right(_art28d_3, PersonId, _record, _decision)
%
%  Article 28d.3
%
% The decision denying requests as per the first and second paragraph shall apply for the remainder of the period of questioning
% and shall be noted in the official report of the interview, thereby specifying the grounds on which it was made.
% Further rules regarding the format of, and the preservation of order during, questioning, may be set by Legislative Decree.
auxiliary_right_scope(art28d_3, [art28d]).

auxiliary_right(art28d_3, PersonId, record, decision) :-
    exception(has_right(art28d, PersonId, right_to_access_lawyer, questioning), art28d_2).

% Article 28(4) code of criminal procedure
% On each occasion that he requests to speak to his defence counsel, the suspect shall be given the
% opportunity to do so as much as possible.

%% exception(_has_right(_art28d, PersonId, _right_to_access_lawyer, _questioning), _art28e_2)
%
% Article 28e code of criminal procedure
%
% 1. The assistant public prosecutor may decide that:
% a. the suspect to have been arrested, without having been given the opportunity to exercise his right as per Article 28(1),
% shall be questioned on the spot immediately following arrest,
% b. the questioning as per Article 28d(1) shall be commenced in the absence of defence counsel,
% c. the questioning as per Article 28d(1) shall be commenced or continued without the suspect to have been arrested being given
% the opportunity to exercise the right of consultation as per Article 28c(1),
% d. defence counsel may not attend the questioning as per Article 28d(1).
% 2. The decisions provided for in the first paragraph may only be taken to the extent that and for as long as they are justified by
% the urgent need to:
% a. avert serious adverse consequences for the life, liberty or physical integrity of a person or
% b. to prevent substantial damage to the investigation.
exception(has_right(art28d, PersonId, right_to_access_lawyer, questioning), art28e_2) :-
    person_danger(PersonId, life);
    person_danger(PersonId, liberty);
    person_danger(PersonId, physical_integrity).

exception(has_right(art28d, PersonId, right_to_access_lawyer, questioning), art28e_2) :-
    proceeding_matter(PersonId, prevent_damage_investigation).

%% has_right(_art45, PersonId, _right_to_access_lawyer, _)
%
% Article 45 code of criminal procedure
%
% The defence counsel shall have free access to the suspect or accused person to have been deprived of his liberty by law,
% and may confer with him in private and exchange letters with him which may not be inspected or read by others, under the
% required supervision and subject to the internal rules and regulations, and such access may not cause any delay in the investigation.
has_right(art45, PersonId, right_to_access_lawyer, trial):-
    (   person_status(PersonId, suspect)
    ;   person_status(PersonId, accused)
    ),
    person_status(PersonId, deprived_of_liberty).

auxiliary_right_scope(art45_1, [art45]).

auxiliary_right(art45_1, PersonId, access_lawyer, private_communication).

%% has_right(_art57_2, PersonId, _right_to_access_lawyer, _questioning)
%
% Article 57(2) code of criminal procedure
%
% The suspect shall have the right to have a defence counsel present during questioning. The defence counsel shall be given the
% opportunity to make such comments as he sees fit during questioning.
has_right(art57_2, PersonId, right_to_access_lawyer, questioning):-
    person_status(PersonId, suspect),
    proceeding_matter(PersonId, questioning).

% Article 59a(2) code of criminal procedure
%The investigating judge shall promptly set, after having received an application to that effect from the public prosecutor,
%the time and place at which the suspect is to be arraigned before him and he shall notify the public prosecutor, the suspect
%and the defence counsel thereof.

%% has_right(_art59a_3, PersonId, _right_to_access_lawyer, _arraignment)
%
% Article 59a(3) code of criminal procedure
%
% The suspect shall have the right to be assisted by defence counsel at the arraignment. The defence counsel shall be given
% the opportunity to make such comments as he sees fit during the arraignment. The public prosecutor may be present at the
% arraignment and make such comments as he sees fit.
has_right(art59a_3, PersonId, right_to_access_lawyer, arraignment):-
    person_status(PersonId, suspect),
    proceeding_matter(PersonId, arraignment).
% TODO - is this the same as summoned at court?

% Article 61a(1) code of criminal procedure
% Measures to be taken against the suspect detained for investigative purposes may be ordered in the interest of the investigation.
% Such measures may include, inter alia:
% TODO

%% has_right(_art62_1, PersonId, _presentation, _not_restrictions)
%
% Article 62(1) code of criminal procedure
%
% The suspect taken into police custody shall not be subjected to any restrictions other than those that are absolutely necessary in
% the interest of the investigation and in the interest of order.
has_right(art62_1, PersonId, presentation, not_restrictions) :-
    person_status(PersonId, police_custody),
    \+ proceeding_circumstance(PersonId, necessary_investigation).

%% has_right(_art63_4, PersonId, _right_to_access_lawyer, _examining_magistrate)
%
% Article 63(4) code of criminal procedure
%
% The suspect shall have the right to have a defence counsel present when he is arraigned before the examining magistrate.
% The defence counsel shall be given the opportunity to make such comments as he sees fit during the arraignment.
has_right(art63_4, PersonId, right_to_access_lawyer, examining_magistrate):-
    person_status(PersonId, suspect),
    proceeding_matter(PersonId, arraignment).

%% has_right(_art65_1, PersonId, _right_to_be_questioned, _detention_on_remand)
%
% Article 65(1) code of criminal procedure
%
% The District Court may, on application of the public prosecutor, order the remand detention of the suspect who is remanded in
% custody. The suspect shall be heard prior to issuing such order, unless he has declared in writing that he waives his right
% to be heard. The District Court or the presiding judge, may, notwithstanding such declaration, order that the suspect be
% forcibly brought to court.
has_right(art65_1, PersonId, right_to_be_questioned, detention_on_remand):-
    person_status(PersonId, suspect),
    proceeding_matter(PersonId, detention_on_remand),
    \+ person_request_submitted(PersonId, waive_right).

%% has_right(_art86_2, PersonId, _right_to_access_lawyer, _investigating_judge)
%
% Article 86(2) code of criminal procedure
%
% The suspect shall have the right to have a defence counsel present when he is arraigned before the investigating judge
% The defence counsel shall be given the opportunity to make such comments as he deems fit during the arraignment.
has_right(art86_2, PersonId, right_to_access_lawyer, investigating_judge):-
    person_status(PersonId, suspect),
    proceeding_matter(PersonId, arraignment).

%% has_right(_art98_1, PersonId, _right_to_access_lawyer, _private_communication)
%
% Article 98 code of criminal procedure
%
% Letters or other documents which are subject to the duty of secrecy of persons who have the right to assert privilege,
% as referred to in Articles 218 and 218a, shall not be seized from them, unless with their consent. The investigating judge
% is authorized to make this determination.
% If a person who has the right to assert privilege objects to the seizure of letters or other documents because they are subject
% to the duty of secrecy, they shall not be examined until the investigating judge has issued a decision on the objection.
% The investigating judge who decides that the seizure is permissible, shall inform the person who has the right to assert privilege
% that they may file a complaint against the decision with the court of first instance before which the case shall be prosecuted and
% also that the letters or documents shall not be examined until a final decision has been issued on the complaint.
% The person who has the right to assert privilege may file a complaint against the investigating judge's decision within fourteen days
% of it being served with the court of first instance before which the case shall be prosecuted. Article 552a shall apply.
% Unless such persons have consented to a search, a search shall only be conducted at their premises insofar as this search can be
% conducted without violating clerical secrecy, professional privilege or official secrecy and it shall not include letters or
% documents other than those which are the subject of the criminal offence or have been used in its commission.
% The investigating judge may, in determining the acceptability of the reliance of a person who has the right to assert privilege
% on the duty of secrecy, allow himself to be informed by a representative of the profession to which that person concerned belongs.
auxiliary_right_scope(art98_1, [art45]).

auxiliary_right(art98_1, PersonId, access_lawyer, private_communication).

auxiliary_right_scope(art98_3, [art45]).

auxiliary_right(art98_3, PersonId, remedy, decision).

%% has_right(_art151_2, PersonId, _right_to_information, _investigative_act)
%
% Article 151(2) code of criminal procedure
%
% The public prosecutor shall, insofar as the interest of the investigation permits, timely notify the suspect and his defence
% counsel in writing of the planned inspection. In addition, the assistant public prosecutor shall timely notify the public
% prosecutor of the planned inspection.
has_right(art151_2, PersonId, right_to_information, investigative_act):-
    person_status(PersonId, suspect),
    proceeding_matter(PersonId, inspection).

%% has_right(_art151_3, PersonId, _right_to_attend, _investigation)
%
% Article 151(3) code of criminal procedure
%
% The public prosecutor or the assistant public prosecutor shall, insofar as the interest of the investigation permits, let the
% suspect and his defence counsel attend the entire or part of the inspection; they may request to be permitted to give
% instructions or provide information or to have certain comments included in the official record.
has_right(art151_3, PersonId, right_to_attend, investigation):-
    person_status(PersonId, suspect),
    proceeding_matter(PersonId, inspection).

%% has_right(_art186a, PersonId, _right_to_access_lawyer, _questioning)
%
% Article 186a code of criminal procedure
%
% The defence counsel may be present at the questionings conducted by the investigating judge, unless the interest of the
% investigation does not permit his presence.
% The investigating judge may, if he considers such desirable in the interest of the investigation, also give the suspect
% the opportunity to be present at the questioning of a witness or expert witness.
% Article 186(2) and (3) shall apply mutatis mutandis in regard of the defence counsel and the suspect.
has_right(art186a, PersonId, right_to_access_lawyer, questioning):-
    person_status(PersonId, suspect),
    (   proceeding_matter(PersonId, questioning)
    ;   proceeding_matter(PersonId, witness_questioning)
    ),
    \+ proceeding_event(PersonId, superseding_interest).

%% has_right(_art193, PersonId, _right_to_attend_inspection, _investigating_judge)
%
% Article 193 code of criminal procedure
%
% The investigating judge shall timely notify the planned inspection to the public prosecutor and, insofar as the interest of the
% investigation permits, the suspect.
% The public prosecutor may be present at each inspection. The investigating judge shall, insofar as the interest of the
% investigation permits, let the suspect attend the entire or part of the inspection; he may request to be permitted to give
% instructions or provide information or to have certain comments included in the official record.
has_right(art193, PersonId, right_to_attend_inspection, investigating_judge):-
    person_status(PersonId, suspect),
    proceeding_matter(PersonId, inspection).

%% auxiliary_right(_art359a_1, PersonId, _remedy, _decision)
%
% Article 359a(1) code of criminal procedure
%
% (1) The District Court may, if it appears that procedural requirements were not complied with during the preliminary investigation
% which can no longer be remedied and the law does not provide for the legal consequences thereof, determine that:
% a. the length of the sentence shall be reduced in proportion to the gravity of the non-compliance with procedural requirements,
% if the harm or prejudice caused can be compensated in this manner;
% b. the results obtained from the investigation, in which there  was a failure to comply with procedural requirements, may not be
% used as evidence of the offence as charged in the indictment;
% c. there is a bar to the prosecution, if as a result of the procedural error or omission there cannot be said to be a trial of
% the case which meets the principles of due process.
auxiliary_right_scope(art359a_1, [art28, art28b_1, art28b_2, art28b_3, art28d, art28d_2, art45, art57_2, art59a_3, art62_1, art63_4, art65_1, art86_2, art98_1, art151_2, art151_3, art186a, art193, art488ac, art488b, art489]).

auxiliary_right(art359a_1, PersonId, remedy, decision) :-
    proceeding_matter(PersonId, violation_procedural_law).

% Article 359a(2-3) code of criminal procedure
% (2) In the application of paragraph 1, the District Court shall take into account the interest served by the violated rule, the
% gravity of the procedural error or omission and the harm or prejudice caused as a result of said error or omission.
% (3) The judgment shall contain the decisions referred to in paragraph 1. Said decisions shall be reasoned

%% has_right(_art488ac, PersonId, _right_to_audiovisual_recording, _interview)
%
% Article 488ac code of criminal procedure
%
% The audiovisual recording of an interview carried out by a law enforcement officer shall be arranged if the seriousness
% of the offence or the personality of the suspect so requires.
has_right(art488ac, PersonId, right_to_audiovisual_recording, interview):-
    proceeding_event(PersonId, seriousness_offence);
    proceeding_event(PersonId, personality_subject).

%% has_right(_art488b, PersonId, _right_to_information, _)
%
% Article 488b code of criminal procedure
%
% In derogation of Article 27e(1), the assistant public prosecutor to have ordered the suspect's detention for investigation
% at the arraignment shall notify the parents or guardian of the deprivation of liberty and the reasons for it as soon as possible.
% The parents or guardian shall furthermore receive a notification of the rights provided for in Article 488aa.
% The notification of rights provided for in the first paragraph, shall not take place when:
% (a) this would contrary to the interests of the suspect;
% (b) the notification is not possible because despite reasonable efforts the parents or guardian cannot be reached or identified.
% In the case referred to in paragraph 2, the information shall be provided to a confidant. If no confidant has been nominated,
% the information shall be provided to the Child Care and Protection Board.

has_right(art488b, PersonId, right_to_information, parent):-
    person_status(PersonId, suspect),
    person_status(PersonId, deprived_of_liberty),
    \+ exception(has_right(art488b, PersonId, right_to_information, parent), _).

exception(has_right(art488b, PersonId, right_to_information, parent), art488b_a) :-
    proceeding_event(PersonId, contrary_to_interest).

exception(has_right(art488b, PersonId, right_to_information, parent), art488b_b) :-
    proceeding_event(PersonId, cannot_parent_notified).

has_right(art488b, PersonId, right_to_information, confidant):-
    person_status(PersonId, suspect),
    (   proceeding_event(PersonId, contrary_to_interest)
    ;   proceeding_event(PersonId, cannot_parent_notified)
    ).
% TODO - should we have articles 1 applies IF NOT articles 2? or keep it like this?
% TODO - an arraignment implies that a formal charge has been done, should it not be accused?, what should the predicate be? trial has started?

% TODO - Where the circumstances, referred to in paragraph 2, cease to exist, the information shall be provided to the parents or guardian.
% TODO - add an exception to previous article? add new articles?

%% has_right(_art489, PersonId, _right_to_access_lawyer, _trial)
%
% Article 489 code of criminal procedure
%
% If a suspect has been arrested, the public prosecutor or the assistant public prosecutor to have ordered his detention for
% investigation at the arraignment shall notify the governing body of the Legal Aid Board immediately, in order that the governing
% board assign a lawyer. This notification need not take place if the suspect or accused person has chosen a lawyer and this lawyer
% or their replacement is available promptly. Article 28a does not apply. If a suspect has been sent away in the evening hours
% because no lawyer is available, and simultaneously has been informed that he will be questioned the next day, paragraph
% 1 applies to that interview.
has_right(art489, PersonId, right_to_access_lawyer, trial):-
    person_status(PersonId, arrested),
    person_status(PersonId, detained).

%%% (Dutch) Surrender of Persons Act %%%%

%% has_right(art17_3, PersonId, right_to_information, _)
%
% Article 17(3) surrender of persons act
%
% Following the requested person's arrest, he shall promptly be notified in writing of:
% a. the right to receive a copy of the European arrest warrant as per Article 23(3);
% b. the right to be assisted by a lawyer as per Article 43a, and the right to request the appointment of a lawyer in the issuing Member State as per Article 21a;
% c. the right to interpretation as per Article 30, and the right to translation as per Article 23(3), fourth and fifth sentence;
% d. the right to be heard as per Article 24;
% e. the rights provided for in Article 27c(3)(g) and (h) of the Code of Criminal Procedure.
% If the requested person does not command, or does not command sufficiently, the Dutch language, this notification shall be made in a manner intelligible to him.
% Articles 27e, 488ab and 488b of the Code of Criminal Procedure shall apply mutatis mutandis.

has_right(art17_3a, PersonId, right_to_information, receive_copy_europeanArrestWarrant) :-
    person_status(PersonId, requested),
    proceeding_matter(PersonId, arrest).

has_right(art17_3b, PersonId, right_to_information, access_lawyer) :-
    person_status(PersonId, requested),
    proceeding_matter(PersonId, arrest).

has_right(art17_3c, PersonId, right_to_information, interpretation_translation) :-
    person_status(PersonId, requested),
    proceeding_matter(PersonId, arrest).

has_right(art17_3d, PersonId, right_to_information, right_be_heard) :-
    person_status(PersonId, requested),
    proceeding_matter(PersonId, arrest).

%% has_right(_art18_2, PersonId, _right_to_access_lawyer, _hearing)
%
% Article 18(2) surrender of persons act
%
% Before issuing an order as per paragraph 1, the investigating judge shall, if possible, hear the requested person.
% The requested person shall have the right to have a defence counsel present when he is arraigned.
has_right(art18_2, PersonId, right_to_access_lawyer, hearing) :-
    person_status(PersonId, requested),
    proceeding_matter(PersonId, arraignment).

%% has_right(_art21a, PersonId, _right_to_access_lawyer, _executingMemberStates)
%
% Article 21a surrender of persons act
%
% The requested person to have been arrested, may request that a lawyer be appointed in the executing Member State with a view to them
% assisting his lawyer in the Netherlands, through the provision of information and advice, in the surrender proceedings in the Netherlands.
% Upon receiving such a request, the public prosecutor shall inform the authorities in the issuing state of the request immediately;
% this provision shall apply without prejudice to the time-limits that apply to the European arrest warrant.
has_right(art21a, PersonId, right_to_access_lawyer, executingMemberStates) :-
    person_status(PersonId, requested),
    person_request_submitted(PersonId, appoint_lawyer).

%% has_right(_art25_3, PersonId, _right_to_access_lawyer, _questioning)
%
% Article 25(3) surrender of persons act
%
% The requested person may be assisted by his legal counsel during questioning.
has_right(art25_3, PersonId, right_to_access_lawyer, questioning) :-
    person_status(PersonId, requested),
    proceeding_matter(PersonId, questioning).

%% auxiliary_right(_art28, PersonId, _remedy, _europeanArrestWarrant)
%
% Article 28 surrender of persons act
%
% 1. No later than fourteen days from completion of the court hearing, the court shall give its verdict on the surrender.
% The verdict shall be supported by reasons.
% 2. If the court finds either that the European arrest warrant does not meet the
% requirements of Article 2, or that surrender cannot be allowed, or that there can be no
% suspicion that the requested person is guilty of the acts for which his surrender is
% requested, its verdict shall refuse surrender.
auxiliary_right_scope(art28, [art17_3b, art17_3c, art17_3d, art21a, art25_3]).

auxiliary_right(art28, PersonId, remedy, europeanArrestWarrant).

% TODO - is this a right? looks like it's up to the court to decide, no input for the defendant?

%% has_right(_art43a, PersonId, _right_to_access_lawyer, _trial)
%
% Article 43a surrender of persons act
%
% In the proceedings for surrender of a person by the Netherlands, the requested person has the right to be assisted by a lawyer.
% Articles 28, 28a, 28c(2), 29a(1), 37, 38, 43 to 45 and 124 of the Code of Criminal Procedure shall apply mutatis mutandis.
has_right(art43a, PersonId, right_to_access_lawyer, trial):-
    person_status(PersonId, requested),
    proceeding_matter(PersonId, surrender).

%If a requested person is arrested pursuant to this statute, the assistant public prosecutor shall notify the governing body of the
%Legal Aid Board thereof, in order that the governing body appoints a lawyer. Articles 28b(1), second sentence, and 39 of the Code
%of Criminal Procedure shall apply mutatis mutandis.
%If the lawyer is not available within two hours of the notification as per the second paragraph being given, the public prosecutor
%or, with the public prosecutor's permission, the assistant public prosecutor, may begin questioning the requested person in connection
%with the decision on whether to take them into police custody within the meaning of Article 17(4) and 21(5).
%The requested person in respect of whom a lawyer is available pursuant to the second paragraph, shall be given the opportunity to
%consult with their lawyer prior to questioning in connection with the decision to be taken within the meaning of the third paragraph
%for a maximum of half an hour.

%If a person who does not have a lawyer pursuant to this statute is deprived of their liberty - other than pursuant to a European
%arrest warrant or a Dutch warrant of arrest or provisional arrest, or an order to be taken into police custody or for such custody
%to be extended - the governing body of the Legal Aid Board shall, upon notification of the deprivation of liberty by the Public
%Prosecution Service, appoint a lawyer.

%%%% Custodial Institutions (Framework) Act %%%%

%% has_right(_art36, PersonId, _right_to_communicate, _letters)
%
% Article 36 custodial institutions (framework) act
%
% 1. Save for the restrictions to be established under paragraphs 2, 3 and 4, the prisoner shall have
% a right to send and receive letters and items by post. The costs involved shall be for the prisoner's
% account unless the governor determines otherwise.
has_right(art36, PersonId, right_to_communicate, letters) :-
    person_status(PersonId, prisoner).

% 4. The governor may refuse to distribute certain letters or other postal items as well as enclosed objects
% if this is necessary with a view to the following interests:
% a. the maintenance of order or safety in the institution;
% b. the protection of public order or national security;
% c. the prevention or investigation of criminal offences;
% d. the protection of victims of, or those involved otherwise in criminal offences.
% TODO - Fix as exception + Article 37 code of criminal procedure?

%% has_right(_art38, PersonId, _right_to_communicate, _receive_visitors)
%
% Article 38(1) custodial institutions (framework) act
%
% The prisoner shall have a right to receive visitors for at least one hour per week at the times and places laid down in the prison rules.
% Our Minister may establish further rules concerning the admission and refusal of visitors. The prison rules shall contain rules concerning visit requests.
has_right(art38, PersonId, right_to_communicate, receive_visitors) :-
    person_status(PersonId, prisoner).

%% has_right(_art39_4, PersonId, _right_to_communicate, _cellphone)
%
% Article 39(4) custodial institutions (framework) act
%
% The prisoner shall be allowed to have phone contact with the persons and bodies referred to in
% Article 37, paragraph 1, if the necessity and opportunity exist for this. No other supervision shall
% be exercised over these conversations than that necessary to establish the identity of the persons or
% bodies with which the prisoner conducts or desires to conduct a phone conversation.
has_right(art39_4, PersonId, right_to_communicate, cellphone) :-
    person_status(PersonId, prisoner).
% TODO - Add art37


%%%% Young Offenders Institutions (Framework) Act %%%%%

%% has_right(_art41, PersonId, _right_to_communicate, _letters)
%
% Article 41 young offender (framework) act
%
% 1. Save for the restrictions to be established under paragraphs 2, 3 and 4, the juvenile shall have a right to send and receive
% letters and items by post. The costs involved shall be for the juvenile's account unless the governor determines otherwise.
has_right(art41, PersonId, right_to_communicate, letters):-
    person_status(PersonId, child),
    \+ exception(has_right(art41, PersonId, right_to_communicate, letters), art41_4).

%2. The governor shall have the authority to examine envelopes or other postal items sent by or intended for juveniles for the
%presence of enclosed objects and to open them for that purpose. If the envelopes or other postal items are sent by or are
%intended for the persons or bodies referred to in Article 42, paragraph 1 or 2, this examination shall be carried out in the
%presence of the juvenile involved.

%% auxiliary_right(art41_3, PersonId, right_to_information, supervision)
%
% Article 41.3
%
% 3. The governor shall have the authority to exercise supervision over the letters and postal items sent by or intended for
% juveniles with a view to the interests set out in the fourth paragraph. This supervision may comprise the copying of letters or
% other postal items. The juveniles shall be notified beforehand of the way in which supervision will be exercised.
auxiliary_right_scope(art41_3, [art41]).

auxiliary_right(art41_3, PersonId, right_to_information, supervision) :-
    authority_decision(PersonId, postal_supervision).

%4. The governor may refuse to distribute certain letters or other postal items as well as enclosed objects if this is necessary
%with a view to the following interests:
%a. the maintenance of order or safety in the institution;
%b. the protection of public order or national security;
%c. the prevention or investigation of criminal offences;
%d. the protection of victims of, or those involved otherwise in criminal offences;
%e. the execution of the perspective plan.
exception(has_right(art41, PersonId, right_to_information, supervision), art41_4) :-
    proceeding_event(PersonId, institution_safety);
    proceeding_event(PersonId, national_security);
    proceeding_event(PersonId, public_order);
    proceeding_event(PersonId, investigation_criminal_offence);
    proceeding_event(PersonId, prevent_criminal_offence);
    proceeding_event(PersonId, victim_protection);
    proceeding_event(PersonId, execution_perspective_plan).

%5. The governor shall ensure that the letters or other postal items or enclosed objects that are not distributed are either
%returned to the juvenile or sent at his expense to the sender or to an address given by the juvenile, or placed in safekeeping
%for the juvenile with issue of a receipt, or destroyed with the juvenile's consent, or handed to a law enforcement officer with
%a view to the prevention or investigation of criminal offences.

%% has_right(_art43_1, PersonId, _right_to_communicate, _receive_visitors)
%
% Article 43(1) young offender (framework) act
%
% The juvenile shall have a right to receive visitors for at least one hour per week at the times and places laid down in the prison rules. 
% Our Minister may establish further rules concerning the admission and refusal of visitors. The prison rules shall contain rules concerning visit requests.
has_right(art43_1, PersonId, right_to_communicate, receive_visitors) :-
    person_status(PersonId, child),
    person_status(PersonId, prisoner).

%% has_right(_art44_4, PersonId, _right_to_communicate, _cellphone)
%
% Article 44(4) young offender (framework) act
%
% The juvenile shall be allowed to have phone contact with the persons and bodies referred to in Article 42, paragraph 1,
% if the necessity and opportunity exist for this. No other supervision shall be exercised over these conversations than that
% necessary to establish the identity of the persons or bodies with which the juvenile conducts or desires to conduct a phone
% conversation.
has_right(art44_4, PersonId, right_to_communicate, cellphone):-
    person_status(PersonId, child),
    art37Applies(PersonId).

%%%%% Decree on the Application of Measures in the Interests of the Investigation %%%%%
%% has_right(_art9, PersonId, _right_to_access_lawyer, _identity_parade)
%
% Article 9 Decree on the Application of Measures in the Interests of the Investigation
%
% The public prosecutor and counsel for the suspect shall be given the opportunity to follow the execution of the
% identity parade and shall, prior to the parade commencing, be given the opportunity to make comments regarding
% the selection to be shown, without this being able to lead to the parade being suspended.
% The comments made shall be noted in the official report or report provided for in Article 8(1).
has_right(art9, PersonId, right_to_access_lawyer, identity_parade) :-
    proceeding_matter(PersonId, identity_parade).

%%% Custodial Institutions (Framework) Act %%%%
%% Article 37(1)(i) code of criminal procedure
% 1. Article 36, paragraphs 3 and 4, shall not apply to letters addressed by the prisoner to, or sent by:
% i. his legal aid provider;

%%%% Official instruction for the national police corps, the royal gendarmerie and other investigating officers %%%%

%% has_right(_art27_1, PersonId, _right_to_inform, _relative_household)
%
% Article 27(1) Official instruction for the national police corps, the royal gendarmerie and other investigating officers
%
% Insofar as that provided for in the Code of Criminal Procedure does not dictate otherwise, the officer shall inform a
% relative or household member of the person taken into custody of the deprivation of liberty as soon as possible.
% Where the person taken into custody is a minor, the officer shall do so ex proprio motu, where the person taken into
% custody is of age, he shall only do so upon that person's request.
has_right(art27_1, PersonId, right_to_inform, relative_household) :-
    person_status(PersonId, deprived_of_liberty).

%%%% Vienna Convention on Consular Relations %%%%

%% has_right(_art36_1, PersonId, _right_to_communicate, _consul)
%
% Article 36 Vienna Convention on Consular Relations
%
% 1. With a view to facilitating the exercise of consular functions relating to nationals of the sending State:
% a. consular officers shall be free to communicate with nationals of the sending State and to have access to them.
% Nationals of the sending State shall have the same freedom with respect to communication with and access to consular
% officers of the sending State;
% b. if he so requests, the competent authorities of the receiving State shall, without delay, inform the consular
% post of the sending State if, within its consular district, a national of that State is arrested or committed to
% prison or to custody pending trial or is detained in any other manner. Any communication addressed to the consular
% post by the person arrested, in prison, custody or detention shall be forwarded by the said authorities without delay.
% The said authorities shall inform the person concerned without delay of his rights under this subparagraph;
% c. consular officers shall have the right to visit a national of the sending State who is in prison, custody or detention,
% to converse and correspond with him and to arrange for his legal representation. They shall also have the right to visit
% any national of the sending State who is in prison, custody or detention in their district in pursuance of a judgement.
% Nevertheless, consular officers shall refrain from taking action on behalf of a national who is in prison, custody or
% detention if he expressly opposes such action.
has_right(art36_1a, PersonId, right_to_communicate, consular_authority) :-
    proceeding_country(PersonId, Country),
    \+ person_nationality(PersonId, Country).

has_right(art36_1b, PersonId, right_to_communicate, consular_authority) :-
    person_status(PersonId, deprived_of_liberty),
    person_request_submitted(PersonId, communicate_consul).

has_right(art36, PersonId, right_to_visit, consular_authority) :-
    person_status(PersonId, deprived_of_liberty),
    proceeding_country(PersonId, Country),
    \+ person_nationality(PersonId, Country).

% 2. The rights referred to in paragraph 1 of this article shall be exercised in conformity with the laws and regulations
% of the receiving State, subject to the proviso, however, that the said laws and regulations must enable full effect to
% be given to the purposes for which the rights accorded under this article are intended.