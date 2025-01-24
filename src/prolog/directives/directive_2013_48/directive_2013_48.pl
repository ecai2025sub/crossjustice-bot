:- module(directive_2013_48, [has_right/5, auxiliary_right/5, auxiliary_right_checked/5, right_property/5, right_property_checked/5, explain/2]).

:- include('./../../utils.pl').

has_right(Right, dir, Article, PersonId, Matter) :-
    once(directive_2013_48_applies(PersonId)),
    has_right(Article, PersonId, Right, Matter).

directive_2013_48_applies(PersonId) :-
    directive_2013_48_applies(art2_1, PersonId);
    directive_2013_48_applies(art2_2, PersonId);
    directive_2013_48_applies(art2_4, PersonId).

% Article 1
% Subject matter
% This Directive lays down minimum rules concerning the rights of suspects and accused
% persons in criminal proceedings and of persons subject to proceedings pursuant to Framework
% Decision 2002/584/JHA (‘European arrest warrant proceedings’) to have access to a lawyer, to
% have a third party informed of the deprivation of liberty and to communicate with third persons
% and with consular authorities while deprived of liberty.

%% directive_2013_48_applies(_art2_1, PersonId)
%
% Article 2.1
%
% This Directive applies to suspects or accused persons in criminal proceedings from the time
% when they are made aware by the competent authorities of a Member State, by official notification or
% otherwise, that they are suspected or accused of having committed a criminal offence, and irrespective
% of whether they are deprived of liberty. It applies until the conclusion of the proceedings, which is
% understood to mean the final determination of the question whether the suspect or accused person has
% committed the offence, including, where applicable, sentencing and the resolution of any appeal.
directive_2013_48_applies(art2_1, PersonId) :-
    (   person_status(PersonId, suspect)
    ;   person_status(PersonId, accused)
    ),
    person_made_aware(PersonId, personStatus),
    proceeding_status(PersonId, started),
    \+ proceeding_status(PersonId, concluded).

%% directive_2013_48_applies(art2_2, PersonId)
%
% Article 2.2
%
% This Directive applies to persons subject to European arrest warrant proceedings (requested
% persons) from the time of their arrest in the executing Member State in accordance with Article 10.
directive_2013_48_applies(art2_2, PersonId) :-
    person_status(PersonId, requested),
    proceeding_type(PersonId, europeanArrestWarrant).

% 3. This Directive also applies, under the same conditions as provided for in paragraph 1, to
% persons other than suspects or accused persons who, in the course of questioning by the police or
% by another law enforcement authority, become suspects or accused persons.

% 4.   Without prejudice to the right to a fair trial, in respect of minor offences:
% (a)
% where the law of a Member State provides for the imposition of a sanction by an authority other than
% a court having jurisdiction in criminal matters, and the imposition of such a sanction may be appealed
% or referred to such a court; or
%
% (b)
% where deprivation of liberty cannot be imposed as a sanction;
% this Directive shall only apply to the proceedings before a court having jurisdiction in
% criminal matters.

%% directive_2013_48_applies(_art2_4, PersonId)
%
% Article 2.4
%
% In any event, this Directive shall fully apply where the suspect or accused person is
% deprived of liberty, irrespective of the stage of the criminal proceedings.
directive_2013_48_applies(art2_4, PersonId) :-
    person_status(PersonId, deprived_of_liberty).

%% has_right(_art3, PersonId, _right_to_access_lawyer, _criminal_proceedings)
%
% Article 3.1
%
% The right of access to a lawyer in criminal proceedings
% 1. Member States shall ensure that suspects and accused persons have the right of access to a
% lawyer in such time and in such a manner so as to allow the persons concerned to exercise their
% rights of defence practically and effectively.
has_right(art3, PersonId, right_to_access_lawyer, criminal_proceedings) :-
    person_status(PersonId, suspect);
    person_status(PersonId, accused).

%% has_right(_art3_2, PersonId, _right_to_access_lawyer, _)
%
% Article 3.2
%
% 2. Suspects or accused persons shall have access to a lawyer without undue delay.
% In any event, suspects or accused persons shall have access to a lawyer from whichever of the
% following points in time is the earliest:
% (a)
% before they are questioned by the police or by another law enforcement or judicial authority;
% (b) upon the carrying out by investigating or other competent authorities of an investigative or
% other evidence-gathering act in accordance with point (c) of paragraph 3;
% (c) without undue delay after deprivation of liberty;
% (d) where they have been summoned to appear before a court having jurisdiction in criminal matters,
% in due time before they appear before that court.

