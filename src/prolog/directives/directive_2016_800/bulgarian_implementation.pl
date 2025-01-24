:- module(directive_2016_800_bg, [has_right/5, auxiliary_right/5, auxiliary_right_checked/5, right_property/5, right_property_checked/5, explain/2]).

:- include('./../../utils.pl').

has_right(Right, bg, Article, PersonId, Matter) :-
    has_right(Article, PersonId, Right, Matter).

%% has_right(_art55, PersonId, _right_to_information, _accusation)
%
% Article 55 - Fully implemented
%
% Rights of the accused party
% (1) The accused party shall have the following rights: to be informed of the criminal offence in relation to which he/she has been constituted
% as party to the proceedings in this particular capacity and on the basis of what evidence; provide or refuse to provide explanations in relation
% to the charges against him/her; study the case, including the information obtained through the use of special intelligence means and take any
% abstracts that are necessary to him/her; adduce evidence; take part in criminal proceedings; make requests, comments and raise objections; be the
% last to make statements; file appeal from acts infringing on his/her rights and legal interests, and have a defence counsel. The accused party shall
% have the right his/her defence counsel to take part when investigative actions are taken, as well as in other procedural action requiring the attendance
% thereof, unless he has expressively made waiver of this particular right.
has_right(art55, PersonId, right_to_information, accusation) :-
    person_status(PersonId, accused).

auxiliary_right_scope(art55_1, [art55]).

auxiliary_right(art55_1, PersonId, accusation, give_explanations) :-
    person_status(PersonId, accused).

auxiliary_right(art55_1, PersonId, accusation, refuse_give_explanations) :-
    person_status(PersonId, accused).

has_right(art55_b, PersonId, right_to_study_case, any_information) :-
    person_status(PersonId, accused).

has_right(art55_b, PersonId, right_to_adduce_evidence, investigation) :-
    person_status(PersonId, accused).

has_right(art55_b, PersonId, right_to_attend_proceedings, trial) :-
    person_status(PersonId, accused).

has_right(art55_b, PersonId, right_to_requests_comments_objections, trial) :-
    person_status(PersonId, accused).

has_right(art55_b, PersonId, right_to_make_statements, trial) :-
    person_status(PersonId, accused).

auxiliary_right(art55_1, PersonId, remedy, appeal) :-
    person_status(PersonId, accused),
    proceeding_matter(PersonId, breach_of_rights).

has_right(art55_c, PersonId, right_to_access_lawyer, trial) :-
    person_status(PersonId, accused),
    proceeding_matter(PersonId, evidence_gathering_act).

has_right(art55_c, PersonId, right_to_access_lawyer, trial) :-
    person_status(PersonId, accused),
    proceeding_matter(PersonId, lawyer_presence_required),
    \+ person_event(PersonId, waive_right).

%% auxiliary_right(_art55_2, PersonId, _access_lawyer, _communication)
%
% Article 55 - Fully implemented
%
% (2) The accused party shall be entitled to receive general information facilitating his/her choice of defence counsel. He/she shall be entitled to
% communicate with his/her defence counsel, to meet in private, to receive advice and other legal assistance, including prior to the start of and during
% the questioning and any other procedural action requiring participation of the accused party.
auxiliary_right_scope(art55_2, [art55_c]).

auxiliary_right(art55_2, PersonId, access_lawyer, communication).
auxiliary_right(art55_2, PersonId, access_lawyer, private_meeting).
auxiliary_right(art55_2, PersonId, access_lawyer, legal_assistence).

%% has_right(_art55_3, PersonId, _right_to_speak_last, _proceedings)
%
% Article 55 - Fully implemented
%
% (3) The accused party shall also have the right of speaking last.
has_right(art55_3, PersonId, right_to_speak_last, proceedings) :-
    person_status(PersonId, accused).

