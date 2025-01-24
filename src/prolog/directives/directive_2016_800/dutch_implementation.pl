:- module(directive_2016_800_nl, [has_right/5, auxiliary_right/5, auxiliary_right_checked/5, right_property/5, right_property_checked/5, explain/2]).

:- include('./../../utils.pl').

has_right(Right, nl, Article, PersonId, Matter) :-
    person_status(PersonId, child),
    has_right(Article, PersonId, Right, Matter).

person_status(PersonId, child):-
    person_age(PersonId, X),
    X < 18.

% TODO - add guardian/childcare/etc.

% Lexical Inconsistency %
%As a second preliminary remark, note that the term 'suspect' in this table may refer to the suspect or the accused, or both, 
%depending on the context. This corresponds to the Dutch legal terminology, in which persons suspected of a crime are called 'suspects', 
%both before and after indictment.

%%%%%Criminal Code%%%%%

%%Article 77s(2) code of criminal procedure
%The court shall impose the measure only after a reasoned, dated and signed opinion issued by no fewer than two behavioural 
%experts of different disciplines has been submitted to it. Such opinion shall be given jointly by the behavioural experts or 
%by each of them separately. Where the date of this opinion precedes the commencement of the trial by more than one year, 
%the court may only rely upon it with the consent of the Public Prosecution Service and of the defendant.

%%Article 77w(2) code of criminal procedure
%The court shall impose the measure only after a reasoned, dated and signed recommendation issued by the Child Care and Protection 
%Board, which is supported by at least one behavioural expert, has been submitted to it. Where the date of this recommendation 
%precedes the commencement of the trial by more than one year, the court may only rely upon it with the consent of the Public 
%Prosecution Service and the defendant. 

%%%%%(Dutch) Code of Criminal Procedure%%%%%

%%Article 27d code of criminal procedure
%The law enforcement officer who invites a person to give a statement, shall inform him of whether he will be questioned 
%as a witness or as a suspect.
%If a person who was initially questioned as a witness becomes, in the course of the interview, suspect in accordance 
%with Article 27(1), the officer conducting the questioning shall provide this person with the information as referred to 
%in Article 27c(1) and (2) if he wishes to continue the interview.
person_status(PersonId, suspect):-
%    proceeding_matter(PersonId, questioning),
    person_status(PersonId, raise_suspicion).

%% has_right(_art27e_1, PersonId, _right_to_inform, PersonId2)
%
% Article 27e code of criminal procedure
%
% 1.At the request of the suspect to have been arrested the assistant public prosecutor to have ordered their detention for 
% investigation at the arraignment shall notify at least one person nominated by the suspect of the arrest immediately.
has_right(art27e_1, PersonId, right_to_inform, PersonId2):-
    (   person_status(PersonId, arrested)
    ;   person_status(PersonId, detained)
    ),
    person_request_submitted(PersonId, inform_person),
    person_nominate(PersonId, PersonId2),
    \+ exception(has_right(article27e_1, PersonId, right_to_inform, PersonId2), _).

%% has_right(_art27e_2, PersonId, _right_to_inform, _consul)
%
% Article27e.2
%
% At the request of the suspect to have been arrested who does not have the Dutch nationality, the assistant public prosecutor 
% to have ordered their detention for investigation at the arraignment shall notify the consular post of the State of the 
% suspect's nationality of the arrest immediately.
has_right(art27e_2, PersonId, right_to_inform, consul):-
    (   person_status(PersonId, arrested)
    ;   person_status(PersonId, detained)
    ),
    person_request_submitted(PersonId, inform_consul),
    \+ person_nationality(PersonId, dutch).

%% exception(has_right(art27e_1, PersonId, right_to_inform, PersonId2), art27e_3)
%
% Article 27e.3-4
%
% The assistant public prosecutor may postpone the notification as per the first and second paragraphs insofar and for as long as 
% justified by an urgent need to: (a) avert serious adverse consequences for the life, liberty or physical integrity of a person 
% or (b) prevent substantial damage to the investigation.
% 4.The decision referred to in paragraph 3 as well as the grounds underlying this decision shall be recorded in writing.
exception(has_right(art27e_1, PersonId, right_to_inform, PersonId2), art27e_3) :-
    person_danger(PersonId, life);
    person_danger(PersonId, liberty);
    person_danger(PersonId, physical_integrity).

exception(has_right(art27e_1, PersonId, right_to_inform, PersonId2), art27e_3) :-
    proceeding_matter(PersonId, prevent_damage_investigation).

auxiliary_right(art27e_4, PersonId, record, decision) :-
    exception(has_right(art27e_1, PersonId, right_to_inform, PersonId2), art27e_3).

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
% If a vulnerable suspect or accused person or person suspected or accused of a crime punishable by twelve years' imprisonment 
% or more has been arrested, the assistant public prosecutor to have ordered their detention for investigation at the arraignment 
% shall notify the governing body of the Legal Aid Board of the arrest immediately, in order that the governing board assign a lawyer. 
% This notification need not take place if the suspect or accused person has chosen a lawyer and this lawyer or their replacement 
% is available promptly.
% If a person suspected or accused of a crime in respect of which pre-trial detention is permitted to have been arrested has, 
% in reply to a question put to him, requested legal assistance, the assistant public prosecutor to have ordered his detention 
% for investigation at the arraignment shall inform the governing body of the Legal Aid Board of the arrest immediately, in order 
% that the governing board assign a lawyer. The second sentence of the first paragraph shall apply mutatis mutandis.
% If a person suspected or accused of a crime in respect of which pre-trial detention is not permitted to have been arrested has, 
% in reply to a question put to him, requested legal assistance, he shall be given the opportunity to contact a lawyer of his own choice.

has_right(art28, PersonId, right_to_access_lawyer, trial):-
    person_status(PersonId, suspect);
    person_status(PersonId, accused).

has_right(art28b_1, PersonId, right_to_access_lawyer, trial):-
    (   person_status(PersonId, arrested)
    ;   person_status(PersonId, detained)
    ),
    person_status(PersonId, vulnerable),
    proceeding_matter(PersonId, imprisonment_over_twelve_years),
    \+ exception(has_right(art28b_1, PersonId, right_to_access_lawyer, trial), _).

has_right(art28b_2, PersonId, right_to_access_lawyer, trial):-
    person_status(PersonId, arrested),
    proceeding_matter(PersonId, pre_trial_detention),
    \+ exception(has_right(art28b_2, PersonId, right_to_access_lawyer, trial), _).

has_right(art28b_3, PersonId, right_to_access_lawyer, trial):-
    person_status(PersonId, arrested),
    \+ proceeding_matter(PersonId, pre_trial_detention),
    \+ exception(has_right(art28b_3, PersonId, right_to_access_lawyer, trial), _).

%% exception(_has_right(_, PersonId, _right_to_access_lawyer, _trial), _art28b_4)
%
% Article 28b.4
%
% If the assigned lawyer is not available within two hours of the notification referred to in the first, second or third paragraph 
% being given, and if the chosen lawyer is not available within two hours of the contact with the suspect or accused pursuant to 
% the first, second and third paragraph, the assistant public prosecutor may, if the suspect or accused waives his right to legal 
% assistance in connection with the questioning, decide to commence the questioning of the suspect or accused.
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
    proceeding_matter(PersonId, questioning),
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
% Article 28d.2
%
% The decision denying requests as per the first and second paragraph shall apply for the remainder of the period of questioning 
% and shall be noted in the official report of the interview, thereby specifying the grounds on which it was made.
% Further rules regarding the format of, and the preservation of order during, questioning, may be set by Legislative Decree.
auxiliary_right_scope(art28d_3, [art28d]).

