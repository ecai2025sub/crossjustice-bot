:- module(directive_2012_13, [has_right/5, auxiliary_right/5, auxiliary_right_checked/5, right_property/5, right_property_checked/5, explain/2]).

:- include('./../../utils.pl').

has_right(Right, dir, Article, PersonId, Matter) :-
    once(directive_2012_13_applies(PersonId)),
    has_right(Article, PersonId, Right, Matter).

directive_2012_13_applies(PersonId) :-
    directive_2012_13_applies(_, PersonId, proceedingData),
    directive_2012_13_applies(_, PersonId, personalData).

%% directive_2012_13_applies(_article1, PersonId, _proceedingData)
%
% Subject matter
%
% This Directive lays down rules concerning the right to information of suspects or accused persons, relating to their rights
% in criminal proceedings and to the accusation against them.
% It also lays down rules concerning the right to information of persons subject to a European Arrest Warrant relating to their rights.

directive_2012_13_applies(art1, PersonId, proceedingData) :-
    proceeding_type(PersonId, criminal),
    (   person_status(PersonId, suspect)
    ;   person_status(PersonId, accused)
    ).

directive_2012_13_applies(art1, PersonId, proceedingData):-
    person_status(PersonId, requested),
    proceeding_type(PersonId, europeanArrestWarrant).

%% directive_2012_13_applies(_article2, PersonId, _personalData)
%
% Scope
%
% 1. This Directive applies from the time persons are made aware by the competent authorities of a Member State that they are suspected
% or accused of having committed a criminal offence until the conclusion of the proceedings, which is understood to mean the final
% determination of the question whether the suspect or accused person has committed the criminal offence, including, where applicable,
% sentencing and the resolution of any appeal.
directive_2012_13_applies(art2_1, PersonId, personalData) :-
    (   person_status(PersonId, suspect)
    ;   person_status(PersonId, accused)
    ;   person_status(PersonId, requested)
    ),
    person_made_aware(PersonId, personStatus),
    proceeding_status(PersonId, started),
    \+ proceeding_status(PersonId, concluded).


%% directive_2012_13_applies(_article1, PersonId, _proceedingData)
%
% 2. Where the law of a Member State provides for the imposition of a sanction regarding minor offences by an authority other than a court
% having jurisdiction in criminal matters, and the imposition of such a sanction may be appealed to such a court, this Directive shall apply
% only to the proceedings before that court, following such an appeal.
directive_2012_13_applies(art2_2, PersonId, proceedingData) :-
    proceeding_matter(PersonId, minor_offence).

%% has_right(_art3_1_a, PersonId, _right_to_information, _access_lawyer)
%
% Article 3
%
% Right to information about rights
% 1. Member States shall ensure that suspects or accused persons are provided promptly with information concerning at least the following
% procedural rights, as they apply under national law, in order to allow for those rights to be exercised effectively:
% (a) the right of access to a lawyer;
has_right(art3_1_a, PersonId, right_to_information, access_lawyer) :-
    (   person_status(PersonId, suspect)
    ;   person_status(PersonId, accused)
    ).

%% has_right(_art3_1_b, PersonId, _right_to_information, _free_legal_advice)
%
% Article 3
%
% Right to information about rights
% 1. Member States shall ensure that suspects or accused persons are provided promptly with information concerning at least the following
% procedural rights, as they apply under national law, in order to allow for those rights to be exercised effectively:
% (b) any entitlement to free legal advice and the conditions for obtaining such advice;
has_right(art3_1_b, PersonId, right_to_information, free_legal_advice) :-
    (   person_status(PersonId, suspect)
    ;   person_status(PersonId, accused)
    ).

%% has_right(_art3_1_c, PersonId, _right_to_information, _accusation)
%
% Article 3
%
% Right to information about rights
% 1. Member States shall ensure that suspects or accused persons are provided promptly with information concerning at least the following
% procedural rights, as they apply under national law, in order to allow for those rights to be exercised effectively:
% (c) the right to be informed of the accusation, in accordance with Article 6;
has_right(art3_1_c, PersonId, right_to_information, accusation) :-
    (   person_status(PersonId, suspect)
    ;   person_status(PersonId, accused)
    ).

