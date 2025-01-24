:- module(directive_2016_1919, [has_right/5, auxiliary_right/5, auxiliary_right_checked/5, right_property/5, right_property_checked/5, explain/2]).

:- include('./../../utils.pl').

has_right(Right, dir, Article, PersonId, Matter) :-
    once(directive_2016_1919_applies(PersonId)),
    has_right(Article, PersonId, Right, Matter).

directive_2016_1919_applies(PersonId) :-
    directive_2016_1919_applies(art1_1, PersonId, proceedingData),
    directive_2016_1919_applies(art2, PersonId, personalData).

%% directive_2016_1919_applies(_art1_1, PersonId, _proceedingData)
%
% Article 1
% Subject matter
%
% 1. This Directive lays down common minimum rules concerning the right to legal aid for:
% (a)suspects and accused persons in criminal proceedings; and
directive_2016_1919_applies(art1_1, PersonId, proceedingData) :-
    proceeding_type(PersonId, criminal).

% (b)persons who are the subject of European arrest warrant proceedings pursuant to
% Framework Decision 2002/584/JHA (requested persons).
directive_2016_1919_applies(art1_1, PersonId, proceedingData) :-
    proceeding_type(PersonId, europeanArrestWarrant).

% 2. This Directive complements Directives 2013/48/EU and (EU) 2016/800. Nothing in this Directive
% shall be interpreted as limiting the rights provided for in those Directives.

%% directive_2016_1919_applies(_art2, PersonId, _personalData)
%
% Article 2
% Scope
%
% 1. This Directive applies to suspects and accused persons in criminal proceedings who have a right
% of access to a lawyer pursuant to Directive 2013/48/EU and who are:
% (a)deprived of liberty;
% (b)required to be assisted by a lawyer in accordance with Union or national law; or
% (c)required or permitted to attend an investigative or evidence-gathering act, including as a minimum the following:
% (i)identity parades;
% (ii)confrontations;
% (iii)reconstructions of the scene of a crime.
% 2. This Directive also applies, upon arrest in the executing Member State,
% to requested persons who have a right of access to a lawyer pursuant to Directive 2013/48/EU.
% 3. This Directive also applies, under the same conditions as provided for in paragraph 1, to persons who
% were not initially suspects or accused persons but become suspects or accused persons in the course of questioning
% by the police or by another law enforcement authority.
% 6. Without prejudice to the right to a fair trial, in respect of minor offences:
% (a)where the law of a Member State provides for the imposition of a sanction by an authority other than a court
% having jurisdiction in criminal matters, and the imposition of such a sanction may be appealed or referred to
% such a court; or
% (b)where deprivation of liberty cannot be imposed as a sanction,
% this Directive shall only apply to the proceedings before a court having jurisdiction in criminal matters.
% In any event, this Directive applies when a decision on detention is taken, and during detention, at any
% stage of the proceedings until the conclusion of the proceedings.
art2_1Applies(PersonId) :-
    (   person_status(PersonId, suspect)
    ;   person_status(PersonId, accused)
    ).

directive_2016_1919_applies(art2, PersonId, personalData) :-
    (   art2_1Applies(PersonId)
    ;   art2_2Applies(PersonId)
    ),
    person_status(PersonId, deprived_of_liberty).

directive_2016_1919_applies(art2, PersonId, personalData) :-
    (   art2_1Applies(PersonId)
    ;   art2_2Applies(PersonId)
    ),
    person_status(PersonId, require_lawyer_assistance).

directive_2016_1919_applies(art2, PersonId, personalData) :-
    (   art2_1Applies(PersonId)
    ;   art2_2Applies(PersonId)
    ),
    person_event(PersonId, attend_investigative_act).

directive_2016_1919_applies(art2, PersonId, personalData) :-
    (   art2_1Applies(PersonId)
    ;   art2_2Applies(PersonId)
    ),
    person_event(PersonId, attend_idendity_parade).