%% has_right(_art55_4_a, PersonId, _right_to_translation, _proceedings)
%
% Article 55 - Fully implemented
%
% (4) Where the accused party does not speak Bulgarian, he shall be provided oral and written translation of the criminal proceedings in a language he understands.
% The accused party shall be provided a written translation of the decree for constitution of the accused party; the court's rulings imposing a remand measure;
% the indictment; the conviction ruled; the judgment of the intermediate appellate review instance; and the judgment of the cassation instance. The accused
% party has the right to waive written translation under this Code, where he has a defence counsel and his procedural rights are not violated.
has_right(art55_4_a, PersonId, right_to_translation, proceedings) :-
    person_status(PersonId, accused),
    proceeding_language(PersonId, bulgarian),
    \+ person_language(PersonId, bulgarian).

has_right(art55_4_b, PersonId, right_to_translation, proceedings) :-
    (
    person_document(PersonId, decree_for_constitution);
    person_document(PersonId, remand_measure);
    person_document(PersonId, indictment);
    person_document(PersonId, conviction);
    person_document(PersonId,judgement)
    ),
    \+ person_event(PersonId, waive_right).

auxiliary_right_scope(art55_4_i, [art55_4_a]).

auxiliary_right(art55_4_i, PersonId, form, written).
auxiliary_right(art55_4_i, PersonId, form, oral).

%% person_status(PersonId, _child)
%
% Article 394 - partially implemented
%
% Examination of cases for crimes committed by underage persons in pursuance of the general procedure
% (1) Where the underage individual has been constituted as accused party for a crime committed by him/her prior to having reached legal age, the case
% shall be examined in pursuance of the general procedure.
% (2) Where the underage individual has been constituted as accused party for an act committed in complicity with an adult, the cases shall not be separated
% and the proceedings shall be conducted in pursuance of the general procedure.
person_status(PersonId, child) :-
    person_age(PersonId, X),
    X < 18,
    \+ exception(person_status(PersonId, X, act_committed)).

%% person_status(PersonId, _child)
%
% Article 31(2) - Fully implemented
%
% (1) penally responsible shall be any person of full age - who has completed 18 years of age, and who has perpetrated a crime in the state of being responsible for his acts.
% (2) A minor - a person who has completed 14 years of age, but has not completed 18 years of age yet - shall be penally responsible if he was able to understand the nature
% and meaning of the act and to manage his actions.
% (3) Minors who cannot be considered culpable of their acts shall be admitted by a decision of the court to a correctional boarding school or to another appropriate establishment,
% should this be found necessary considering the circumstances of the case.
% (4) With regard to the penal responsibility of minors, the special rules provided by this Code shall be applicable.
person_status(PersonId, child) :-
    person_age(PersonId, X),
    X < 18,
    X >= 14,
    person_event(PersonId, child_is_culpable).

%% auxiliary_right(_art385, PersonId, _training, _appropriate)
%
% Article 385 - Fully implemented
%
% In cases for crimes committed by underage persons, pre-trial proceedings shall be conducted by appointed investigative bodies with appropriate training.
auxiliary_right(art385, PersonId, training, appropriate) :-
    proceeding_matter(PersonId, pre_trial),
    person_status(PersonId, child).
%% has_right(_art386, PersonId, _right_to_alternative_measure, _remand_measure)
%
% Article 386 - Fully implemented
%
% Remand measures
% (1) With respect to underage persons, the following remand measures may be taken:
% 1. supervision by the parents or the guardian;
% 2. supervision by the administration of the educational establishment where the underage person has been placed;
% 3. supervision by the inspector at the child pedagogical facility; or by a member of the local Commission for Combating Anti-Social Acts of Minors and Underage Persons;
% 4. Remand in custody.
% (2) The remand measure of custody shall be taken in exceptional cases.
% (3) The remand of underage persons in supervision of persons and bodies under paragraph (1), items 1 - 3, shall be accomplished through signature, whereby the latter shall assume
% the obligation to exercise educative supervision over the underage persons, to watch over their conduct, and to secure their appearance before the investigative body and the court.
% A fine of up to BGN 500 may be imposed for culpable default by such persons.
% (4) In the cases of custody, underage persons shall be placed in suitable premises apart from adults, their parents or guardians and the principal of the educational establishment
% where they study being notified immediately thereof.
% (5) In view of protecting the best interests of the underage person, the notification of the specific person pursuant to paragraph 4 may be postponed for a period of up to 24 hours
% where there is an urgent need, in order to prevent the occurrence of grave unfavourable consequences for the life, freedom or physical integrity of a person or where the investigative
% bodies need to undertake measures, hindrance of which would seriously impede the criminal proceedings. Postponement of this notification shall be applied in view of the special
% circumstances of every specific case, without exceeding what is necessary and not based only on the type and gravity of the committed crime. In this case the State Agency for Child
% Protection shall be notified immediately of the detention and postponement.
% (6) The provisions of paragraphs 5 shall apply in the cases under Article 63, Paragraphs 10 and 11.
has_right(art386, PersonId, right_to_alternative_measure, remand_measure) :-
    person_status(PersonId, child).