%% has_right(_art3_1_d, PersonId, _right_to_information, _interpretation)
%
% Article 3
%
% Right to information about rights
% 1. Member States shall ensure that suspects or accused persons are provided promptly with information concerning at least the following
% procedural rights, as they apply under national law, in order to allow for those rights to be exercised effectively:
% (d) the right to interpretation and translation;
has_right(art3_1_d, PersonId, right_to_information, interpretation) :-
    (   person_status(PersonId, suspect)
    ;   person_status(PersonId, accused)
    ).

%% has_right(_art3_1_d, PersonId, _right_to_information, _translation)
%
% Article 3
%
% Right to information about rights
% 1. Member States shall ensure that suspects or accused persons are provided promptly with information concerning at least the following
% procedural rights, as they apply under national law, in order to allow for those rights to be exercised effectively:
% (d) the right to interpretation and translation;
has_right(art3_1_d, PersonId, right_to_information, translation) :-
    (   person_status(PersonId, suspect)
    ;   person_status(PersonId, accused)
    ).

%% has_right(_art3_1_e, PersonId, _right_to_information, _remain_silent)
%
% Article 3
%
% Right to information about rights
% 1. Member States shall ensure that suspects or accused persons are provided promptly with information concerning at least the following
% procedural rights, as they apply under national law, in order to allow for those rights to be exercised effectively:
% (e) the right to remain silent.
has_right(art3_1_e, PersonId, right_to_information, remain_silent) :-
    (   person_status(PersonId, suspect)
    ;   person_status(PersonId, accused)
    ).

%% auxiliary_right(_art3_2, PersonId, _form, _written)
%
% Article 3.2
%
% 2. Member States shall ensure that the information provided for under paragraph 1 shall be given orally or in writing,
% in simple and accessible language, taking into account any particular needs of vulnerable suspects or vulnerable accused persons.

auxiliary_right_scope(art3_2, [art3_1_a, art3_1_b, art3_1_c, art3_1_d, art3_1_e]).

auxiliary_right(art3_2, PersonId, form, written).

%% auxiliary_right(_art3_2, PersonId, _form, _oral)
%
% Article 3.2
%
% 2. Member States shall ensure that the information provided for under paragraph 1 shall be given orally or in writing,
% in simple and accessible language, taking into account any particular needs of vulnerable suspects or vulnerable accused persons.
auxiliary_right(art3_2, PersonId, form, oral).

%% auxiliary_right(_art3_2, PersonId, _language, _simple)
%
% Article 3.2
%
% 2. Member States shall ensure that the information provided for under paragraph 1 shall be given orally or in writing,
% in simple and accessible language, taking into account any particular needs of vulnerable suspects or vulnerable accused persons.
auxiliary_right(art3_2, PersonId, language, simple).

%% auxiliary_right(_art3_2, PersonId, _language, _accessible)
%
% Article 3.2
%
% 2. Member States shall ensure that the information provided for under paragraph 1 shall be given orally or in writing,
% in simple and accessible language, taking into account any particular needs of vulnerable suspects or vulnerable accused persons.
auxiliary_right(art3_2, PersonId, language, accessible).

%% auxiliary_right(_art3_2, PersonId, _assistance, _vulnerable)
%
% Article 3.2
%
% 2. Member States shall ensure that the information provided for under paragraph 1 shall be given orally or in writing,
% in simple and accessible language, taking into account any particular needs of vulnerable suspects or vulnerable accused persons.
auxiliary_right(art3_2, PersonId, assistance, vulnerable).

%% has_right(_art4, PersonId, _right_to_information, _letter_of_rights)
%
% Article 4.1
%
% 1. Member States shall ensure that suspects or accused persons who are arrested or detained are provided
% promptly with a written Letter of Rights.
has_right(art4, PersonId, right_to_information, letter_of_rights) :-
    (   person_status(PersonId, suspect)
    ;   person_status(PersonId, accused)
    ),
    (   person_status(PersonId, arrested)
    ;   person_status(PersonId, detained)
    ).