has_right(art3_2_a, PersonId, right_to_access_lawyer, questioning) :-
    (   person_status(PersonId, suspect)
    ;   person_status(PersonId, accused)
    ),
    proceeding_matter(PersonId, questioning).

has_right(art3_2_b, PersonId, right_to_access_lawyer, evidence_gathering_act) :-
    (   person_status(PersonId, suspect)
    ;   person_status(PersonId, accused)
    ),
    proceeding_matter(PersonId, evidence_gathering_act).

has_right(art3_2_c, PersonId, right_to_access_lawyer, deprived_of_liberty) :-
    person_status(PersonId, deprived_of_liberty),
    \+ exception(has_right(art3_2_c, PersonId, right_to_access_lawyer, deprived_of_liberty), _).

has_right(art3_2_d, PersonId, right_to_access_lawyer, summoned_court) :-
    proceeding_matter(PersonId, summoned_court).

%% auxiliary_right(_art3_3_a, PersonId, _private_communication, _lawyer)
%
% Article 3.3.a
%
% The right of access to a lawyer shall entail the following:
% (a) Member States shall ensure that suspects or accused persons have the right to meet in private and
% communicate with the lawyer representing them, including prior to questioning by the police or by
% another law enforcement or judicial authority;
auxiliary_right_scope(art3_3_a, [art3, art3_2_a, art3_2_b, art3_2_c]).

auxiliary_right(art3_3_a, PersonId, private_communication, lawyer) :-
    \+ exception(auxiliary_right(art3_3_a, PersonId, private_communication, lawyer), _).

%% auxiliary_right(_art3_3_b, PersonId, _effective_participation, _lawyer)
%
% Article 3.3.b
%
% The right of access to a lawyer shall entail the following:
% (b) Member States shall ensure that suspects or accused persons have the right for their lawyer to be
% present and participate effectively when questioned. Such participation shall be in accordance with
% procedures under national law, provided that such procedures do not prejudice the effective
% exercise and essence of the right concerned. Where a lawyer participates during questioning, the
% fact that such participation has taken place shall be noted using the recording procedure in
% accordance with the law of the Member State concerned;
auxiliary_right_scope(art3_3_b, [art3, art3_2_a, art3_2_b, art3_2_c]).

auxiliary_right(art3_3_b, PersonId, effective_participation, lawyer) :-
    \+ exception(auxiliary_right(art3_3_b, PersonId, effective_participation, lawyer), _).

%% auxiliary_right(_art3_3_b, PersonId, _participation_recorded, _questioning)
%
% Article 3.3.b
%
% The right of access to a lawyer shall entail the following:
% (b) Member States shall ensure that suspects or accused persons have the right for their lawyer to be
% present and participate effectively when questioned. Such participation shall be in accordance with
% procedures under national law, provided that such procedures do not prejudice the effective
% exercise and essence of the right concerned. Where a lawyer participates during questioning, the
% fact that such participation has taken place shall be noted using the recording procedure in
% accordance with the law of the Member State concerned;

auxiliary_right(art3_3_b, PersonId, participation_recorded, questioning) :-
    \+ exception(auxiliary_right(art3_3_b, PersonId, participation_recorded, questioning), _).

%% auxiliary_right(_art3_3_c, PersonId, _right_to_attend, _evidence_gathering_act)
%
% Article 3.3.c
%
% The right of access to a lawyer shall entail the following: (c)
% Member States shall ensure that suspects or accused persons shall have, as a minimum, the
% right for their lawyer to attend the following investigative or evidence-gathering acts where
% those acts are provided for under national law and if the suspect or accused person is required
% or permitted to attend the act concerned:
% (i) identity parades;
% (ii) confrontations;
% (iii) reconstructions of the scene of a crime.
auxiliary_right_scope(art3_3_c, [art3, art3_2_a, art3_2_b, art3_2_c]).

auxiliary_right(art3_3_c, PersonId, right_to_attend, evidence_gathering_act) :-
    proceeding_matter(PersonId, identity_parade);
    proceeding_matter(PersonId, confrontations);
    proceeding_matter(PersonId, reconstructions_crime_scene),
    \+ exception(auxiliary_right(art3_3_c, PersonId, right_to_attend, evidence_gathering_act), _).