auxiliary_right(art386_5, PersonId, notification, immediately) :-
    \+ proceeding_event(Paragraphs, child_interests).

%% auxiliary_right(_art388, PersonId, _assistance, _interrogation)
%
% Article 388 - Fully implemented
%
% Participation of a pedagogue or a psychologist in the interrogation of underage persons
% Where necessary, in the interrogation of an underage accused party a pedagogue or a psychologist shall participate, who may ask questions with the permission of the investigative body.
% The pedagogue or psychologist shall have the right to familiarize themselves with the record of interrogation and to make remarks on the accuracy or completeness of matters recorded therein.
auxiliary_right(art388, PersonId, assistance, interrogation) :-
    proceeding_matter(PersonId, interrogation),
    person_status(PersonId, child).

%% auxiliary_right(_art389, PersonId, _notification, _investigation)
%
% Article 389 - Fully implemented
%
% Presentation of the investigation
% (1) The parents or guardians of the underage accused party shall be mandatorily notified of the presentation of the investigation.
% (2) The parents or guardians of the underage accused party shall be present at the presentation if they so request.
auxiliary_right(art389, PersonId, notification, investigation) :-
    proceeding_matter(PersonId, investigation).

%% auxiliary_right(_art391, PersonId, _private, _court_hearing)
%
% Article 391 - Fully implemented
%
% Court hearing
% (1) The court hearing in cases against underage persons shall be conducted behind closed doors, unless the court finds it in the interest of the public to examine the case at an open court hearing.
% (2) By discretion of the court, an inspector from the child pedagogical facility and a representative of the educational establishment in which the underage person studies may be invited to the court hearing.
auxiliary_right(art391, PersonId, private, court_hearing) :-
    proceeding_matter(PersonId, court_hearing).

%%
%
% Article 122 - Fully implemented
%
% Parental Rights and Obligations
% (1) Bearer of parental rights and obligations with respect to minor children shall be each parent.
% (2) Parents have equal rights and obligations, regardless of whether they are married or not.
% (3) The parent's spouse shall assist the parent in performing his or her obligations.


%% has_right(_art219_3_6, PersonId, _right_to_information, Right)
%
% Article 219 - Fully implemented
%
% (3) In the decree for constitution of the accused party and the record for actions under Paragraph 2 the following shall be indicated:
% 3. The full name of the individual constituted as accused party, the offence on account of which he/she is constituted and its legal qualification;
% 6. The rights of the accused party under Article 55, including his/her right to decline to provide explanation, as well as the right to have
% authorised or appointed counsel.
has_right(art219_3_6, PersonId, right_to_information, Right) :-
    has_right(art55_b, PersonId, Right, _).

%% auxiliary_right(_art219_4, PersonId, _notification, _decree_for_constitution)
%
% Article 219(4) - Fully implemented
%
% Constituting the accused party and presentation of the decree to this effect
% (4) The investigative body shall present the decree for constitution to the accused party and his/her defence counsel, allowing them to gain knowledge of its full
% content and, where needed, giving additional explanations. The investigative body shall serve against a signature a copy of the decree on the accused party.
auxiliary_right(art219_4, PersonId, notification, decree_for_constitution) :-
    person_status(PersonId, accused).

%% has_right(_art30_4, PersonId, _right_to_legal_counsel, _proceedings)
%
% Article 30(4) - Fully implemented
%
% (4) Everyone shall have the right to legal counsel as from the moment they are detained or constituted as an accused party.
has_right(art30_4, PersonId, right_to_legal_counsel, proceedings) :-
    person_status(PersonId, detained);
    person_status(PersonId, accused).