auxiliary_right(art28d_3, PersonId, record, decision) :-
    exception(has_right(art28d, PersonId, right_to_access_lawyer, questioning), art28d_2).

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
% 3. The decision as per the first paragraph, under letters b, c and d, may only be taken by the assistant public prosecutor with the 
% permission of the public prosecutor

exception(has_right(art28d, PersonId, right_to_access_lawyer, questioning), art28e_2) :-
    person_danger(PersonId, life);
    person_danger(PersonId, liberty);
    person_danger(PersonId, physical_integrity).

exception(has_right(art28d, PersonId, right_to_access_lawyer, questioning), art28e_2) :-
    proceeding_matter(PersonId, prevent_damage_investigation).


exception(has_right(art28d, PersonId, right_to_access_lawyer, questioning), art28e_3) :-
    authority_decision(PersonId, deny_lawyer).

%% auxiliary_right(_art28e_4, PersonId, _record, _decision)
%
% Article 28e.4
%
% 4. The decision and the grounds on which it was made, shall be noted in the official report of the interview.
auxiliary_right_scope(art28e_4, [art28]).

auxiliary_right(art28e_4, PersonId, record, decision) :-
    exception(has_right(art28d, PersonId, right_to_access_lawyer, questioning), art28e_2);
    exception(has_right(art28d, PersonId, right_to_access_lawyer, questioning), art28e_3).

%% has_right(_art41, PersonId, _right_to_communicate, _letters)
%
% Article 41 code of criminal procedure
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

%% auxiliary_right(_art41_3, PersonId, _right_to_information, _supervision)
%
% Article 41.3
%
% The governor shall have the authority to exercise supervision over the letters and postal items sent by or intended for 
% juveniles with a view to the interests set out in the fourth paragraph. This supervision may comprise the copying of letters or 
% other postal items. The juveniles shall be notified beforehand of the way in which supervision will be exercised.
auxiliary_right(art41_3, PersonId, right_to_information, supervision) :-
    authority_decision(PersonId, postal_supervision). 

%% exception(_has_right(_art41, PersonId, _right_to_information, _supervision), _art41_4)
%
% Article 41.4
%
% The governor may refuse to distribute certain letters or other postal items as well as enclosed objects if this is necessary 
% with a view to the following interests:
% a. the maintenance of order or safety in the institution;
% b. the protection of public order or national security;
% c. the prevention or investigation of criminal offences;
% d. the protection of victims of, or those involved otherwise in criminal offences;
% e. the execution of the perspective plan.
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

%Article 42 code of criminal procedure
%1. Article 41, paragraphs 3 and 4, shall not apply to letters addressed by the juvenile to, or sent by:
%a. members of the Royal Family;
%b. the First or Second Chamber of the States General, members thereof, the Dutch members of the European Parliament or a 
%commission of one of these parliaments;
%c. Our Minister;
%d. judicial authorities;
%e. the National Ombudsman;
%f. public health inspectors;
%g. the Central Council for the Execution of Criminal Law, or members thereof;
%h. the Supervisory Committee or a Complaints Committee, or members thereof;
%i. his legal aid provider;
%j. his probation officer or officers of the certified institution;
%k. his parents or guardian, step parents or foster parents, unless compelling interests of the juvenile dictate otherwise;
%l. other persons or bodies designated by Our Minister or the governor.
%2. For the purposes of paragraph 1(d), judicial authorities shall also mean organs that have the authority under the law or a 
%treaty valid in the Netherlands to be notified of complaints or to review matters initiated by a complaint.
%3. Our Minister may establish further rules concerning the sending of letters to or by the persons and bodies referred to in paragraph 1.

%Article 43(7) code of criminal procedure
%The persons and bodies referred to in Article 42, paragraph 1(f), (g) and (h), shall have access to the juvenile at all times. 
%The other persons and bodies referred to in that paragraph shall have access to the juvenile at the times and places laid down 
%in the prison rules. If due to urgent commitments or impediments the persons set out in Article 42(1)(k) are not able to visit 
%the juvenile at the times and places laid down in the prison rules, the governor shall give them the opportunity to do so outside 
%of these hours, on weekdays or the weekend. During this visit they can freely converse with the juvenile, except when the governor 
%is of the opinion, following consultation with the visitor in question, that the juvenile poses a serious risk to the visitor's safety. 
%In that case, the governor shall disclose before the visit which supervisory measures will be taken, so that the conversation can 
%take place as undisturbed as possible. The supervisory measures may not result in confidential statements made in the conversation 
%between the juvenile and his legal aid provider becoming known to third parties.

%% has_right(_art44_4, PersonId, _right_to_communicate, _cellphone)
%
% Article 44(4) code of criminal procedure
%
% The juvenile shall be allowed to have phone contact with the persons and bodies referred to in Article 42, paragraph 1, 
% if the necessity and opportunity exist for this. No other supervision shall be exercised over these conversations than that 
% necessary to establish the identity of the persons or bodies with which the juvenile conducts or desires to conduct a phone 
% conversation.
has_right(art44_4, PersonId, right_to_communicate, cellphone):-
    person_status(PersonId, child),
    art37Applies(PersonId).

%% has_right(_art45, PersonId, _right_to_access_lawyer, _trial)
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

has_right(art45, PersonId, right_to_access_lawyer, private_communication):-
    (   person_status(PersonId, suspect)
    ;   person_status(PersonId, accused)
    ),
    person_status(PersonId, deprived_of_liberty).

%% has_right(_art57_2, PersonId, _right_to_access_lawyer, _questioning)
%
% Article 57(2) code of criminal procedure
%
% The suspect shall have the right to have a defence counsel present during questioning. The defence counsel shall be given the 
% opportunity to make such comments as he sees fit during questioning.
has_right(art57_2, PersonId, right_to_access_lawyer, questioning):-
    person_status(PersonId, suspect),
    proceeding_matter(PersonId, questioning).

%Article 59a(2) code of criminal procedure
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

% is this the same as summoned at court?

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
% The suspect shall have the right to have a defence counsel present when he is arraigned before the investigating judge. 
% The defence counsel shall be given the opportunity to make such comments as he deems fit during the arraignment.
has_right(art86_2, PersonId, right_to_access_lawyer, investigating_judge):-
    person_status(PersonId, suspect),
    proceeding_matter(PersonId, arraignment).

%Except for the case of Article 66a(1), the District Court may, ex officio or on application of the public prosecutor, after the 
%start of the court hearing, order the arrest of the suspect. Where advisable, the District Court shall hear him beforehand; 
%it is authorised for that purpose to order that he be summoned to appear, where necessary with an attached order that he be 
%forcibly brought to court.
%The District Court may also issue a warrant of arrest, if this is necessary in order to obtain the extradition of the suspect.

%% has_right(_art98, PersonId, _right_to_access_lawyer, _private_communication)
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
has_right(art98, PersonId, right_to_access_lawyer, private_communication):-
    person_status(PersonId, suspect);
    person_status(PersonId, accused).

auxiliary_right(art98, PersonId, remedy, decision).

%Article 124 code of criminal procedure
%During the performance of official acts the presiding judge of the court, or the judge or civil servant, who is in charge of the 
%execution of these acts, shall ensure that order is maintained.
%He shall take the necessary measures so that these official acts can be performed without interference.
%If, on such occasion, any person disturbs the peace or makes a nuisance of himself in any way, the presiding judge or the judge 
%or civil servant in question may, after having given this person a warning if necessary, order him to leave and, if he refuses, 
%have him forcibly removed and detained until the official acts have been completed.
%An official record of such matters shall be prepared and added to the case documents.
%Police officers, appointed for the performance of police duties, or other civil servants or officials, insofar as these civil 
%servants or officials have been designated by Our Minister of Security and Justice, shall be charged with the services of the 
%court. These civil servants or officials shall follow the instructions of the presiding judge of the court, or the judge or 
%the civil servant referred to in the first paragraph.