%% auxiliary_right(_art3_4, PersonId, _effective_exercise, _lawyer)
%
% Article 3.4
%
% Member States shall endeavour to make general information available to facilitate the
% obtaining of a lawyer by suspects or accused persons.
% Notwithstanding provisions of national law concerning the mandatory presence of a lawyer,
% Member States shall make the necessary arrangements to ensure that suspects or accused persons who
% are deprived of liberty are in a position to exercise effectively their right of access to a lawyer,
% unless they have waived that right in accordance with Article 9.
auxiliary_right_scope(art3_4, [art3, art3_2_a, art3_2_b, art3_2_c]).

auxiliary_right(art3_4, PersonId, effective_exercise, lawyer) :-
    person_status(PersonId, deprived_of_liberty),
    \+ person_event(PersonId, waive_right),
    \+ exception(auxiliary_right(art3_4, PersonId, effective_exercise, lawyer), _).

%% exception(_has_right(_art3_2_c, PersonId, _right_to_access_lawyer, _deprived_of_liberty), _art3_5)
%
% Article 3.5
%
% In exceptional circumstances and only at the pre-trial stage, Member States may temporarily
% derogate from the application of point (c) of paragraph 2 where the geographical remoteness of a
% suspect or accused person makes it impossible to ensure the right of access to a lawyer without
% undue delay after deprivation of liberty.
exception(has_right(art3_2_c, PersonId, right_to_access_lawyer, deprived_of_liberty), art3_5) :-
    proceeding_matter(PersonId, pre_trial),
    person_event(PersonId, geographical_remoteness).

%% exception(_auxiliary_right(art3_3, PersonId, _, _), _art3_6_a)
%
% Article 3.6.a
%
% In exceptional circumstances and only at the pre-trial stage, Member States may temporarily
% derogate from the application of the rights provided for in paragraph 3 to the extent justified
% in the light of the particular circumstances of the case, on the basis of one of the following
% compelling reasons:
% (a)
% where there is an urgent need to avert serious adverse consequences for the life, liberty or
% physical integrity of a person;
exception(auxiliary_right(art3_3_a, PersonId, private_communication, lawyer), art3_6_a) :-
    art3_6_a(PersonId).

exception(auxiliary_right(art3_3_b, PersonId, participation_recorded, questioning), art3_6_a) :-
    art3_6_a(PersonId).

exception(auxiliary_right(art3_3_b, PersonId, effective_participation, lawyer), art3_6_a) :-
    art3_6_a(PersonId).

exception(auxiliary_right(art3_3_c, PersonId, right_to_attend, evidence_gathering_act), art3_6_a) :-
    art3_6_a(PersonId).

exception(auxiliary_right(art3_4, PersonId, effective_exercise, lawyer), art3_6_a) :-
    art3_6_a(PersonId).

art3_6_a(PersonId) :-
    person_danger(PersonId, life);
    person_danger(PersonId, liberty);
    person_danger(PersonId, physical_integrity).

%% exception(_auxiliary_right(art3_3, PersonId, _, _), _art3_6_b)
%
% Article 3.6.b
%
% In exceptional circumstances and only at the pre-trial stage, Member States may temporarily
% derogate from the application of the rights provided for in paragraph 3 to the extent justified
% in the light of the particular circumstances of the case, on the basis of one of the following
% compelling reasons:
% (b) where immediate action by the investigating authorities is imperative to prevent substantial
% jeopardy to criminal proceedings.
exception(auxiliary_right(art3_3_a, PersonId, private_communication, lawyer), art3_6_b) :-
    art3_6_b(PersonId).

exception(auxiliary_right(art3_3_b, PersonId, participation_recorded, questioning), art3_6_b) :-
    art3_6_b(PersonId).

exception(auxiliary_right(art3_3_b, PersonId, effective_participation, lawyer), art3_6_b) :-
    art3_6_b(PersonId).

exception(auxiliary_right(art3_3_c, PersonId, right_to_attend, evidence_gathering_act), art3_6_b) :-
    art3_6_b(PersonId).

exception(auxiliary_right(art3_4, PersonId, effective_exercise, lawyer), art3_6_b) :-
    art3_6_b(PersonId).

art3_6_b(PersonId) :-
    imperative_immediate_action(PersonId, investigating_authority).

