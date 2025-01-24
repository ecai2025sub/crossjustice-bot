:- module(directive_2016_343, [has_right/5, auxiliary_right/5, auxiliary_right_checked/5, right_property/5, right_property_checked/5, explain/2]).

:- include('./../../utils.pl').

has_right(Right, dir, Article, PersonId, Matter) :-
    once(directive_2016_343_applies(PersonId)),
    has_right(Article, PersonId, Right, Matter).

% Article 1
% Subject matter
% This Directive lays down common minimum rules concerning:
% (a) certain aspects of the presumption of innocence in criminal proceedings;
% (b) the right to be present at the trial in criminal proceedings.

%% directive_2016_343_applies(PersonId)
%
% Article 2
%
% Scope
% This Directive applies to natural persons who are suspects or accused persons in criminal proceedings.
% It applies at all stages of the criminal proceedings, from the moment when a person is suspected or accused of having
% committed a criminal offence, or an alleged criminal offence, until the decision on the final determination of whether
% that person has committed the criminal offence concerned has become definitive.
directive_2016_343_applies(PersonId) :-
    (   person_status(PersonId, suspect)
    ;   person_status(PersonId, accused)
    ),
    person_made_aware(PersonId, personStatus),
    proceeding_status(PersonId, started),
    \+ proceeding_status(PersonId, concluded).

%% has_right(_art3, PersonId, _right_to_be_presumed_innocent, _until_guilty)
%
% Article 3
%
% Presumption of innocence
% Member States shall ensure that suspects and accused persons are presumed innocent until proved guilty according to law.
has_right(art3, PersonId, right_to_be_presumed_innocent, until_guilty) :-
    (   person_status(PersonId, suspect)
    ;   person_status(PersonId, accused)
    ).

%% has_right(_art4_1, PersonId, _right_to_be_presumed_innocent, _statement_guilt)
%
% Article 4
%
% Public references to guilt
% 1. Member States shall take the necessary measures to ensure that, for as long as a suspect or an accused person has not
% been proved guilty according to law, public statements made by public authorities, and judicial decisions, other than those
% on guilt, do not refer to that person as being guilty. This shall be without prejudice to acts of the prosecution which aim
% to prove the guilt of the suspect or accused person, and to preliminary decisions of a procedural nature, which are taken by
% judicial or other competent authorities and which are based on suspicion or incriminating evidence.
has_right(art4_1, PersonId, right_to_be_presumed_innocent, statement_public_authority) :-
    (   person_status(PersonId, suspect)
    ;   person_status(PersonId, accused)
    ),
    \+ exception(has_right(art4_1, PersonId, right_to_be_presumed_innocent, proceeding), _).

%% auxiliary_right(_art4_2, PersonId, _remedy, _obligation_breach)
%
% Article 4.2
%
% Member States shall ensure that appropriate measures are available in the event of a breach of the obligation laid
% down in paragraph 1 of this Article not to refer to suspects or accused persons as being guilty, in accordance with this
% Directive and, in particular, with Article 10.
auxiliary_right_scope(art4_2, [art4_1]).

auxiliary_right(art4_2, PersonId, remedy, obligation_breach) :-
    proceeding_matter(PersonId, breach_of_rights).

%% exception(_has_right(_art4_1, PersonId, _right_to_be_presumed_innocent, _proceeding), _art4_3)
%
% Article4.3
%
% The obligation laid down in paragraph 1 not to refer to suspects or accused persons as being guilty shall not prevent
% public authorities from publicly disseminating information on the criminal proceedings where strictly necessary for reasons
% relating to the criminal investigation or to the public interest.
exception(has_right(art4_1, PersonId, right_to_be_presumed_innocent, proceeding), art4_3) :-
    proceeding_danger(PersonId, investigation);
    proceeding_danger(PersonId, public_interest).

%% right_property(_art5_1, PersonId, _presentation, _not_physical_restraint)
%
% Article 5
%
% Presentation of suspects and accused persons
% 1. Member States shall take appropriate measures to ensure that suspects and accused persons are not presented as being guilty,
% in court or in public, through the use of measures of physical restraint.
% 2. Paragraph 1 shall not prevent Member States from applying measures of physical restraint that are required for
% case-specific reasons, relating to security or to the prevention of suspects or accused persons from absconding or
% from having contact with third persons.
right_property_scope(art5_1, [art3, art4_1]).