%Article 126aa(2) code of criminal procedure
%Insofar as the official records or other objects contain statements made by or to a person who could assert privilege under 
%Articles 218 and 218a if he were to be asked about the content of these statements in the capacity of a witness, these official 
%records and other objects shall be destroyed. Rules pertaining thereto shall be set by Legislative Decree. Insofar as the 
%official records or other objects contain statements other than the statements referred to in the first sentence made by or 
%to a person referred to in that sentence, they shall only be added to the case documents with the prior authorisation of the 
%investigating judge.

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

%% has_right(_art151_3, PersonId, _right_to_attend_inspection, _)
%
% Article 151(3) code of criminal procedure
%
% The public prosecutor or the assistant public prosecutor shall, insofar as the interest of the investigation permits, let the 
% suspect and his defence counsel attend the entire or part of the inspection; they may request to be permitted to give 
% instructions or provide information or to have certain comments included in the official record.
has_right(art151_3, PersonId, right_to_attend_inspection, null):-
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

%Article 272(1) code of criminal procedure
%The presiding judge shall be in charge of the court hearing and shall give the necessary orders for that purpose.

%Article 286 code of criminal procedure
%1. The presiding judge shall question the suspect.
%2. If there is more than one suspect, then the presiding judge shall determine the order in which the suspects will be questioned.
%3. The presiding judge may determine that the suspect will be questioned without one or more co-suspects or witnesses being present.
%4. During the further course of the hearing questions may be posed to the defendant by the presiding judge, the judges, the public 
%prosecutor, the defence counsel and the co-suspect.
%5. Article 293 shall apply mutatis mutandis.
%6. When the suspect is being questioned, the court shall determine, as much as possible, whether his statement is based on his own 
%knowledge.

%Article 318(1) code of criminal procedure
%If the District Court considers it necessary to conduct an inspection or question witnesses or defendants at a location other 
%than in the courtroom, it may for that purpose, while adjourning the case, order that the court session be temporarily relocated.

%Article 331(1) code of criminal procedure
%Any power conferred on the defendant under this Part shall also vest in the defence counsel who is legally representing the 
%defendant present at the court session or who has been permitted to conduct the defence of the defendant who is not present 
%under Article 279(1).

%% has_right(_art404_1, PersonId, _right_to_appeal, _judgement)
%
% Article 404 code of criminal procedure
%
% 1. Appeal may be filed against judgments concerning serious offences, rendered by the District Court as final judgment or in the course 
% of the hearing, by the public prosecutor with the court which rendered the judgment, and by the suspect who was not acquitted of the 
% entire indictment.
has_right(art404_1, PersonId, right_to_appeal, judgement):-
    person_document(PersonId, judgement),
    proceeding_matter(PersonId, serious_offence),
    \+ person_status(PersonId, acquitted).

%% has_right(_art404_1, PersonId, _right_to_appeal, _judgement)
%
% Article 404 code of criminal procedure
%
% 2. Appeal may be filed against judgments concerning minor offences, rendered by the District Court as final judgment or in the course 
% of the hearing, by the public prosecutor with the court which rendered the judgment, and by the suspect who was not acquitted of the 
% entire indictment, unless in this regard in the final judgment:
% a. under application of Article 9a of the Criminal Code, a punishment or measure was not imposed, or
% b. no other punishment or measure was imposed than a fine up to a maximum – or, where two or more fines were imposed in the judgment, 
% fines up to a joint maximum – of € 50.
has_right(art404_2, PersonId, right_to_appeal, judgement):-
    person_document(PersonId, judgement),
    proceeding_matter(PersonId, serious_offence),
    \+ person_status(PersonId, acquitted),
    \+ exception(has_right(art404_2, PersonId, right_to_appeal, judgement), _).

exception(has_right(art404_2, PersonId, right_to_appeal, judgement), art404_2_a) :-
    person_punishment(PersonId, not_imposed).

exception(has_right(art404_2, PersonId, right_to_appeal, judgement), art404_2_b) :-
    person_punishment(PersonId, fine_max_50_euros).

%% has_right(_art404_1, PersonId, _right_to_appeal, _judgement)
%
% Article 404 code of criminal procedure
%
% 3.In derogation of paragraph 2, the suspect may file an appeal against a judgment rendered in absentia as referred to in 
% paragraph (2)(a) and (b), if the summons or notice to appear at the court session of the court of first instance or the notice to 
% appear at the court session at a later date was not given to or served on the defendant in person and no other circumstance has 
% occurred from which it follows that the date of the court session or of the court session at a later date was known to the defendant 
% beforehand. The preceding sentence shall not apply in the event that the summons or appearance notice was lawfully served on the 
% defendant in accordance with Article 588a within six weeks after the defendant filed an objection to the judgment in absentia under 
% the terms of Article 257e.
%
% NOTE comma 2 states that:
% 2. Appeal may be filed against judgments concerning minor offences, rendered by the District Court as final judgment or in the course 
% of the hearing, by the public prosecutor with the court which rendered the judgment, and by the suspect who was not acquitted of the 
% entire indictment, unless in this regard in the final judgment:
% a. under application of Article 9a of the Criminal Code, a punishment or measure was not imposed, or
% b. no other punishment or measure was imposed than a fine up to a maximum – or, where two or more fines were imposed in the judgment, 
% fines up to a joint maximum – of € 50.
has_right(art404_3, PersonId, right_to_appeal, judgement):-
    proceeding_matter(PersonId, trial_in_absentia),
    proceeding_event(PersonId, summoned_court).

%4.The judgments, referred to in paragraphs (2)(a) and (b), which are not open to appeal, shall not be open to appeal in cassation either, 
%unless in the case of a violation of a bye-law of a province, a municipality, a water control authority, or a public body established 
%under application of the Joint Regulations Act [Wet Gemeenschappelijke Regelingen].
%5. If at the court of first instance criminal offences have been tried jointly by the District Court, then the suspect may only file an 
%appeal in regard of those joint cases in which he was not acquitted of the entire indictment. 

%% has_right(_art427_1, PersonId, _right_to_appeal, _judgement)
%
% Article 427 code of criminal procedure
%
% 1. Appeal in cassation may be filed against judgments concerning serious offences pronounced by the Courts of Appeal by the Public 
% Prosecution Service attached to the court which rendered the judgment, and by the suspect.
% 2. Appeal may be filed against judgments concerning minor offences, pronounced by the Courts of Appeal by the Public Prosecution Service 
% attached to the court which rendered the judgment, and by the suspect, unless in this regard in the final judgment:
% a. under application of Article 9a of the Criminal Code, a punishment or measure was not imposed, or
% b. no other punishment or measure was imposed than a fine up to a maximum – or, where two or more fines were imposed in the judgment, 
% fines up to a joint maximum – of EUR 250.
has_right(art427_1, PersonId, right_to_appeal, judgement):-
    person_document(PersonId, judgement),
    proceeding_matter(PersonId, serious_offence),
    proceeding_type(PersonId, appeal).

has_right(art427_2, PersonId, right_to_appeal, judgement):-
    person_document(PersonId, judgement),
    proceeding_matter(PersonId, minor_offence),
    \+ exception(has_right(art427_2, PersonId, right_to_appeal, judgement), _).

exception(has_right(art427_2, PersonId, right_to_appeal, judgement), art427_2_a) :-
    person_punishment(PersonId, not_imposed).

exception(has_right(art427_2, PersonId, right_to_appeal, judgement), art427_2_b) :-
    person_punishment(PersonId, fine_max_250_euros).