%% auxiliary_right(_art4_1, PersonId, _possession, _letter_of_rights)
%
% Article 4.1
%
% They shall be given an opportunity to read the Letter of Rights and shall be allowed to keep it in their possession
% throughout the time that they are deprived of liberty.

auxiliary_right_scope(art4_1, [art4]).

auxiliary_right(art4_1, PersonId, possession, letter_of_rights) :-
    person_status(PersonId, deprived_of_liberty).

%% auxiliary_right(_art4_2, PersonId, _letter_of_rights, _access_materials)
%
% Article 4.2.a
%
% 2. In addition to the information set out in Article 3, the Letter of Rights referred to in paragraph 1 of this
% Article shall contain information about the following rights as they apply under national law:
% (a) the right of access to the materials of the case;

auxiliary_right_scope(art4_2, [art4]).

auxiliary_right(art4_2, PersonId, letter_of_rights, access_materials).

%% auxiliary_right(_art4_2, PersonId, _letter_of_rights, _inform_consul)
%
% Article 4.2.b
%
% 2. In addition to the information set out in Article 3, the Letter of Rights referred to in paragraph 1 of this
% Article shall contain information about the following rights as they apply under national law:
% (b) the right to have consular authorities and one person informed;
auxiliary_right(art4_2, PersonId, letter_of_rights, inform_consul).

%% auxiliary_right(_art4_2, PersonId, _letter_of_rights, _inform_person)
%
% Article 4.2.b
%
% 2. In addition to the information set out in Article 3, the Letter of Rights referred to in paragraph 1 of this
% Article shall contain information about the following rights as they apply under national law:
% (b) the right to have consular authorities and one person informed;
auxiliary_right(art4_2, PersonId, letter_of_rights, inform_person).

%% auxiliary_right(_art4_2, PersonId, _letter_of_rights, _medical_assistance)
%
% Article 4.2.c
%
% 2. In addition to the information set out in Article 3, the Letter of Rights referred to in paragraph 1 of this
% Article shall contain information about the following rights as they apply under national law:
% (c) the right of access to urgent medical assistance; and
auxiliary_right(art4_2, PersonId, letter_of_rights, medical_assistance).

%% auxiliary_right(_art4_2, PersonId, _letter_of_rights, _limitation_to_deprivation_of_liberty)
%
% Article 4.2.d
%
% 2. In addition to the information set out in Article 3, the Letter of Rights referred to in paragraph 1 of this
% Article shall contain information about the following rights as they apply under national law:
% (d) the maximum number of hours or days suspects or accused persons
% may be deprived of liberty before being brought before a judicial authority.
auxiliary_right(art4_2, PersonId, letter_of_rights, limitation_to_deprivation_of_liberty).

%% auxiliary_right(_art4_3, PersonId, _letter_of_rights, _challenge_arrest)
%
% Article 4.3
%
% 3. The Letter of Rights shall also contain basic information about any possibility,
% under national law, of challenging the lawfulness of the arrest; obtaining a review of the detention;
% or making a request for provisional release.

auxiliary_right_scope(art4_3, [art4]).

auxiliary_right(art4_3, PersonId, letter_of_rights, challenge_arrest).

%% auxiliary_right(_art4_3, PersonId, _letter_of_rights, _review_detention)
%
% Article 4.3
%
% 3. The Letter of Rights shall also contain basic information about any possibility,
% under national law, of challenging the lawfulness of the arrest; obtaining a review of the detention;
% or making a request for provisional release.
auxiliary_right(art4_3, PersonId, letter_of_rights, review_detention).

%% auxiliary_right(_art4_3, PersonId, _letter_of_rights, _request_provisional_release)
%
% Article 4.3
%
% 3. The Letter of Rights shall also contain basic information about any possibility,
% under national law, of challenging the lawfulness of the arrest; obtaining a review of the detention;
% or making a request for provisional release.
auxiliary_right(art4_3, PersonId, letter_of_rights, request_provisional_release).

%% auxiliary_right(_art4_4, PersonId, _letter_of_rights, _simple_and_accessible_language)
%
% Article 4.4
%
% 4. The Letter of Rights shall be drafted in simple and accessible language.
% An indicative model Letter of Rights is set out in Annex I.