right_property(art5_1, PersonId, presentation, not_physical_restraint) :-
    \+ exception(right_property(art5_1, PersonId, presentation, not_physical_restraint), _).

exception(right_property(art5_1, PersonId, presentation, not_physical_restraint), _) :-
    person_danger(PersonId, security_reasons);
    person_danger(PersonId, prevent_contact_third_parties).

%% right_property(_art6_1, PersonId, _burden_of_proof, _)
%
% Article 6
%
% Burden of proof
% 1. Member States shall ensure that the burden of proof for establishing the guilt of suspects and accused persons is on the
% prosecution. This shall be without prejudice to any obligation on the judge or the competent court to seek both inculpatory and
% exculpatory evidence, and to the right of the defence to submit evidence in accordance with the applicable national law.
% 2. Member States shall ensure that any doubt as to the question of guilt is to benefit the suspect or accused person, including
% where the court assesses whether the person concerned should be acquitted.
right_property_scope(art6_1, [art3, art4_1]).

right_property(art6_1, PersonId, burden_of_proof, prosecution).

right_property_scope(art6_2, [art3, art4_1]).

right_property(art6_2, PersonId, burden_of_proof, benefit_person).

%% has_right(_art7_1, PersonId, _right_to_remain_silent, _proceeding)
%
% Article 7
%
% Right to remain silent and right not to incriminate oneself
% 1. Member States shall ensure that suspects and accused persons have the right to remain silent in relation to the
% criminal offence that they are suspected or accused of having committed.
has_right(art7_1, PersonId, right_to_remain_silent, proceeding) :-
    (   person_status(PersonId, suspect)
    ;   person_status(PersonId, accused)
    ).

%% has_right(_art7_2, PersonId, _right_to_not_incriminate_themselves, _proceeding)
%
% Article 7.2
%
% Member States shall ensure that suspects and accused persons have the right not to incriminate themselves.
has_right(art7_2, PersonId, right_to_not_incriminate_themselves, proceeding) :-
    (   person_status(PersonId, suspect)
    ;   person_status(PersonId, accused)
    ),
    \+ exception(has_right(art7_2, PersonId, right_to_not_incriminate_themselves, proceeding), _).

%% exception(_has_right(_art7_2, PersonId, _right_to_not_incriminate_themselves, _proceeding), _)
%
% Article 7.3
%
% The exercise of the right not to incriminate oneself shall not prevent the competent authorities from gathering
% evidence which may be lawfully obtained through the use of legal powers of compulsion and which has an existence independent
% of the will of the suspects or accused persons.
exception(has_right(art7_2, PersonId, right_to_not_incriminate_themselves, proceeding), _) :-
    proceeding_matter(PersonId, evidence_gathering_act).

% 4. Member States may allow their judicial authorities to take into account, when sentencing, cooperative behaviour
% of suspects and accused persons.

%% auxiliary_right(_art7_5, PersonId, _exercise_of_right, _not_evidence)
%
% Article 7.5
%
% The exercise by suspects and accused persons of the right to remain silent or of the right not to incriminate oneself
% shall not be used against them and shall not be considered to be evidence that they have committed the criminal offence concerned.
auxiliary_right_scope(art7_5, [art7_1, art7_2]).

auxiliary_right(art7_5, PersonId, exercise_of_right, not_evidence).

% 6. This Article shall not preclude Member States from deciding that, with regard to minor offences, the conduct of the
% proceedings, or certain stages thereof, may take place in writing or without questioning of the suspect or accused person
% by the competent authorities in relation to tehe offence concerned, providd that this complies with the right to a fair trial.

% TODO - Right to fair trial IF minor offence and no questioning? similar to 8_6

%% has_right(_art8_1, PersonId, _right_to_be_present, _trial)
%
% Article 8
%
% Right to be present at the trial
% 1. Member States shall ensure that suspects and accused persons have the right to be present at their trial.
has_right(art8_1, PersonId, right_to_be_present, trial) :-
    (   person_status(PersonId, suspect)
    ;   person_status(PersonId, accused)
    ),
    \+ exception(has_right(art8_1, PersonId, right_to_be_present, trial), _).