%3. Appeal in cassation may nevertheless be filed against the judgments, referred to in paragraph (2)(a) and (b), in the case of a 
%violation of a bye-law of a province, a municipality, a water control authority, or a public body established under application of the 
%Joint Regulations Act.

%4. Appeal shall suspend the legal effects of appeal in cassation; if a judgment is rendered on one or more of the questions, referred 
%to in Articles 351 and 352, by the lower court, the appeal in cassation filed shall be cancelled.

%% has_right(_art488aa_a, PersonId, _right_to_information, _)
%
% Article 488aa code of criminal procedure
%
% Without prejudice to the provisions of Articles 27c and 27ca, the suspect shall immediately upon arrest be informed: 
% a) that his parents or guardian will be notified of his deprivation of liberty, if ordered;
% b) of his right to be accompanied by his parents or guardian, or by a confidant, during stages of the proceedings other 
% than court hearings, pursuant to Article 488ab;
% c) of the possibility to make audiovisual recordings of hearings, pursuant to Article 488ac;
% d) of the right to a medical examination, pursuant to Article 489a;
% e) of the right to an advice on his personality and living conditions, pursuant to Article 494a.
% Upon being summoned for questioning, pursuant to Article 491a, the suspect shall be informed of his right to be accompanied 
% by his parents or guardian, or by a confidant.
% Upon being summoned for questioning, pursuant to Article 493(4), the suspect shall be informed of: 
% a) the right to have the duration of pre-trial detention determined at a length as short as appropriately possible and 
% the possibility of a stay of execution of the pre-trial detention order, pursuant to Article 493(1);
% b) the right to be accompanied by the parents or guardian, or by a confidant;
% c) the right to periodical assessments of pre-trial detention;
% d) the right to be held separately from adults while kept in pre-trial detention.
% Upon the indictment being served, the suspect shall be informed of: 
% a) the obligation to appear in person at trial, pursuant to Article 495a;
% b) the right to have his case dealt with behind closed doors, pursuant to Article 495b;
% c) the right to be accompanied during court hearings by his parents or guardian, or by a confidant, pursuant to Article 496.
has_right(art488aa_a, PersonId, right_to_information, inform_parents):-
    person_status(PersonId, arrested).

has_right(art488aa_a, PersonId, right_to_information, inform_guardian):-
    person_status(PersonId, arrested).

has_right(art488aa_b, PersonId, right_to_information, accompanied_by_parents):-
    person_status(PersonId, arrested),
    \+ proceeding_matter(PersonId, court_hearing).

has_right(art488aa_c, PersonId, right_to_information, audiovisual_recording):-
    person_status(PersonId, arrested).

has_right(art488aa_d, PersonId, right_to_information, medical_examination):-
    person_status(PersonId, arrested).

has_right(art488aa_e, PersonId, right_to_information, advice_on_personality_living_conditions):-
    person_status(PersonId, arrested).

has_right(art488aa_2, PersonId, right_to_information, accompanied_by_parents):-
    proceeding_matter(PersonId, questioning), 
    proceeding_event(PersonId, summoned_court).

has_right(art488aa_2_a, PersonId, right_to_information, limitation_to_deprivation_of_liberty):-
    proceeding_matter(PersonId, questioning), 
    proceeding_event(PersonId, summoned_court).

has_right(art488aa_2_b, PersonId, right_to_information, accompanied_by_parents):-
    proceeding_matter(PersonId, questioning), 
    proceeding_event(PersonId, summoned_court).

has_right(art488aa_2_c, PersonId, right_to_information, assessment_pretrial_detention):-
    proceeding_matter(PersonId, questioning), 
    proceeding_event(PersonId, summoned_court).

has_right(art488aa_2_d, PersonId, right_to_information, held_separately_from_adults):-
    proceeding_matter(PersonId, questioning),
    proceeding_event(PersonId, summoned_court),
    proceeding_matter(PersonId, pre_trial_detention).

has_right(art488aa_3_a, PersonId, right_to_information, appear_at_trial):-
    person_document(PersonId, indictment).

has_right(art488aa_3_b, PersonId, right_to_information, private_trial):-
    person_document(PersonId, indictment).

has_right(art488aa_3_c, PersonId, right_to_information, accompanied_by_parents):-
    person_document(PersonId, indictment),
    proceeding_matter(PersonId, court_hearing).

%% auxiliary_right(_art488aa_4, PersonId, _language, Language)
%
% Article 488a.4 code of criminal procedure
%
% The notification of rights shall be given in simple and accessible language. If the suspect does not, or not sufficiently, 
% speak or understand Dutch, the information shall be given in a language he understands.
auxiliary_right(art488aa_4, PersonId, language, Language) :-
    person_language(PersonId, Language),
    Language \= dutch.

%% has_right(_art488ab, PersonId, _right_to_accompanied_by_parents, _questioning)
%
% Article 488ab code of criminal procedure
%
% During questioning, the suspect has the right to be accompanied by the parents or guardian, or by a confidant.
% Access of the person to questioning may be refused if the assistant public prosecutor is of the opinion that:
% it is not in the child's interest to be accompanied by the parent or guardian, or a confidant; or
% the presence of that person will prejudice the criminal proceedings.
% The assistant public prosecutor may take the decision referred to in paragraph 2 only with the permission of the public prosecutor.
has_right(art488ab, PersonId, right_to_accompanied_by_parents, questioning):-
    person_status(PersonId, suspect),
    proceeding_matter(PersonId, questioning),
    \+ exception(has_right(art488ab, PersonId, right_to_information, accompanied_by_parents), _).

exception(has_right(art488ab, PersonId, right_to_accompanied_by_parents, questioning), art488ab) :-
    person_status(PersonId2, parent),
    (   contrary_to_child_interest(PersonId2)
    ;   jeopardises_proceedings(PersonId2)
    ).

%% has_right(_art488ac, PersonId, _right_to_audiovisual_recording, _interview)
%
% Article 488ac code of criminal procedure
%
% The audiovisual recording of an interview carried out by a law enforcement officer shall be arranged if the seriousness 
% of the offence or the personality of the suspect so requires.
has_right(art488ac, PersonId, right_to_audiovisual_recording, interview):-
    proceeding_event(PersonId, seriousness_offence);
    proceeding_event(PersonId, personality_subject).

%% has_right(_art488b, PersonId, _right_to_information, _parent)
%
% Article 488b code of criminal procedure
%
% In derogation of Article 27e(1), the assistant public prosecutor to have ordered the suspect's detention for investigation 
% at the arraignment shall notify the parents or guardian of the deprivation of liberty and the reasons for it as soon as possible. 
% The parents or guardian shall furthermore receive a notification of the rights provided for in Article 488aa.
has_right(art488b, PersonId, right_to_information, parent):-
    person_status(PersonId, suspect),
    person_status(PersonId, deprived_of_liberty),
    \+ exception(has_right(art488b, PersonId, right_to_information, parent), _).

% TODO - an arraignment implies that a formal charge has been done, should it not be accused?, what should the predicate be? trial has started?

%% exception(_has_right(_art488b, PersonId, _right_to_information, _parent), _art488b_a)
%
% Article 488b code of criminal procedure
%
% The notification of rights provided for in the first paragraph, shall not take place when: 
% (a) this would contrary to the interests of the suspect;
% (b) the notification is not possible because despite reasonable efforts the parents or guardian cannot be reached or identified.
exception(has_right(art488b, PersonId, right_to_information, parent), art488b_a) :-
    proceeding_event(PersonId, contrary_to_interest).

exception(has_right(art488b, PersonId, right_to_information, parent), art488b_b) :-
    proceeding_event(PersonId, cannot_parent_notified).