%% has_right(_art4, PersonId, _right_to_communicate, _lawyer_confidentiality)
%
% Article 4
%
% Confidentiality
% Member States shall respect the confidentiality of communication between suspects or accused
% persons and their lawyer in the exercise of the right of access to a lawyer provided for under
% this Directive. Such communication shall include meetings, correspondence, telephone conversations
% and other forms of communication permitted under national law.
auxiliary_right_scope(art4, [art3, art3_2_a, art3_2_b]).

auxiliary_right(art4, PersonId, lawyer_confidentiality, private_communication).

%% has_right(_art5_1, PersonId, _right_to_information, _inform_person)
%
% Article 5.1
%
% The right to have a third person informed of the deprivation of liberty
% 1. Member States shall ensure that suspects or accused persons who are deprived of liberty have
% the right to have at least one person, such as a relative or an employer, nominated by them, informed
% of their deprivation of liberty without undue delay if they so wish.
has_right(art5_1, PersonId, right_to_inform, PersonId2) :-
    (   person_status(PersonId, suspect)
    ;   person_status(PersonId, accused)
    ),
    person_status(PersonId, deprived_of_liberty),
    person_nominate(PersonId, PersonId2),
    \+ exception(has_right(art5_1, PersonId, right_to_inform, PersonId2), _).

% 2. If the suspect or accused person is a child, Member States shall ensure that the holder
% of parental responsibility of the child is informed as soon as possible of the deprivation of
% liberty and of the reasons pertaining thereto, unless it would be contrary to the best interests
% of the child, in which case another appropriate adult shall be informed. For the purposes of this
% paragraph, a person below the age of 18 years shall be considered to be a child.

% has_right(art5_2, PersonId, right_to_information, holder_parental_responsibility) :-
% TODO - Rewrite article?

% 3. Member States may temporarily derogate from the application of the rights set out in
% paragraphs 1 and 2 where justified in the light of the particular circumstances of the case
% on the basis of one of the following compelling reasons:

%% exception(_has_right(_art5_1, PersonId, _right_to_information, _inform_person), _art5_3)
%
% Article 5.3
%
% (a) where there is an urgent need to avert serious adverse consequences for the life, liberty
% or physical integrity of a person;
% (b) where there is an urgent need to prevent a situation where criminal proceedings could be
% substantially jeopardised.
exception(has_right(art5_1, PersonId, right_to_inform, PersonId2), art5_3_a) :-
    person_danger(PersonId, life);
    person_danger(PersonId, liberty);
    person_danger(PersonId, physical_integrity).

exception(has_right(art5_1, PersonId, right_to_inform, PersonId2), art5_3_b) :-
    proceeding_danger(PersonId, substantially_jeopardised).

% 4.   Where Member States temporarily derogate from the application of the right set out in
% paragraph 2, they shall ensure that an authority responsible for the protection or welfare of
% children is informed without undue delay of the deprivation of liberty of the child.

%% has_right(_art6_1, PersonId, _right_to_communicate, PersonId2)
%
% Article 6.1
%
% The right to communicate, while deprived of liberty, with third persons
% 1. Member States shall ensure that suspects or accused persons who are deprived of liberty have
% the right to communicate without undue delay with at least one third person, such as a relative,
% nominated by them.
has_right(art6_1, PersonId, right_to_communicate, PersonId2) :-
    (   person_status(PersonId, suspect)
    ;   person_status(PersonId, accused)
    ),
    person_status(PersonId, deprived_of_liberty),
    person_nominate(PersonId, PersonId2).

% 2. Member States may limit or defer the exercise of the right referred to in paragraph 1 in
% view of imperative requirements or proportionate operational requirements.

% TODO - Fix as exception?

%% has_right(_art7_1, PersonId, _right_to_inform, _consular_authority)
%
% Article 7.1
%
% The right to communicate with consular authorities
% 1. Member States shall ensure that suspects or accused persons who are non-nationals and who are
% deprived of liberty have the right to have the consular authorities of their State of nationality
% informed of the deprivation of liberty without undue delay and to communicate with those authorities,
% if they so wish. However, where suspects or accused persons have two or more nationalities, they may
% choose which consular authorities, if any, are to be informed of the deprivation of liberty and with
% whom they wish to communicate.
has_right(art7_1, PersonId, right_to_inform, consular_authority) :-
    (   person_status(PersonId, suspect)
    ;   person_status(PersonId, accused)
    ),
    person_status(PersonId, deprived_of_liberty),
    proceeding_country(PersonId, Country),
    \+ person_nationality(PersonId, Country).

