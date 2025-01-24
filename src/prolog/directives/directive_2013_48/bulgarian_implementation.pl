:- module(directive_2013_48_bg, [has_right/5, auxiliary_right/5, auxiliary_right_checked/5, right_property/5, right_property_checked/5, explain/2]).

:- include('./../../utils.pl').

has_right(Right, bg, Article, PersonId, Matter) :-
    has_right(Article, PersonId, Right, Matter).

%%%%% Constitution %%%%%

%% has_right(_art30_4, PersonId, _right_to_legal_counsel, _proceedings)
%
% Article 30(4) - Fully implemented
%
% (4) Everyone shall have the right to legal counsel as from the moment they are detained or constituted as an accused party.
has_right(art30_4, PersonId, right_to_legal_counsel, proceedings) :-
    person_status(PersonId, detained);
    person_status(PersonId, accused).

%%%%% Implementation of Penal Sanctions and Detention in Custody Act %%%%%

%% has_right(_art243_3, PersonId, _right_to_inform, _consular_authority)
%
% Article 243(3) - Fully implemented
%
% (3) The detainees who are not Bulgarian citizens shall be informed of their thereof to contact diplomatic agents or consular officers of the State whose nationality they hold and shall be immediately
% provided with the conditions to do so. If a detainee is a national of two or more states, he/she may choose the consular authorities of which state to be informed of his/her detention which consular
% authorities he/she wishes to contact.
has_right(art243_3, PersonId, right_to_inform, consular_authority) :-
    person_status(PersonId, detained),
    \+ person_nationality(PersonId, bulgaria).

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

%% has_right(_art243_1, PersonId, _right_to_inform, _relatives)
%
% Article 243(1) - Fully implemented
%
% (1) Each detainee may inform immediately the family or the relatives thereof of his or her admission to the places of deprivation of liberty
% If the detainee does not wish to inform the family or the relatives thereof, the said detainee shall sign a declaration to this effect.
% If any such declaration exists, the administration may not inform the relatives on its own initiative.
has_right(art243_1, PersonId, right_to_inform, relatives) :-
    person_status(PersonId, deprived_of_liberty).

%%%%% Bar Act %%%%%

%% auxiliary_right(_arti34_1, PersonId, _private_communication, _lawyer)
%
% Article 34(1) - Fully implemented
%
% (1) Attorneys-at-law or European Union lawyers shall have the right to meet their clients privately, including where the latter are held in custody or are deprived of their liberty.
auxiliary_right(art34_1, PersonId, private_communication, lawyer) :-
    person_status(PersonId, deprived_of_liberty).

%%%%% Military Police Act %%%%%

%% has_right(_art13_2, PersonId, _right_to_access_lawyer, _proceedings)
%
% Article 13(2), 1 sentence - Fully implemented
%
% (2) From the moment of being detained, the persons have the right to a defence counsel, and the right to refuse defence and the consequences of such refusal for him/her, as well as his/her right
% to refuse to give explanations when the detention is based on item 1 of paragraph 1 shall be explained to the person detained, and also to be immediately informed about the grounds for detention
% in a language comprehensible for them, to appeal before a court of law the legality of their detention, and the court shall rule on the appeal immediately. (...)
has_right(art13_2, PersonId, right_to_access_lawyer, proceedings) :-
    person_status(PersonId, detained),
    \+ person_event(PersonId, waive_right).

has_right(art13_2, PersonId, right_to_refuse_explanations, proceedings) :-
    person_status(PersonId, detained).

has_right(art13_2, PersonId, right_to_information, legal_grounds) :-
    person_status(PersonId, detained).

%% has_right(_art13_2, PersonId, _right_to_information, _notification)
%
% Article 13(2), 2 sentence - Fully implemented
%
% (2) (...) Where the person arrested is a foreign national, the consular authorities of the state of which he/she is a citizen shall be immediately notified, at his/her request, through the Ministry of Foreign Affairs. (...)
has_right(art13_2, PersonId, right_to_information, notification) :-
    person_status(PersonId, arrested),
    \+ person_nationality(PersonId, bulgaria).

%%%%% Extradition and European Arrest Warrant Act %%%%%