%In the case referred to in paragraph 2, the information shall be provided to a confidant. If no confidant has been nominated, 
%the information shall be provided to the Child Care and Protection Board.
has_right(art488b, PersonId, right_to_information, confidant):-
    person_status(PersonId, suspect),
    (   proceeding_event(PersonId, contrary_to_interest)
    ;   proceeding_event(PersonId, cannot_parent_notified)
    ).
% should we have articles 1 applies IF NOT articles 2? or keep it like this?

%Where the circumstances, referred to in paragraph 2, cease to exist, the information shall be provided to the parents or guardian.
%add an exception to previous article? add new articles?.

%%Article 488(2) code of criminal procedure
%The provisions of this Chapter shall apply to persons who, at the time of the commission of the offence, had not yet 
%reached the age of eighteen years, insofar as the provisions of this Chapter do not derogate therefrom.
dutchCodeOfCriminalProcedureApplies(PersonId) :-
    person_age(PersonId, X),
    X < 18.

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
    person_status(PersonId, detained),
    dutchCodeOfCriminalProcedureApplies(PersonId).

%% has_right(_art489a, PersonId, _right_to_medical_examination, _)
%
% Article 489a code of criminal procedure
%
% The assistant public prosecutor to have ordered the suspect’s detention for investigation may either ex officio, or upon request of 
% the suspect, his lawyer, his parent or guardian, or his confidant, order a medical examination of the suspect, with a view to the 
% determination of his capacity to be subjected to questioning or an investigative act. A medical examination assesses the overall 
% mental and physical condition of the suspect. The examination shall be as non-invasive as possible.
% A medical examination shall be carried out by a physician or under the responsibility of a physician.
% Where the conclusion of a medical examination requires so, the questioning of the suspect or the subjecting of him to an investigative 
% act for the purpose of evidence-gathering, may be postponed.
% An order, as referred to in paragraph 1, or a decision of the assistant public prosecutor, as referred to in paragraph 3, shall be 
% recorded in writing. If despite an order for medical examination, no examination was carried out, the underlying reasons shall be 
% recorded in writing. Where a medical examination has been carried out, the conclusion of that examination shall be recorded in writing.
has_right(art489a, PersonId, right_to_medical_examination, ex_officio) :-
    person_status(PersonId, suspect),
    person_status(PersonId, detained),
    dutchCodeOfCriminalProcedureApplies(PersonId).

has_right(art489a, PersonId, right_to_medical_examination, request) :-
    person_status(PersonId, suspect),
    person_status(PersonId, detained),
    dutchCodeOfCriminalProcedureApplies(PersonId),
    person_request_submitted(PersonId, medical_exam).

auxiliary_right(art489a_2, PersonId, record, medical_examination).

%Article 490(3) - Partially implemented
%If the suspect has been deprived of his liberty by law and has not been placed in a correctional institution for young offenders, 
%Article 45 shall apply mutatis mutandis in regard of his parents or his guardian.

%% has_right(_art491, PersonId, _right_to_access_lawyer, _trial)
%
% Article 491 code of criminal procedure
%
% Without prejudice to Article 489(1), a defence counsel shall be assigned to the suspect without counsel by the governing body 
% of the Legal Aid Board, after it has been informed that prosecution other than by punishment order has been instituted against 
% the suspect in relation to an offence for which the district court, not being a sub-district court, is competent in first instance. 
% Article 40(2) shall apply mutatis mutandis.
% The public prosecutor shall summon the suspect to be questioned if the punishment order he intends to impose involves either 
% community service, as referred to in Article 77f(2) of the Criminal Code, of more than 22 hours, or fines or financial compensations 
% that separately or together amount to more than 200 euros. A defence counsel shall be assigned to the suspect without counsel by 
% the governing body of the Legal Aid Board, after it has been informed about this intention by the Public Prosecution Service. 
% When the suspect is summoned, he shall be informed of his right to be assisted by a lawyer.
% A defence counsel shall be assigned ex officio by the governing body of the Legal Aid Board if the convicted offender, in view of 
% the the nature of the questioning to be conducted pursuant to Articles 77u or 77ee(1) in conjunction with Article 14i(3) of the 
% Dutch Criminal Code, requires his assistance.
has_right(art491, PersonId, right_to_access_lawyer, trial):-
    person_status(PersonId, suspect),
    dutchCodeOfCriminalProcedureApplies(PersonId).

has_right(art491_2_a, PersonId, right_to_access_lawyer, trial) :-
    person_status(PersonId, suspect),
    proceeding_matter(PersonId, questioning), 
    (   person_punishment(PersonId, community_service_less_22)
    ;   person_punishment(PersonId, fines)
    ;   person_punishment(PersonId, compensation_more_euros_200)
    ),
    dutchCodeOfCriminalProcedureApplies(PersonId).

has_right(art491_2_b, PersonId, right_to_information, access_lawyer) :-
    has_right(art491_2_a, PersonId, right_to_access_lawyer, trial),
    proceeding_matter(PersonId, summoned_court),
    dutchCodeOfCriminalProcedureApplies(PersonId).

has_right(art491_3, PersonId, right_to_access_lawyer, questioning):-
    person_status(PersonId, convicted),
    proceeding_matter(PersonId, questioning),
    dutchCodeOfCriminalProcedureApplies(PersonId).

% TODO - Identify district court?

%The assignment pursuant to paragraph 3 shall be arranged by order of the presiding judge of the District Court, or, when appeal has 
%been filed against the final judgment rendered at the court of first instance, by the presiding judge of the Court of Appeal.

%% has_right(_art491_a, PersonId, _right_to_accompanied_by_parents, _questioning) 
%
% Article 491a code of criminal procedure
% 
% When questioned pursuant to Article 491(2), the suspect shall have the right to be accompanied by the parents or the guardian, or 
% by a confidant.
% The public prosecutor shall summon the parents or guardian to be present during questioning. The suspect shall be informed of his 
% right to be accompanied by a confidant during questioning.
% Access of that person to questioning may be refused if the public prosecutor is of the opinion that:
% it is not in the child's interest to be accompanied by this person; or
% the presence of that person will prejudice the criminal investigation or the criminal proceedings.
has_right(art491_a, PersonId, right_to_accompanied_by_parents, questioning) :-
    person_status(PersonId, suspect),
    proceeding_matter(PersonId, questioning),
    dutchCodeOfCriminalProcedureApplies(PersonId),
    \+ exception(has_right(art491_a, PersonId, right_to_accompanied_by_parents, questioning), _).

exception(has_right(art491_a, PersonId, right_to_accompanied_by_parents, questioning), art491_a) :-
    person_status(PersonId, suspect),
    (   proceeding_event(PersonId, contrary_to_interest)
    ;   proceeding_event(PersonId, cannot_parent_notified)
    ).

%Article 493 code of criminal procedure
%Pre-trial detention shall be determined at the shortest appropriate period of time. If the court orders the pre-trial detention 
%of the suspect, it shall consider whether the enforcement of this order may be suspended, either immediately, or after a specific 
%period of time. In doing so, the court may charge a foundation, as referred to in Article 1 of the Youth Care Act, or if the 
%suspect has reached the age of sixteen years, a probation service, as referred to in Article 14d(2) of the Criminal Code, to carry 
%out the supervision of conditions imposed on him, and, to that end, to provide support to the suspect.

% TODO - right to shortest period of time in detention?

%The order for pre-trial detention and its suspension shall include such provisions as are considered necessary for its proper enforcement.

%Any place suitable for such purpose may be designated as a facility for police custody or pre-trial detention. The pre-trial 
%detention order may stipulate that the suspect stay during the night in an institution, as referred to in the Correctional 
%Institutions for Young Offenders Framework Act, or in another place, as referred to in the first sentence, and during the day 
%will be given the opportunity to leave the institution or that location.

% TODO - right to alternate measure?