auxiliary_right_scope(art4_4, [art4]).

auxiliary_right(art4_4, PersonId, letter_of_rights, simple_and_accessible_language).

%% auxiliary_right(_art4_4, PersonId, _letter_of_rights, _understandable_language)
%
% Article 4.5
%
% 5. Member States shall ensure that suspects or accused persons receive the Letter of Rights written in a
% language that they understand.
% Where a Letter of Rights is not available in the appropriate language, suspects or accused persons shall
% be informed of their rights orally in a language that they understand.
% A Letter of Rights in a language that they understand shall then be given to them without undue delay.

auxiliary_right_scope(art4_5, [art4]).

auxiliary_right(art4_5, PersonId, letter_of_rights, understandable_language).

% TODO - Is this a main right or an auxiliary one?

%% has_right(_art5_1, PersonId, _right_to_information, _letter_of_rights)
%
% Article 5.1
%
% Letter of Rights in European Arrest Warrant proceedings
% 1. Member States shall ensure that persons who are arrested for the purpose of the execution of a European
% Arrest Warrant are provided promptly with an appropriate Letter of Rights containing information on their rights
% according to the law implementing Framework Decision 2002/584/JHA in the executing Member State.
has_right(art5_1, PersonId, right_to_information, letter_of_rights):-
    person_status(PersonId, arrested),
    proceeding_type(PersonId, europeanArrestWarrant).

%% auxiliary_right(_art5_2, PersonId, _letter_of_rights, _simple_and_accessible_language)
%
% Article 5.2
%
% 2. The Letter of Rights shall be drafted in simple and accessible language.
% An indicative model Letter of Rights is set out in Annex II.

auxiliary_right_scope(art5_2, [art5_1]).

auxiliary_right(art5_2, PersonId, letter_of_rights, simple_and_accessible_language).

%% has_right(_art6_1, PersonId, _right_to_information, _accusation)
%
% Article 6.1
%
% Right to information about the accusation
% 1. Member States shall ensure that suspects or accused persons are provided with information about the criminal act
% they are suspected or accused of having committed.
% That information shall be provided promptly and in such detail as is necessary to safeguard the fairness of the
% proceedings and the effective exercise of the rights of the defence.
has_right(art6_1, PersonId, right_to_information, accusation) :-
    (   person_status(PersonId, suspect)
    ;   person_status(PersonId, accused)
    ).

%% has_right(_art6_2, PersonId, _right_to_information, _accusation)
%
% Article 6.2
%
% 2. Member States shall ensure that suspects or accused persons who are arrested or detained are informed of the
% reasons for their arrest or detention, including the criminal act they are suspected or accused of having committed.
has_right(art6_2, PersonId, right_to_information, accusation) :-
    (   person_status(PersonId, suspect)
    ;   person_status(PersonId, accused)
    ),
    (   person_status(PersonId, arrested)
    ;   person_status(PersonId, detained)
    ).

%% auxiliary_right(_art6_3, PersonId, _accusation, _details)
%
% Article 6.3
%
% 3. Member States shall ensure that, at the latest on submission of the merits of the accusation to a court,
% detailed information is provided on the accusation, including the nature and legal classification of the criminal
% offence, as well as the nature of participation by the accused person.

auxiliary_right_scope(art6_3, [art6_1, art6_2]).

auxiliary_right(art6_3, PersonId, accusation, details) :-
    person_status(PersonId, accused).

%% auxiliary_right(_art6_4, PersonId, _accusation, _changes)
%
% Article 6.4
%
% 4. Member States shall ensure that suspects or accused persons are informed promptly of any changes in the information
% given in accordance with this Article where this is necessary to safeguard the fairness of the proceedings.

auxiliary_right_scope(art6_4, [art6_1, art6_2]).

auxiliary_right(art6_4, PersonId, accusation, changes) :-
    proceeding_matter(PersonId, elements_changed).