%% has_right(_art7_2, PersonId, _right_to_communicate, _consular_authority)
%
% Article 7.2
%
% Suspects or accused persons also have the right to be visited by their consular authorities,
% the right to converse and correspond with them and the right to have legal representation arranged
% for by their consular authorities, subject to the agreement of those authorities and the wishes of
% the suspects or accused persons concerned.
has_right(art7_2, PersonId, right_to_communicate, consular_authority) :-
    (   person_status(PersonId, suspect)
    ;   person_status(PersonId, accused)
    ),
    person_status(PersonId, deprived_of_liberty),
    proceeding_country(PersonId, Country),
    \+ person_nationality(PersonId, Country).

% 3. The exercise of the rights laid down in this Article may be regulated by national law or
% procedures, provided that such law or procedures enable full effect to be given to the purposes
% for which these rights are intended.

%% right_property(_art8_2, PersonId, _taken_by, _competent_authority)
%
% Article 8
%
% General conditions for applying temporary derogations
% 1.   Any temporary derogation under Article 3(5) or (6) or under Article 5(3) shall
% (a) be proportionate and not go beyond what is necessary;
% (b) be strictly limited in time;
% (c) not be based exclusively on the type or the seriousness of the alleged offence; and
% (d) not prejudice the overall fairness of the proceedings.
% 2. Temporary derogations under Article 3(5) or (6) may be authorised only by a duly reasoned
% decision taken on a case-by-case basis, either by a judicial authority, or by another competent
% authority on condition that the decision can be submitted to judicial review. The duly reasoned
% decision shall be recorded using the recording procedure in accordance with the law of the Member
% State concerned.
right_property_scope(art8_2, [art3, art3_2_a, art3_2_b, art3_2_c, art5_1]).

right_property(art8_2, PersonId, decision_taken_by, competent_authority).

%% right_property(_art8_2, PersonId, _record, _recording_procedure)
%
% Article 8
%
% General conditions for applying temporary derogations
% 1.   Any temporary derogation under Article 3(5) or (6) or under Article 5(3) shall
% (a) be proportionate and not go beyond what is necessary;
% (b) be strictly limited in time;
% (c) not be based exclusively on the type or the seriousness of the alleged offence; and
% (d) not prejudice the overall fairness of the proceedings.
% 2. Temporary derogations under Article 3(5) or (6) may be authorised only by a duly reasoned
% decision taken on a case-by-case basis, either by a judicial authority, or by another competent
% authority on condition that the decision can be submitted to judicial review. The duly reasoned
% decision shall be recorded using the recording procedure in accordance with the law of the Member
% State concerned.
right_property_scope(art8_2, [art3, art3_2_a, art3_2_b, art3_2_c, art5_1]).

right_property(art8_2, PersonId, record, recording_procedure).

% TODO - Can we give a property to an auxiliary right?

% 3. Temporary derogations under Article 5(3) may be authorised only on a case-by-case basis, 
% either by a judicial authority, or by another competent authority on condition that the decision 
% can be submitted to judicial review.

%% auxiliary_right(_art9, PersonId, _waiver, _right)
%
% Article 9
%
% Waiver
% 1. Without prejudice to national law requiring the mandatory presence or assistance of a lawyer,
% Member States shall ensure that, in relation to any waiver of a right referred to in
% Articles 3 and 10:
% (a) the suspect or accused person has been provided, orally or in writing, with clear and sufficient
% information in simple and understandable language about the content of the right concerned and the
% possible consequences of waiving it; and
% (b) the waiver is given voluntarily and unequivocally.
auxiliary_right_scope(art9, [art3, art3_2_a, art3_2_b, art3_2_c, art5_1]).

auxiliary_right(art9, PersonId, waiver, right) :-
    person_status(PersonId, priorInformationReceived),
    waiver_status(PersonId, unequivocalVoluntary).

% 2. The waiver, which can be made in writing or orally, shall be noted, as well as the
% circumstances under which the waiver was given, using the recording procedure in accordance with the
% law of the Member State concerned.
% TODO - Can we have right_property of an aux right? or should this be connected to OG right?

% 3. Member States shall ensure that suspects or accused persons may revoke a waiver subsequently
% at any point during the criminal proceedings and that they are informed about that possibility.
% Such a revocation shall have effect from the moment it is made.