%The duration of a remand detention order or a warrant of arrest may not exceed a period thirty days if the suspect has not been 
%heard by the District Court.

%In cases where leave may be granted under the provisions laid down by or pursuant to the Correctional Institutions for Young 
%Offenders Framework Act, the provisions of paragraphs 1 and 2 pertaining to suspension shall not apply.

%Suspension of the pre-trial detention shall always be subject to the general condition referred to in Article 80. The court may, 
%after having obtained the advice of the Child Care and Protection Board, also attach special conditions to the suspension. 
%The court shall attach special conditions to the suspension insofar as the suspect agrees to said conditions. The special conditions 
%which may be attached to the suspension and the requirements which the agreement of the suspect must meet shall be set by 
%Legislative Decree.

%The judge takes account of the age and the person of the offender, and of the circumstances under which the alleged offence has 
%been committed.

%% has_right(_art491_a, PersonId, _right_to_assess_personality, _child_care_protection_board)
%
%Article 494 code of criminal procedure
%
% 1. The public prosecutor shall obtain information on the personality and circumstances of the suspect from the Child Care and 
% Protection Board, unless he immediately and unconditionally declines to prosecute. If he prosecutes the case before the 
% single-judge division of the Sub-District Court Sector or through a punishment order, he can demand such information from 
% the Child Care and Protection Board.
% 2. If the suspect is in pre-trial detention or has been admitted to an institution pursuant to Article 196, the public prosecutor 
% shall promptly notify the Child Care and Protection Board thereof.
% 3. The Child Care and Protection Board may also advise the public prosecutor ex proprio motu.
% 4. The investigative judge may also obtain the information, referred to in paragraph 1, from the Child Care and Protection Board.
has_right(art491_a, PersonId, right_to_assess_personality, child_care_protection_board) :-
    person_status(PersonId, suspect),
    dutchCodeOfCriminalProcedureApplies(PersonId).

%Article 494b code of criminal procedure
%When an advice about the suspect, as referred to in Article 494a, has been submitted, the punishment order shall mention how it 
%was taken account of in the determination of a sanction or in the choice for a measure pertaining to the conduct.
%When an advice about the suspect, as referred to in Article 494a, has been submitted, the jugdment shall mention how it was taken 
%account of.

%Article 495a code of criminal procedure
%1. The suspect shall be obliged to appear in person. He shall be notified by summons that if he does not comply with this obligation, 
%the court may order that he be brought forcibly.

%2. If the person suspected of having committed a serious offence fails to appear at the court session, the court shall, unless nullity 
%and voidness of the summons, a bar to the prosecution or lack of jurisdiction of the court is immediately apparent, adjourn the hearing 
%to a specific date and shall also order that the suspect be brought forcibly to court. However, the court may decline to issue an order 
%to forcibly bring the suspect to court if the suspect has no known place of residence or abode or on the grounds of special reasons.
%3. The suspect who fails to comply with the order to appear before the court shall be tried in absentia, unless the court orders that 
%he be brought forcibly to court at a later date. The hearing shall then be continued.
%4. Paragraphs 1, 2 and 3 shall not apply if at the time of the court session the suspect has since reached the age of eighteen years.

%% has_right(_art495b, PersonId, _right_to_privacy, _trial)
%
% Article 495b code of criminal procedure
%
% The case shall be tried behind closed doors. The presiding judge of the District Court may grant persons special permission to 
% attend the court session behind closed doors. The victim or the surviving relatives of the victim shall be granted permission to 
% attend, unless the presiding judge decides otherwise for special reasons.
% The presiding judge of the District Court shall order that the case be heard in public if, in his opinion, the interest in holding 
% a hearing in public must outweigh the interest in protecting the private life of the suspect, his co-suspect, his parents or his guardian.

has_right(art495b, PersonId, right_to_privacy, trial):-
    person_status(PersonId, child),
    \+ exception(has_right(art495b, PersonId, right_to_privacy, trial), _).

exception(has_right(art495b, PersonId, right_to_privacy, trial), art495b):-
    authority_decision(PersonId, public_trial).

%% has_right(_art496_1, PersonId, _right_to_accompanied, _)
%
% Article 496(1) code of criminal procedure
%
% The parents or the guardian shall be obliged to appear at the court session. They shall be given notice to appear for that purpose. 
% They shall be informed in the notice that if they do not comply with this obligation, the court may order that they be brought forcibly.
% The suspect has the right to be accompanied by a confidant who is deemed appropriate by the judge, where the judge is of the opinion that:
% a) the presence of the parents or guardian would be contrary to the suspect's best interests;
% b) after reasonable efforts have been made, the parents or guardian could not be reached or their identity is unknown;
% c) the criminal proceedings would be jeopardised by the presence of the parents or guardian.
% If in a situation as referred to in paragraph 2, the suspect has not nominated a confidant, or if the confidant nominated by the 
% suspect has not been deemed appropriate by the judge, the suspect will be accompanied by a representative of the Child Care and 
% Protection Board.
has_right(art496_1, PersonId, right_to_accompanied, parents):-
    person_status(PersonId, child),
    proceeding_matter(PersonId, court_session).

has_right(art496_2_a, PersonId, right_to_accompanied, confidant):-
    person_status(PersonId, suspect),
    authority_decision(PersonId, confidant),
    proceeding_event(parent, contrary_to_interest).

has_right(art496_2_b, PersonId, right_to_accompanied, confidant):-
    person_status(PersonId, suspect),
    authority_decision(PersonId, confidant),
    proceeding_event(PersonId, cannot_parent_notified).

has_right(art496_2_c, PersonId, right_to_accompanied, confidant):-
    person_status(PersonId, suspect),
    authority_decision(PersonId, confidant),
    jeopardises_proceedings(parent).

has_right(art496_2_c, PersonId, right_to_accompanied, child_care_protection_board):-
    (   proceeding_event(parent, contrary_to_interest)
    ;   proceeding_event(PersonId, cannot_parent_notified)
    ;   jeopardises_proceedings(parent)
    ),
    \+ authority_decision(PersonId, confidant).

% TODO can probably avoid court session - or needs to restate that all trial phases are court sessions as well?
% TODO - is this an obligation?

%%%%%Surrender of Persons Act%%%%%

%% has_right(_art17_3, PersonId, _right_to_information, _)
%
% Article 17(3) surrender of persons act
%
% Upon arrest, the requested person shall be promptly informed in writing of:
% a) the right to receive a copy of the European arrest warrant, as referred to in Article 23(3);
% b) the right of access to a lawyer, as referred to in Article 43a, and the possibility to request the appointment of a lawyer in the 
% issuing Member State, as referred to in Article 21a;
% c) the right to interpretation, as referred to in Article 30, and the right to translation, as provided for under Article 23(3), 
% fourth and fifth sentences;
% d) the right to be heard, as referred to in Article 24;
% e) the rights referred to in Article 27c(3) under g and h of the Code of Criminal Procedure.
has_right(art17_3_a, PersonId, right_to_information, receive_copy_eaw):-
    person_status(PersonId, requested),
    person_status(PersonId, arrested).

has_right(art17_3_b, PersonId, right_to_information, access_lawyer):-
    person_status(PersonId, requested),
    person_status(PersonId, arrested).

has_right(art17_3_c, PersonId, right_to_information, interpretation):-
    person_status(PersonId, requested),
    person_status(PersonId, arrested).

has_right(art17_3_c, PersonId, right_to_information, translation):-
    person_status(PersonId, requested),
    person_status(PersonId, arrested).

has_right(art17_3_d, PersonId, right_to_information, be_heard):-
    person_status(PersonId, requested),
    person_status(PersonId, arrested).

has_right(art17_3_e, PersonId, right_to_information, rights):-
    person_status(PersonId, requested),
    person_status(PersonId, arrested).