%% has_right(_, PersonId, _right_to_access_lawyer, _remand_in_custody)
%
% Article 43(4) - Partially implemented
%
% Remand in Custody
% (4) The court shall appoint a defence counsel and an interpreter for the person if the latter has no command of the Bulgarian language and shall explain the grounds for his/her detention,
% the content of the European arrest warrant and his/her right to give consent to surrender to the competent authorities of the issuing Member States and the implications thereof.
has_right(art43_4, PersonId, right_to_access_lawyer, remand_in_custody) :-
    person_status(PersonId, arrested);
    proceeding_matter(PersonId, arrest).

has_right(art43_4, PersonId, right_to_interpretation, remand_in_custody) :-
    person_status(PersonId, arrested);
    proceeding_matter(PersonId, arrest),
    \+ person_language(PersonId, bulgarian).

has_right(art43_4, PersonId, right_to_information, accusation) :-
    person_status(PersonId, detained),
    proceeding_matter(PersonId, europeanArrestWarrant).


%%%%% Criminal Procedure Code %%%%%

%% has_right(_art17_3, PersonId, _right_to_inform, PersonId2)
%
% Article 17(3) - Fully implemented
%
% Inviolability of the person
% (3) The respective body shall be obligated to immediately notify a person indicated by the detained individual of the detention.
has_right(art17_3, PersonId, right_to_inform, PersonId2) :-
    person_status(PersonId, detained),
    person_nominate(PersonId, PersonId2).

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
    person_document(PersonId, judgement)
    ),
    \+ person_event(PersonId, waive_right).

auxiliary_right_scope(art55_4_i, [art55_4_a]).

auxiliary_right(art55_4_i, PersonId, form, written).
auxiliary_right(art55_4_i, PersonId, form, oral).

%% has_right(_art63_8, PersonId, _right_to_inform, _consular_authority)
%
% Article 63(8) - Fully implemented
%
% (8) Where the person arrested is a foreign national, the consular authorities of the state of which he/she is a citizen shall be immediately notified, at his/her request,
% through the Ministry of Foreign Affairs. If the person arrested is a national of two or more states, he/she may choose the consular authorities of which state to be informed
% of his/her detention and with which consular authorities he/she wishes to make a connection.
has_right(art63_8, PersonId, right_to_inform, consular_authority) :-
    person_status(PersonId, arrested),
    \+ person_nationality(PersonId, bulgarian).

%% has_right(_art72_5, PersonId, _right_to_access_lawyer, _detention)
%
% Article 72(5) - Fully implemented
%
% (5) From the moment of being detained, the person has the right to a defence counsel, and the right to refuse defence and the consequences of such refusal for him/her, as well
% as his/her right to refuse to give explanations when the detention is based on item 1 of paragraph 1 shall be explained to the person detained.
has_right(art72_5, PersonId, right_to_access_lawyer, detention) :-
    person_status(PersonId, detained),
    \+ person_status(PersonId, waive_right).

has_right(art72_5, PersonId, right_to_information, accusation) :-
    person_status(PersonId, detained),
    \+ person_status(PersonId, waive_right).

%% has_right(_art97_2, PersonId, _right_to_access_lawyer, _investigation)
%
% Article 97(2) - Fully implemented
%
% Joinder of defence counsel to criminal proceedings
% (1) The defence counsel may join criminal proceedings from the moment an individual is detained or has been constituted in the capacity of accused party.
% (2) The body entrusted with the pre-trial proceedings shall be obligated to explain to the accused party that he/she has the right to defence counsel, as well as to immediately allow him/her to contact one.
% Said body shall be prevented from taking any action within the context of investigation, as well as any other procedural action involving the accused party until it has been acquitted of this obligation.
has_right(art97_2, PersonId, right_to_access_lawyer, investigation):-
    proceeding_matter(PersonId, pre_trial).

%% auxiliary_right(_art128, PersonId, _record, _evidence_gathering_act)
%
% Article 128 - Fully implemented
%
% Drawing up record
% For every investigative action and judicial trial action a record shall be drawn up at the place where it is performed.
auxiliary_right(art128, PersonId, record, evidence_gathering_act) :-
    proceeding_matter(PersonId, evidence_gathering_act).

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