%% has_right(_art7_1, PersonId, _right_to_access_materials, _trial)
%
% Article 7.1
%
% Right of access to the materials of the case
% 1. Where a person is arrested and detained at any stage of the criminal proceedings, Member States shall ensure that
% documents related to the specific case in the possession of the competent authorities which are essential to challenging
% effectively, in accordance with national law, the lawfulness of the arrest or detention, are made available to arrested
% persons or to their lawyers.
has_right(art7_1, PersonId, right_to_access_materials, trial) :-
    (   person_status(PersonId, arrested)
    ;   person_status(PersonId, detained)
    ),
    person_document(art7_1, PersonId, documents).

person_document(art7_1, PersonId, documents) :-
    (   person_document(PersonId, challenge_arrest)
    ;   person_document(PersonId, challenge_detention)
    ).

%  custom document article
person_document(art7_1, PersonId, documents) :-
    authority_decision(PersonId, essential_document).

% 2. Member States shall ensure that access is granted at least to all material evidence in the possession
% of the competent authorities, whether for or against suspects or accused persons, to those persons or their lawyers
% in order to safeguard the fairness of the proceedings and to prepare the defence.
%TODO: è una lista di esempi?

%% has_right(_art7_3, PersonId, _right_to_access_materials, _trial)
%
% Article 7.3
%
% 3. Without prejudice to paragraph 1, access to the materials referred to in paragraph 2 shall be granted in due time
% to allow the effective exercise of the rights of the defence and at the latest upon submission of the merits of the
% accusation to the judgment of a court. Where further material evidence comes into the possession of the competent
% authorities, access shall be granted to it in due time to allow for it to be considered.
has_right(art7_3, PersonId, right_to_access_materials, trial) :-
    person_document(PersonId, new_evidence),
    \+ exception(has_right(art7_3, PersonId, right_to_access_materials, trial), _).

%% exception(_has_right(_art7_3, PersonId, _right_to_access_materials, _trial), _art7_4)
%
% Article 7.4
%
% 4. By way of derogation from paragraphs 2 and 3, provided that this does not prejudice the right to a fair trial,
% access to certain materials may be refused if such access may lead to a serious threat to the life or the fundamental
% rights of another person or if such refusal is strictly necessary to safeguard an important public interest, such as
% in cases where access could prejudice an ongoing investigation or seriously harm the national security of the
% Member State in which the criminal proceedings are instituted.
% Member States shall ensure that, in accordance with procedures in national law, a decision to refuse access to certain
% materials in accordance with this paragraph is taken by a judicial authority or is at least subject to judicial review.
exception(has_right(art7_3, PersonId, right_to_access_materials, trial), art7_4) :-
    (   person_danger(PersonId, life)
    ;   person_danger(PersonId, fundamental_rights)
    ;   person_danger(PersonId, public_interest)
    ),
    \+ proceeding_event(PersonId, prejudice).

%% auxiliary_right(_art7_5, PersonId, _cost, _free)
%
% Article 7.5
%
% 5. Access, as referred to in this Article, shall be provided free of charge.

auxiliary_right_scope(art7_5, [art7_1, art7_3]).

auxiliary_right(art7_5, PersonId, cost, free).

%% auxiliary_right(_art8_1, PersonId, _record, _information)
%
% Article 8.1
%
% Verification and remedies
% 1. Member States shall ensure that when information is provided to suspects or accused persons in accordance with
% Articles 3 to 6 this is noted using the recording procedure specified in the law of the Member State concerned.

auxiliary_right_scope(art8_1, [art3_1_a, art3_1_b, art3_1_c, art3_1_d, art3_1_e, art4, art5_1, art6_1, art6_2]).

auxiliary_right(art8_1, PersonId, record, information).

%% auxiliary_right(_art8_2, PersonId, _remedy, _right_to_information_breach)
%
% Article 8.2
%
% 2. Member States shall ensure that suspects or accused persons or their lawyers have the right to challenge,
% in accordance with procedures in national law, the possible failure or refusal of the competent authorities to
% provide information in accordance with this Directive.

auxiliary_right_scope(art8_2, [art3_1_a, art3_1_b, art3_1_c, art3_1_d, art3_1_e, art4, art5_1, art6_1, art6_2]).

auxiliary_right(art8_2, PersonId, remedy, right_to_information_breach).