%% auxiliary_right(_art8_2, PersonId, _right_to_be_absent, _trial_in_absentia)
%
% Article 8.2-5
%
% Member States may provide that a trial which can result in a decision on the guilt or innocence of a suspect or 
% accused person can be held in his or her absence, provided that:
% (a) the suspect or accused person has been informed, in due time, of the trial and of the consequences of non-appearance; or
% (b) the suspect or accused person, having been informed of the trial, is represented by a mandated lawyer, who was 
% appointed either by the suspect or accused person or by the State.
% 3. A decision which has been taken in accordance with paragraph 2 may be enforced against the person concerned.
% 5. This Article shall be without prejudice to national rules that provide that the judge or the competent court can 
% exclude a suspect or accused person temporarily from the trial where necessary in the interests of securing the proper 
% conduct of the criminal proceedings, provided that the rights of the defence are complied with.
auxiliary_right_scope(art8_2, [art8_1]).

auxiliary_right(art8_2, PersonId, right_to_be_absent, trial_in_absentia) :-
    (   person_status(PersonId, suspect)
    ;   person_status(PersonId, accused)
    ),
    person_event(PersonId, informed_consequences_absence).

auxiliary_right(art8_2, PersonId, right_to_be_absent, trial_in_absentia) :-
    (   person_status(PersonId, suspect)
    ;   person_status(PersonId, accused)
    ),
    person_event(PersonId, represented_by_lawyer).

exception(has_right(art8_1, PersonId, right_to_be_present, trial), art8_4) :-
    person_event(PersonId, cannot_be_located).

exception(has_right(art8_1, PersonId, right_to_be_present, trial), art8_5) :-
    person_danger(PersonId, proper_conduct_proceedings).

%% auxiliary_right(_art8_4, _PersonId, _remedy, _)
%
% Article 8.4
%
% Where Member States provide for the possibility of holding trials in the absence of suspects or accused persons 
% but it is not possible to comply with the conditions laid down in paragraph 2 of this Article because a suspect or 
% accused person cannot be located despite reasonable efforts having been made, Member States may provide that a decision 
% can nevertheless be taken and enforced. In that case, Member States shall ensure that when suspects or accused persons 
% are informed of the decision, in particular when they are apprehended, they are also informed of the possibility to 
% challenge the decision and of the right to a new trial or to another legal remedy, in accordance with Article 9.
auxiliary_right_scope(art8_4, [art8_1]).

auxiliary_right(art8_4, PersonId, remedy, challenge_decision) :-
    exception(has_right(art8_1, PersonId, right_to_be_present, trial), art8_4).

auxiliary_right(art8_4, PersonId, remedy, new_trial) :-
    exception(has_right(art8_1, PersonId, right_to_be_present, trial), art8_4).

% 6. This Article shall be without prejudice to national rules that provide for proceedings or certain stages thereof to 
% be conducted in writing, provided that this complies with the right to a fair trial.

%% auxiliary_right(_art9, PersonId, _remedy, _new_trial)
%
% Article 9
%
% Right to a new trial
% Member States shall ensure that, where suspects or accused persons were not present at their trial and the conditions 
% laid down in Article 8(2) were not met, they have the right to a new trial, or to another legal remedy, which allows a 
% fresh determination of the merits of the case, including examination of new evidence, and which may lead to the original 
% decision being reversed. In that regard, Member States shall ensure that those suspects and accused persons have the 
% right to be present, to participate effectively, in accordance with procedures under national law, and to exercise the 
% rights of the defence.
auxiliary_right_scope(art9, [art8_1]).

auxiliary_right(art9, PersonId, remedy, new_trial) :-
    auxiliary_right(art8_2, PersonId, right_to_be_absent, trial_in_absentia).

%% auxiliary_right(_art10_1, PersonId, _remedy, _breach_of_rights)
%
% Article 10
% 
% Remedies
% 1. Member States shall ensure that suspects and accused persons have an effective remedy if their rights under 
% this Directive are breached.
% 2. Without prejudice to national rules and systems on the admissibility of evidence, Member States shall ensure that, 
% in the assessment of statements made by suspects or accused persons or of evidence obtained in breach of the right 
% to remain silent or the right not to incriminate oneself, the rights of the defence and the fairness of the proceedings are respected.
auxiliary_right_scope(art10_1, [art3, art4_1, art7_1, art7_2, art8_1]).

auxiliary_right(art10_1, PersonId, remedy, breach_of_rights) :-
    proceeding_matter(PersonId, breach_of_rights).

%auxiliary_right_scope(art10_2, [art3, art4_1, art7_1, art7_2, art8_1]).

%auxiliary_right(art10_2, PersonId, right_to_respect, fairness_proceedings).