%% has_right(_art10, PersonId, _right_to_access_lawyer, _europeanArrestWarrant)
%
% Article 10
%
% The right of access to a lawyer in European arrest warrant proceedings
% 1. Member States shall ensure that a requested person has the right of access to a lawyer in the
% executing Member State upon arrest pursuant to the European arrest warrant.
has_right(art10, PersonId, right_to_access_lawyer, europeanArrestWarrant) :-
    person_status(PersonId, requested),
    proceeding_type(PersonId, europeanArrestWarrant).

%% has_right(_art10_2, PersonId, _right_to_access_lawyer, _)
%
% Article 10.2
%
% With regard to the content of the right of access to a lawyer in the executing Member State,
% requested persons shall have the following rights in that Member State:
% (a)the right of access to a lawyer in such time and in such a manner as to allow the requested
% persons to exercise their rights effectively and in any event without undue delay from deprivation
% of liberty;
% (b)the right to meet and communicate with the lawyer representing them;
% (c)the right for their lawyer to be present and, in accordance with procedures in national law,
% participate during a hearing of a requested person by the executing judicial authority. Where a
% lawyer participates during the hearing this shall be noted using the recording procedure in
% accordance with the law of the Member State concerned.
has_right(art10_2_a, PersonId, right_to_access_lawyer, europeanArrestWarrant) :-
    person_status(PersonId, requested),
    person_status(PersonId, deprived_of_liberty).

has_right(art10_2_b, PersonId, right_to_access_lawyer, meet_communicate) :-
    person_status(PersonId, requested).

has_right(art10_2_c, PersonId, right_to_access_lawyer, hearing) :-
    person_status(PersonId, requested),
    proceeding_matter(PersonId, hearing).

% 3. The rights provided for in Articles 4, 5, 6, 7, 9, and, where a temporary derogation under
% Article 5(3) is applied, in Article 8, shall apply, mutatis mutandis, to European arrest warrant
% proceedings in the executing Member State.

% TODO

%% auxiliary_right(_art10_4, PersonId, _appoint_lawyer, _issuing_memberState)
%
% Article 10.4
%
% The competent authority in the executing Member State shall, without undue delay after
% deprivation of liberty, inform requested persons that they have the right to appoint a lawyer
% in the issuing Member State. The role of that lawyer in the issuing Member State is to assist
% the lawyer in the executing Member State by providing that lawyer with information and advice
% with a view to the effective exercise of the rights of requested persons under Framework Decision
% 2002/584/JHA.
auxiliary_right_scope(art10_4, [art10, art10_2_a]).

auxiliary_right(art10_4, PersonId, appoint_lawyer, issuing_memberState).

% 5. Where requested persons wish to exercise the right to appoint a lawyer in the issuing Member
% State and do not already have such a lawyer, the competent authority in the executing Member State
% shall promptly inform the competent authority in the issuing Member State. The competent authority
% of that Member State shall, without undue delay, provide the requested persons with information to
% facilitate them in appointing a lawyer there.

% 6. The right of a requested person to appoint a lawyer in the issuing Member State is without
% prejudice to the time-limits set out in Framework Decision 2002/584/JHA or the obligation on the
% executing judicial authority to decide, within those time-limits and the conditions defined under
% that Framework Decision, whether the person is to be surrendered.

%% auxiliary_right(_art12_1, PersonId, _remedy, _breach_of_rights)
%
% Article 12
%
% Remedies
% 1. Member States shall ensure that suspects or accused persons in criminal proceedings, as well
% as requested persons in European arrest warrant proceedings, have an effective remedy under
% national law in the event of a breach of the rights under this Directive.
auxiliary_right_scope(art12_1, [art3, art3_2_a, art3_2_b, art3_2_c, art5_1, art10, art10_2_a]).

auxiliary_right(art12_1, PersonId, remedy, breach_of_rights) :-
    proceeding_matter(PersonId, breach_of_rights).

% 2. Without prejudice to national rules and systems on the admissibility of evidence, Member
% States shall ensure that, in criminal proceedings, in the assessment of statements made by
% suspects or accused persons or of evidence obtained in breach of their right to a lawyer or in
% cases where a derogation to this right was authorised in accordance with Article 3(6), the rights
% of the defence and the fairness of the proceedings are respected.