%% auxiliary_right(_art94_1_1, PersonId, _access_lawyer, _mandatory)
%
% Article 94(1)(1) - Fully implemented
%
% Mandatory participation of defence counsel
% (1) Participation of the defence counsel in criminal proceedings shall be mandatory in cases where:
% 1. The accused party is underage;
auxiliary_right(art94_1_1, PersonId, access_lawyer, mandatory) :-
    person_status(PersonId, child).

%% has_right(_art94_3, PersonId, _right_to_appoint_lawyer, _ex_officio)
%
% Article 94(3) - Fully implemented
%
% Mandatory participation of defence counsel
% (2) In cases within the scope of paragraph 1, items 4 and 5, the participation of a defence counsel shall not be mandatory, provided the accused party makes a statement he/she wishes to dispense with having a defence counsel.
% (3) Where participation of a defence counsel is mandatory, the respective body shall appoint a lawyer as a defence counsel.
has_right(art94_3, PersonId, right_to_appoint_lawyer, ex_officio) :-
    proceeding_matter(PersonId, lawyer_presence_required).


%% has_right(_art97, PersonId, _right_to_access_lawyer, _trial)
%
% Article 97 - Fully implemented
%
% Joinder of defence counsel to criminal proceedings
% (1) The defence counsel may join criminal proceedings from the moment an individual is detained or has been constituted in the capacity of accused party.
% (2) The body entrusted with the pre-trial proceedings shall be obligated to explain to the accused party that he/she has the right to defence counsel, as well as to immediately allow him/her to contact one.
% Said body shall be prevented from taking any action within the context of investigation, as well as any other procedural action involving the accused party until it has been acquitted of this obligation.
has_right(art97, PersonId, right_to_access_lawyer, trial) :-
    person_status(PersonId, detained);
    person_status(PersonId, accused).

has_right(art97_2, PersonId, right_to_information, access_lawyer) :-
    person_status(PersonId, accused),
    proceeding_matter(PersonId, pre_trial).

%% has_right(_art219_5, PersonId, _right_to_access_lawyer, _trial)
%
% Article 219(5) - Fully implemented
%
% Constituting the accused party and presentation of the decree to this effect
% (5) In addition to the details under Article 179(1), the subpoena shall also refer to the specific actions in respect of which the person is summonsed; the person's right to appear with
% a defence counsel; the possibility to have a defence counsel appointed in the cases set out in Article 94(1), as well as the possibility to bring the person before court by compulsion
% in case of failure to appear without valid cause. The subpoena shall be served at least three days prior to the indictment.
has_right(art219_5, PersonId, right_to_access_lawyer, trial) :-
    proceeding_event(PersonId, summoned_court).

%% has_right(_art222, PersonId, _right_to_access_lawyer, _interrogation)
%
% Article 222 - Fully implemented
%
% Interrogation of the accused party before a judge
% (1) Should the pre-trial body deem it appropriate, the interrogation shall be made before a judge from the respective first instance court or the court in the area of which the action is
% taken with the participation of a defence counsel, if such exists. In this case the file is not presented to the judge.
% (2) For the interrogation under paragraph (1) the respective body shall secure the appearance of the accused party and his defence counsel.
% (3) Insofar as no special rules have been introduced, interrogation under paragraph 1 shall be conducted following the rules of judicial trial.
has_right(art222, PersonId, right_to_access_lawyer, interrogation) :-
    proceeding_matter(PersonId, interrogation).

has_right(art222, PersonId, right_to_be_present, lawyer) :-
    proceeding_matter(PersonId, interrogation).

%% auxiliary_right(_art271_3, PersonId, _postponement, _hearing)
%
% Article 271(2)(3) - Fully implemented
%
% Deciding on the issue of allowing the case to progress
% (2) The court hearing shall be adjourned where one of the following fails to appear:
% 1. the prosecutor;
% 2. the accused party, should the appearance of the latter be mandatory, except in cases under Article 269, paragraph (3);
% 3. the defence counsel, where his/her replacement is not possible by another without infringing upon the right to defence of the accused party.
auxiliary_right(art271_3, PersonId, postponement, hearing) :-
    \+ proceeding_event(PersonId, lawyer_present).