directive_2016_1919_applies(art2, PersonId, personalData) :-
    (   art2_1Applies(PersonId)
    ;   art2_2Applies(PersonId)
    ),
    person_event(PersonId, attend_confrontation).

directive_2016_1919_applies(art2, PersonId, personalData) :-
    (   art2_1Applies(PersonId)
    ;   art2_2Applies(PersonId)
    ),
    person_event(PersonId, attend_reconstructions_crime_scene).

directive_2016_1919_applies(art2, PersonId, personalData) :-
    person_status(PersonId, raise_suspicion).

directive_2016_1919_applies(art2, PersonId, personalData) :-
    art2_2Applies(PersonId).

art2_2Applies(PersonId) :-
    person_status(PersonId, requested).

directive_2016_1919_applies(art2, PersonId, personalData) :-
    proceeding_matter(PersonId, detention);
    person_status(PersonId, detained).

%% right_property(_art3, PersonId, _funding, _memberState)
%
% Article 3
% Definition
%
% For the purposes of this Directive, ‘legal aid’ means funding by a Member State of the assistance of a lawyer,
% enabling the exercise of the right of access to a lawyer.
right_property_scope(art3, [art4, art5, art5_3]).

right_property(art3, PersonId, funding, memberState).

%% has_right(_art4, PersonId, _right_to_legal_aid, _free)
%
% Article 4
% Legal aid in criminal proceedings
%
% 1. Member States shall ensure that suspects and accused persons who lack sufficient resources to pay for the
% assistance of a lawyer have the right to legal aid when the interests of justice so require.
%% 2. Member States may apply a means test, a merits test, or both to determine whether legal aid is to be granted in accordance with paragraph 1.
has_right(art4, PersonId, right_to_legal_aid, free) :-
    (   person_status(PersonId, suspect)
    ;   person_status(PersonId, accused)
    ),
    authority_decision(PersonId, lack_resources).

authority_decision(PersonId, lack_resources) :-
    proceeding_matter(PersonId, means_test);
    proceeding_matter(PersonId, merits_test).

% 3. Where a Member State applies a means test, it shall take into account all relevant and objective factors,
% such as the income, capital and family situation of the person concerned, as well as the costs of the assistance of a lawyer
% and the standard of living in that Member State, in order to determine whether, in accordance with the applicable criteria
% in that Member State, a suspect or an accused person lacks sufficient resources to pay for the assistance of a lawyer.

% 4. Where a Member State applies a merits test, it shall take into account the seriousness of the criminal offence, the complexity of
% the case and the severity of the sanction at stake, in order to determine whether the interests of justice require legal aid to be granted. 
% In any event, the merits test shall be deemed to have been met in the following situations:
% (a)where a suspect or an accused person is brought before a competent court or judge in order to decide on detention at any stage of
% the proceedings within the scope of this Directive; and
% (b)during detention.

%% right_property(_art4_5, PersonId, _time, _without_undue_delay)
%
% Article 4.5
%
% 5. Member States shall ensure that legal aid is granted without undue delay, and at the latest before questioning by the police, by another 
% law enforcement authority or by a judicial authority, or before the investigative or evidence-gathering acts referred to in point (c) of 
% Article 2(1) are carried out.
right_property_scope(art4_5, [art4, art5, art5_3]).

right_property(art4_5, PersonId, time, without_undue_delay).

% 6. Legal aid shall be granted only for the purposes of the criminal proceedings in which the person concerned is suspected or accused of 
% having committed a criminal offence.

%% has_right(_art5, PersonId, _right_to_legal_aid, _free)
%
% Article 5
% Legal aid in European arrest warrant proceedings
%
% 1. The executing Member State shall ensure that requested persons have a right to legal aid upon arrest pursuant to a European arrest warrant 
% until they are surrendered, or until the decision not to surrender them becomes final.
has_right(art5, PersonId, right_to_legal_aid, free) :-
    person_status(PersonId, requested),
    proceeding_type(PersonId, europeanArrestWarrant),
    \+ person_event(PersonId, surrender).