%% auxiliary_right(_art17_3, PersonId, _language, _understandable)
%
% Article 17.3 surrender of persons act
%
% The requested person who does not have a sufficient command of Dutch shall be informed of his rights in a language he understands. 
% Articles 27e, 488ab, and 488b Code of Criminal Procedure shall apply accordingly.
auxiliary_right(art17_3, PersonId, language, understandable) :-
    \+ person_language(PersonId, dutch).

%% has_right(_art21_10, PersonId, _right_to_accompanied_by_parents, _questioning)
%
% Article 21(10) surrender of persons act
%
% If the requested person is a minor and the identity and residence of his parents or guardian are known, he shall be able to be 
% accompanied by them or by a confidant during questioning pursuant to paragraph 4, provided that the parents or guardian, or the 
% confidant will be available on short notice.
has_right(art21_10, PersonId, right_to_accompanied_by_parents, questioning) :-
    person_status(PersonId, requested),
    proceeding_matter(PersonId, questioning).

%Article 22 surrender of persons act
%The court shall deliver the verdict containing the decision on surrender within sixty days of the requested person’s arrest as per 
%Article 21.
%If surrender also depends on the consent of the competent authority of another Member State or of a third state, the period as per 
%paragraph 1 shall start from the date of receipt of the requisite consent.
%Exceptionally, provided reasons are given to the issuing judicial authority, the court may extend the term of sixty days by a maximum 
%of thirty days.
%If the court has still given no verdict within the period as per paragraph 3, the court may again extend the term indefinitely, while 
%setting conditions for simultaneous suspension of the detention of the requested person, and notification of the issuing authority.

%% has_right(_art24_4, PersonId, _right_to_inform, _parent)
%
% Article 24(4) surrender of persons act
%
% If the requested person is a minor, the Child Care and Protection Board shall be informed of the time and place of the court hearing. 
% If the identity and residence of the parents or guardian are known, they shall also be informed of the time and place of the court 
% hearing.
has_right(art24_4, PersonId, right_to_inform, parent) :-
    person_status(PersonId, requested),
    proceeding_matter(PersonId, court_hearing).

%% has_right(_art25_1, PersonId, _right_to_hearing, _privacy)
%
% Article 25(1) surrender of persons act
%
% The requested person shall be heard in public unless a request has been made for the matter to be dealt with in chambers or the court 
% has ordered that it be thus dealt with, for good cause, which shall be recorded in the report of the session.
has_right(art25_1, PersonId, right_to_hearing, privacy):-
    person_status(PersonId, requested),
    proceeding_matter(PersonId, court_hearing),
    person_request_submitted(PersonId, private_hearing).

%% has_right(_art25_5, PersonId, _right_to_be_assisted, _parent)
%
% Article 25(5) surrender of persons act
%
% If the requested person is a minor, the parents, the guardian, or the representative of the Child Care and Protection Board who 
% appeared at the court hearing, shall be allowed to assist the minor.
has_right(art25_5, PersonId, right_to_be_assisted, parent):-
    person_status(PersonId, requested),
    proceeding_matter(PersonId, court_hearing).

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
%duty to appoint lawyer? to add also in other national laws and dir?

%Article 61 surrender of persons act
%Persons placed in custody or detention by virtue of this Act or whose arrest or imprisonment is ordered shall be treated as suspects 
%subject to appropriate order by virtue of the Code of Criminal Procedure.

%%%%%Decree on Format of and Order During Police Questioning%%%%%

%Article 2 Decree on Format of and Order During Police Questioning
%The officer conducting the questioning shall be in charge thereof and shall maintain the order during questioning and in the 
%questioning room.

%Article 3 Decree on Format of and Order During Police Questioning
%In the questioning room, counsel for the suspect or accused shall sit next to the suspect or accused as much as possible, 
%and the officer conducting the questioning shall sit opposite the suspect or accused and his counsel as much as possible.

%Article 4 - Partially implemented
%Counsel shall not answer questions on behalf of the suspect or accused, unless the officer conducting the questioning and the 
%suspect or accused consent to him doing so.

%Article 5 - Partially implemented
%Counsel for the suspect or accused shall address his comments and requests to the officer conducting the questioning.
%Without prejudice to the provisions of Article 28d(1), third sentence, of the Code of Criminal Procedure and Article 6 of this Decree, 
%counsel for the suspect or accused may only make comments or ask questions directly after the questioning has commenced and directly 
%before the questioning is concluded. The officer conducting the questioning shall give counsel for the suspect or accused the 
%opportunity to do so directly after the questioning has commenced and directly before the questioning is concluded.

%Article 6 Decree on Format of and Order During Police Questioning
%Counsel for the suspect or accused has the authority to alert the officer conducting the questioning to:
%a. the fact that the suspect or accused does not understand a question put to him;
%b. the fact that the officer conducting the questioning is not abiding by the provisions of Article 29(1) of the Code of Criminal 
%Procedure;
%c. the fact that the suspect or accused's physical or mental state is such that it constitutes an impediment to the responsible 
%continuation of the questioning.

%Article 7 - Partially implemented
%Counsel for the suspect accused shall, in providing legal assistance, not go beyond the powers assigned to him in this Decree. 
%He shall not use such powers unreasonably.
%Counsel for the suspect or accused shall not disturb the order during questioning.
%Counsel for the suspect or accused has the authority to bring into the questioning room means of communication or portable 
%equipment for word processing, unless the internal rules of the location for questioning preclude this on security grounds. 
%He shall not make a recording of the questioning. Counsel for the suspect or accused is permitted take notes during questioning.

%Article 8 - Partially implemented
%If counsel for the suspect or accused fails to comply with the provisions of Articles 4, 5(1) and 7 of this Decree and has 
%been warned, fruitlessly, by the officer conducting the questioning at least once, the assistant public prosecutor may order 
%counsel to remove himself from the questioning room and if he refuses to do so, have him removed. The assistant public 
%prosecutor shall ensure that the removal and the grounds for doing so are noted in the official report of the interview.
%Upon removal of counsel for the suspect or accused the questioning may only be continued if (a) counsel is admitted back into the 
%questioning room; (b) the suspect or accused gives a waiver as per Article 28a of the Code of Criminal Procedure; 
%(c) a replacement counsel is available.

%% has_right(_art9, PersonId, _right_to_information, _lawyer)
%
% Article 9 Decree on Format of and Order During Police Questioning
%
% The public prosecutor and counsel for the suspect or accused shall be given the opportunity to follow the execution of the 
% identity parade and shall, prior to the parade commencing, be given the opportunity to make comments regarding the selection 
% to be shown, without this being able to lead to the parade being suspended. The comments made shall be noted in the official 
% report or report provided for in Article 8(1).
has_right(art9, PersonId, right_to_information, lawyer) :-
    (   person_status(PersonId, suspect)
    ;   person_status(PersonId, accused)
    ),
    proceeding_matter(PersonId, identity_parade).

%%%%%%Regulation on police cells complext%%%%%

%Article 1(b) code of criminal procedure
%Cell: a lockable room suitable for the staying of one single person during day and night.

%%%%%%Young Offenders Institutions (Framework) Act%%%%%

%Article 8(1)(a) Young Offenders Institutions (Framework) Act
%Instutions are intended for:
%Persons who have been ordered into pre-trial detention insofar at the time of the offence they allegedly committed they did not 
%yet reach the age of 18, and persons who have been ordered into pre-trial detention insofar as the time of the offence they 
%allegedly committed they did not yet reach the age of 23 and the public prosecutor has the intention to demand that justice 
%will be administered in accordance with Article 77c of the Criminal Code.