%% auxiliary_right(_art328, PersonId, _remedy, _trial)
%
% Article 328 - Fully implemented
%
% Summonsing the parties
%
% The parties and the other persons to take part in the intermediate appellate review proceedings shall be summonsed pursuant to the procedure set forth under Articles 178 - 182,
% except where they have been informed by the first instance court of the date on which the case will be examined.
auxiliary_right(art328, PersonId, remedy, trial).

%% auxiliary_right(_art353_1, PersonId, _remedy, _trial)
%
% Article 353(1) - Fully implemented
%
% Examination procedure for cassation appeals and protests
% (1) The cassation appeal and the protest shall be examined at a court hearing to which the parties shall be summonsed.
auxiliary_right(art353_1, PersonId, remedy, trial).

%% auxiliary_right(_art254, PersonId, _private_communication, _lawyer)
%
% Article 254 - Fully implemented
%
% Article 254
% (1) The accused and the defendants shall have the right to receive a visit from the defence counsel thereof immediately after the detention thereof.
% (3) Interviews of the accused and the defendants with lawyers, defence counsel and representing counsel shall be held in private. The said interviews
% may be watched, but the conversations thereof may not be listened to and recorded.
auxiliary_right(art254, PersonId, private_communication, lawyer) :-
    person_status(PersonId, detained).

%% has_right(_art256_1, PersonId, _right_to_communicate, _family)
%
% rticle 256 - Fully implemented
%
% (1) The accused and the defendants shall be entitled:
% 1. to visits, food parcels, parcels of clothing and other articles authorised for personal use, correspondence, outdoor time, and sums of money disposable for spending on their personal needs;
% 2. to telephone communication with immediate and extended family members, defence counsel and representing counsel according to a procedure established by the Chief Director of the Chief
% Directorate of Implementation of Penal Sanctions;
% (2) The correspondence of the accused and the defendants shall not be subject to examination by the administration.
has_right(art256_1, PersonId, right_to_communicate, family) :-
    person_status(PersonId, accused).

has_right(art256_1, PersonId, right_to_communicate, defence_counsel) :-
    person_status(PersonId, accused).

%% auxiliary_right(_art256_2, PersonId, _privacy, _communication)
%
% rticle 256 - Fully implemented
%
% (2) The correspondence of the accused and the defendants shall not be subject to examination by the administration.
auxiliary_right(art256_2, PersonId, privacy, communication).

%%
%
% Article 256(3), 2 sentence - Fully implemented
%
% (3) The accused and the defendants may be refused permission to visits, telephone conversations and correspondence with particular persons on a written warrant of the competent prosecutor or of the court,
% where this is necessitated for the detection or prevention of serious criminal offences. These restrictions on visits, telephone conversations and correspondence shall not apply to the defence counsel and
% the representing counsel, the lineal descendants and ascendants up to any degree, the spouse and the siblings.

%% has_right(_art247b_1, PersonId, _right_to_be_present, _hearing)
%
% Article 247 Criminal Procedure Code
%
% Notification of scheduling the operative hearing
% (1) At the order of the judge-rapporteur a copy of the indictment shall be served on the defendant. Upon serving the indictment, the defendant shall be
% notified of the date of the operative hearing and of the matters specified in Article 248, Paragraph (1), of his/her right to appear with a defence counsel
% and of the possibility to have a defence counsel appointed in the cases set out in Article 94, Paragraph (1), as well as of the fact that the case can be tried
% and adjudicated in the defendant’s absence as per the provisions of Article 269.
% (1) The operative hearing shall be postponed where any of the following does not appear:
% 1. the prosecutor;
% 2. the accused party, should the appearance of the latter be mandatory, except in cases under Article 269, Paragraph (3);
% 3. (declared unconstitutional with Decision No. 14 by the Constitutional Court of the Republic of Bulgaria, in its part regarding the words "in the cases under Article 94,
% Paragraph 1" - SG No. 87/2018) the defender - in the cases under Article 94, Paragraph 1.
has_right(art247b_1, PersonId, right_to_be_present, hearing) :-
    (   person_status(PersonId, suspect)
    ;   person_status(PersonId, accused)
    ),
    proceeding_matter(PersonId, hearing).