%% auxiliary_right(_art5_2, PersonId, _appoint_lawyer, _issuing_Member_State)
%
% Article 5.2
%
% 2. The issuing Member State shall ensure that requested persons who are the subject of European arrest warrant proceedings for the purpose of 
% conducting a criminal prosecution and who exercise their right to appoint a lawyer in the issuing Member State to assist the lawyer in the 
% executing Member State in accordance with Article 10(4) and (5) of Directive 2013/48/EU have the right to legal aid in the issuing Member State 
% for the purpose of such proceedings in the executing Member State, in so far as legal aid is necessary to ensure effective access to justice.
auxiliary_right_scope(art5_2, [art5, art5_3]).

auxiliary_right(art5_2, PersonId, appoint_lawyer, issuing_Member_State).

%% has_right(_art5_3, PersonId, _right_to_legal_aid, _free) 
%
% Article 5.3
%
% 3. The right to legal aid referred to in paragraphs 1 and 2 may be subject to a means test in accordance with Article 4(3), 
% which shall apply mutatis mutandis.
has_right(art5_3, PersonId, right_to_legal_aid, free) :-
    person_status(PersonId, requested),
    proceeding_type(PersonId, europeanArrestWarrant),
    authority_decision(PersonId, lack_resources),
    \+ person_event(PersonId, surrender).

%% right_property(_art7_1, PersonId, _quality, _)
%
% Article 7
% Quality of legal aid services and training
%
% 1. Member States shall take necessary measures, including with regard to funding, to ensure that:
% (a)there is an effective legal aid system that is of an adequate quality; and
% (b)legal aid services are of a quality adequate to safeguard the fairness of the proceedings, with due respect for the
% independence of the legal profession.
right_property_scope(art7_1, [art4, art5, art5_3]).

right_property(art7_1, PersonId, quality, effective_legal_aid).
right_property(art7_1, PersonId, quality, safeguard_fairness_proceedings).

%% auxiliary_right(_art7_4, PersonId, _training, _staff)
%
% Article 7.2
%
% 2. Member States shall ensure that adequate training is provided to staff involved in the decision-making
% on legal aid in criminal proceedings and in European arrest warrant proceedings.
right_property_scope(art7_2, [art4, art5, art5_3]).

right_property(art7_2, PersonId, training, staff).

%% auxiliary_right(_art7_4, PersonId, _training, _lawyers)
%
% Article 7.3
%
% 3. With due respect for the independence of the legal profession and for the role of those responsible for the training of lawyers, Member States shall 
% take appropriate measures to promote the provision of adequate training to lawyers providing legal aid services.
right_property_scope(art7_3, [art4, art5, art5_3]).

right_property(art7_3, PersonId, training, lawyers).

%% auxiliary_right(_art7_4, PersonId, _replace, _lawyer)
%
% Article 7.4
%
% 4. Member States shall take the necessary measures to ensure that suspects, accused persons and requested persons have the right, upon their request, 
% to have the lawyer providing legal aid services assigned to them replaced, where the specific circumstances so justify.
auxiliary_right_scope(art7_4, [art4, art5, art5_3]).

auxiliary_right(art7_4, PersonId, replace, lawyer).

%% auxiliary_right(_art8, PersonId, _remedy, _breach_of_rights)
%
% Article 8
% Remedies
%
% Member States shall ensure that suspects, accused persons and requested persons have an effective remedy under national law in the event of 
% a breach of their rights under this Directive.
auxiliary_right_scope(art8, [art4, art5, art5_3]).

auxiliary_right(art8, PersonId, remedy, breach_of_rights).

% Article 9
% Vulnerable persons
% Member States shall ensure that the particular needs of vulnerable suspects, accused persons and requested persons are taken into account 
% in the implementation of this Directive.
auxiliary_right_scope(art9, [art4, art5, art5_3]).

auxiliary_right(art9, PersonId, assistance, vulnerablePersons):-
    person_condition(PersonId, hearingSpeechImpediments).