%% has_right(_art2_2, PersonId, _right_to_education, _trial)
%
% Article 2(2) Young Offenders Institutions (Framework) Act
%
% Without prejudice to the nature of a custodial sentence or custodial measure, its execution shall be used for the education of 
% the juvenile and shall as much as possible be made to be conducive to his return to society. If a custodial measure entails 
% treatment, its execution shall be accommodated accordingly. In granting freedoms to juveniles, due consideration shall be given 
% to the security of society and the interests of victims and their relatives.
has_right(art2_2, PersonId, right_to_education, trial):-
    proceeding_matter(PersonId, custody_execution),
    person_status(PersonId, under_custody).

%% has_right(_art43, PersonId, _right_to_receive_visits, _trial)
%
% Article 43 Young Offenders Institutions (Framework) Act
%
% 1. The juvenile shall have a right to receive visitors for at least one hour per week at the times and places laid down in the 
% prison rules. Our Minister may establish further rules concerning visit requests. The prison rules shall contain rules concerning 
% visit requests.
has_right(art43, PersonId, right_to_receive_visits, trial):-
    person_status(PersonId, child),
    person_status(PersonId, imprisoned).

%2The governor may limit the number of persons simultaneously admitted to the juvenile if this is necessary in the interest of 
%maintaining order or safety in the institution.
%3. The governor may refuse the admission of a certain person or certain persons to the juvenile if this is necessary with a 
%view to an interest referred to in Article 41(4). The refusal on the basis of Article 41(4)(a), (b), (d) or (e) shall be valid 
%for a maximum period of twelve months.
%4. The governor may determine that supervision is exercised during the visit if this is necessary with a view to an interest 
%referred to in Article 41(4). This supervision may comprise listening in to or recording the conversation between the visitor and 
%the juvenile. The person involved shall be notified beforehand of the character of and reason for the supervision.
%5. Every visitor should identify himself properly upon entering the institution. The governor may determine that a visitors clothes 
%is examined for the presence of objects that may be a risk to order or safety in the institution. This examination may also concern 
%the objects he brings with him. The governor shall have the authority to hold on to such objects for the duration of the visit with 
%issue of a receipt or to hand them to a police-officer with a view to the prevention or investigation of criminal offences. 
%The governor may establish requirements to the intended visit of a person whose access to the institution was refused previously on 
%the basis of paragraph 3. These requirements may comprise that the visitor prior to his visit is physcially examined. This examination 
%may include the external inspection of openings and cavities of the visitor's body.
%6. The governor may terminate the visit within the time allotted to it and have the visitor removed from the institution if this 
%is necessary with a view to an interest referred to in Article 41(4).
%7. The persons and bodies referred to in Article 41(1) under (f), (g) and (h) shall have access to the juvenile at any time. The other 
%persons and bodies referred to in that paragraph shall have access to the prisoner at the times and places laid down in the prison rules. 
%If the persons referred to in Article 42(1) under (k) are unable to visit the juvenile during the week at the times and places laid down 
%in the prison rules, due to urgent duties or obstacles, the governor shall allow them to visit the juvenile at other times during the 
%week or in the weekend. During this visit they can freely converse with the prisoner, except when the governor is of the opinion, 
%following consultation with the visitor in question, that the juvenile poses a serious risk to the visitor's safety. In that case, 
%the governor shall reveal before the visit which supervisory measures will be taken, so that the conversation can take place as 
%undisturbed as possible. The supervisory measures may not result in confidential statements made in the conversation between the 
%juvenile and his legal aid provider becoming known to third parties.

%% has_right(_art46, PersonId, _right_to_religious_freedom, _trial)
%
% Article 46 Young Offenders Institutions (Framework) Act
%
% 1. The juveline shall have a right to freely profess and practice his religion or ideology individually or in association with others.
has_right(art46, PersonId, right_to_religious_freedom, trial):-
    person_status(PersonId, child).

%2. The governor shall provide that sufficient spiritual care, as much as possible in accordance with the juvenile's religion or 
%ideology, is available in the institution.
%3. The governor shall give the juvenile the opportunity at the times and places laid down in the prison rules to:
%a. have personal contact with the spiritual counsellor of the religion or ideology of his choice connected with the institution;
%b. have contact with persons other than the spiritual counsellors referred to under a pursuant to Article 43;
%c. attend the religious or ideological meetings of his choice held in the institution. Article 24 shall apply mutatis mutandis.
%4. Further rules shall be established by order in council concerning the availability of spiritual care. These rules shall 
%refer to the provision of spiritual care by or on behalf of the different religious or ideological movements, to the 
%organisation and the cost of spiritual care and to the appointment of spiritual counsellors in an institution.

%% has_right(_art47, PersonId, _right_to_medical_assistance, _trial)
%
% Article 47 Young Offenders Institutions (Framework) Act
%
% 1. The juvenile shall have a right to receive the care of a physician connected with the institution or his substitute.
has_right(art47, PersonId, right_to_medical_assistance, trial):-
    person_status(PersonId, child).

%2. The juvenile shall have a right to consult, at his own expense, a physician of his choice. The governor shall establish 
%the place and time of the consultation, in consultation with the chosen physician.
%3. The governor shall provide that the physician connected with the institution or his substitute:
%a. is regularly available for holding surgery hours;
%b. is available at other times if this is necessary in the interest of the juvenile's health;
%c. examines the juveniles that are eligible for this for their fitness to participate in work, sport or other activities.
%4.The governor shall provide that:
%a. the juvenile is provided with the drugs and diets prescribed by the physician connected with the institution or his substitute;
%b. the juvenile is given the treatment on the direction of the physician connected with the institution or his substitute;
%c. the juvenile is transferred to a hospital or other establishment if the treatment referred to under b takes place there.
%5. Rules shall be established by order in council concerning complaints about decisions taken with respect to juveniles by the 
%physician connected with the institution or his substitute.

%% has_right(_art48, PersonId, _right_to_social_care_and_assistance, _trial)
%
% Article 48 Young Offenders Institutions (Framework) Act
%
% 1. The juvenile shall be entitled to social care and assistance.
has_right(art48, PersonId, right_to_social_care_and_assistance, trial):- 
    person_status(PersonId, child).

%2. The governor shall ensure that social workers from certified institutons, probation officers and other behaviour 
%experts qualified for this can provide the care and assistance described in paragraph 1 in the institution.
%3. The governor shall ensure that the juvenile is transferred to the place assigned for that if the care and assistance described 
%in paragraph 1 require this and such a transfer is compatible with the undisturbed carrying out of the deprivation of liberty.

%% has_right(_art52, PersonId, _right_to_education_and_pedagogical_development, _trial)
%
% Article 52 Young Offenders Institutions (Framework) Act
%
% 1.The juvenile is obliged to follow education and to participate in other activities in the context of his pedagogical development.
has_right(art52, PersonId, right_to_education_and_pedagogical_development, trial):- 
    person_status(PersonId, child).

%2.The development plan drawn up for the juvenile shall mention the education he follows or the activities in which he 
%participates in the context of his pedagogical development. In choosing them, the degree of security of the institution or the 
%institution's department shall be considered; reasonable wishes of the juvenile, his parents or guardian, or his stepparents or 
%foster parents shall be taken into account as much as possible.
%3.The governor shall provide that education and other activities in the context of pedagogical development are available, as well as 
%the officers eligible for this.
%4.Our Minister shall establish rules concerning the conditions under which compensation can be given for the possible costs incurred 
%by the juvenile in following educational courses and participating in other activities in the context of his pedagogical development 
%if these are not provided by the governor of the institution. These conditions may concern the nature, duration and costs of these 
%activities as well as to the juvenile's preliminary education and progress.
%5.Further rules shall be established by Legislative Decree concerning the requirements with which education in the institution as 
%well other activities in the context of pedagogical development shall comply.