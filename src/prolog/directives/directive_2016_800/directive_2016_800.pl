:- module(directive_2016_800, [has_right/5, auxiliary_right/5, auxiliary_right_checked/5, right_property/5, right_property_checked/5, explain/2]).

:- include('./../../utils.pl').

has_right(Right, dir, Article, PersonId, Matter) :-
    once(directive_2016_800_applies(PersonId)),
    person_status(PersonId, child),
    has_right(Article, PersonId, Right, Matter).

%article outside directive
person_status(PersonId, deprived_of_liberty):-
    person_status(PersonId, requested).

%% directive_2016_800_applies(PersonId)
%
% Article 1
% Subject matter
%
% This Directive lays down common minimum rules concerning certain rights of children who are:
% (a)suspects or accused persons in criminal proceedings; or
% (b)subject to European arrest warrant proceedings pursuant to Framework Decision 2002/584/JHA (requested persons).
directive_2016_800_applies(PersonId):-
    directive_2016_800_applies(article2_1, PersonId);
    directive_2016_800_applies(article2_2, PersonId);
    directive_2016_800_applies(article2_3, PersonId);
    directive_2016_800_applies(article2_4, PersonId);
    directive_2016_800_applies(article2_6, PersonId).

%% directive_2016_800_applies(_article2, PersonId)
%
% Article 2
% Scope
%
% 1. This Directive applies to children who are suspects or accused persons in criminal proceedings.
% It applies until the final determination of the question whether the suspect or accused person has
% committed a criminal offence, including, where applicable, sentencing and the resolution of any appeal.
%2. This Directive applies to children who are requested persons from the time of their arrest in the executing Member State,
%in accordance with Article 17.
%3. With the exception of Article 5, point (b) of Article 8(3), and Article 15, insofar as those provisions
%refer to a holder of parental responsibility, this Directive, or certain provisions thereof, applies to persons
%as referred to in paragraphs 1 and 2 of this Article, where such persons were children when they became subject
%to the proceedings but have subsequently reached the age of 18, and the application of this Directive, or certain
%provisions thereof, is appropriate in the light of all the circumstances of the case, including the maturity and
%vulnerability of the person concerned.
%Member States may decide not to apply this Directive when the person concerned has reached the age of 21.
%In any event, this Directive shall fully apply where the child is deprived of liberty, irrespective of the stage
%of the criminal proceedings.
directive_2016_800_applies(article2_1, PersonId):-
    (   person_status(PersonId, suspect)
    ;   person_status(PersonId, accused)
    ),
    person_status(PersonId, child),
    proceeding_type(PersonId, criminal),
    proceeding_status(PersonId, started),
    \+ proceeding_status(PersonId, concluded).

proceeding_status(PersonId, concluded):-
    person_document(PersonId, judgement);
    person_document(PersonId, appeal_resolution).

directive_2016_800_applies(article2_2, PersonId):-
    person_status(PersonId, requested),
    person_status(PersonId, child),
    proceeding_type(PersonId, europeanArrestWarrant).

directive_2016_800_applies(article2_3, PersonId):-
    person_status(PersonId, subject_to_proceedings),
    person_age(PersonId, Age, start_proceeding),
    Age < 18,
    person_age(PersonId, Age2),
    Age2 >= 18,
    directive_application_appropriate(PersonId),
    \+ exception(directive_2016_800_applies(article2_3, PersonId), _).

exception(directive_2016_800_applies(article2_3, PersonId), directive_2016_800_applies(article2_3, PersonId)):-
    person_age(PersonId, Age),
    Age >= 21,
    member_states_decision(PersonId, directive_2016_800_does_not_apply).

directive_2016_800_applies(article2_6, PersonId):-
    person_status(PersonId, child),
    person_status(PersonId, deprived_of_liberty).

% 4. This Directive applies to children who were not initially suspects or accused persons but become suspects
%or accused persons in the course of questioning by the police or by another law enforcement authority.
directive_2016_800_applies(article2_4, PersonId):-
    person_status(PersonId, raise_suspicion),
    proceeding_matter(PersonId, questioning).

%5. This Directive does not affect national rules determining the age of criminal responsibility.

%6. Without prejudice to the right to a fair trial, in respect of minor offences:
%(a)where the law of a Member State provides for the imposition of a sanction by an authority other than a court
%having jurisdiction in criminal matters, and the imposition of such a sanction may be appealed or referred to
%such a court; or
%(b)where deprivation of liberty cannot be imposed as a sanction,
%this Directive shall only apply to the proceedings before a court having jurisdiction in criminal matters.

%% person_status(PersonId, _child)
%
% Article 3
% Definitions
%
% For the purposes of this Directive the following definitions apply:
% (1)‘child’ means a person below the age of 18;
% (2)‘holder of parental responsibility’ means any person having parental responsibility over a child;
% (3)‘parental responsibility’ means all rights and duties relating to the person or the property of a child
% which are given to a natural or legal person by judgment, by operation of law or by an agreement having legal effects,
% including rights of custody and rights of access.
% With regard to point (1) of the first paragraph, where it is uncertain whether a person has reached the age of 18,
% that person shall be presumed to be a child.
person_status(PersonId, child):-
    person_age(PersonId, X),
    X < 18.

person_status(PersonId, of_age):-
    person_age(PersonId, X),
    X >= 18.

person_status(PersonId, holder_of_parental_responsibility):-
    holds_parental_responsibility(PersonId, ChildId),
    person_status(ChildId, child).

holds_parental_responsibility(PersonId, ChildId):-
    (   person_nature(PersonId, natural)
    ;   person_nature(PersonId, legal)
    ),
    (   responsibility_assigned(PersonId, ChildId, judgement)
    ;   responsibility_assigned(PersonId, ChildId, operation_of_law)
    ;   responsibility_assigned(PersonId, ChildId, agreement_having_legal_effects)
    ).

person_status(PersonId, child):-
    person_status(PersonId, age_unknown).

%% has_right(_article4, PersonId, _right_to_information, _)
%
% Article 4
% Right to information
%
% 1. Member States shall ensure that when children are made aware that they are suspects or accused persons in criminal proceedings,
% they are informed promptly about their rights in accordance with Directive 2012/13/EU and about general aspects of the conduct
% of the proceedings. Member States shall also ensure that children are informed about the rights set out in this Directive.
% That information shall be provided as follows:
% (a)promptly when children are made aware that they are suspects or accused persons, in respect of:
% (i)the right to have the holder of parental responsibility informed, as provided for in Article 5;
% (ii)the right to be assisted by a lawyer, as provided for in Article 6;
% (iii)the right to protection of privacy, as provided for in Article 14;
% (iv)the right to be accompanied by the holder of parental responsibility during stages of the
% proceedings other than court hearings, as provided for in Article 15(4);
% (v)the right to legal aid, as provided for in Article 18;
% (b)at the earliest appropriate stage in the proceedings, in respect of:
% (i)the right to an individual assessment, as provided for in Article 7;
% (ii)the right to a medical examination, including the right to medical assistance, as provided for in Article 8;
% (iii)the right to limitation of deprivation of liberty and to the use of alternative measures, including the
% right to periodic review of detention, as provided for in Articles 10 and 11;
% (iv)the right to be accompanied by the holder of parental responsibility during court hearings, as provided for in Article 15(1);
% (v)the right to appear in person at trial, as provided for in Article 16;
% (vi)the right to effective remedies, as provided for in Article 19;
% (c)upon deprivation of liberty in respect of the right to specific treatment during deprivation of liberty,
% as provided for in Article 12.
article_4_applies(PersonId):-
    (   person_status(PersonId, suspect)
    ;   person_status(PersonId, accused)
    ).

has_right(article4_a_i, PersonId, right_to_information, inform_holder_of_parental_responsibility):-
    article_4_applies(PersonId),
    person_made_aware(PersonId, personStatus).

has_right(article4_a_ii, PersonId, right_to_information, access_lawyer):-
    article_4_applies(PersonId),
    person_made_aware(PersonId, personStatus).

has_right(article4_a_iii, PersonId, right_to_information, privacy):-
    article_4_applies(PersonId),
    person_made_aware(PersonId, personStatus).

has_right(article4_a_iv, PersonId, right_to_information, accompanied_by_holder_of_parental_responsibility):-
    article_4_applies(PersonId),
    person_made_aware(PersonId, personStatus),
    proceeding_status(PersonId, started),
    \+ proceeding_matter(PersonId, court_hearing).

has_right(article4_a_v, PersonId, right_to_information, legal_aid):-
    article_4_applies(PersonId),
    person_made_aware(PersonId, personStatus).

has_right(article4_b_i, PersonId, right_to_information, individual_assessment):-
    proceeding_status(PersonId, started).

has_right(article4_b_ii, PersonId, right_to_information, medical_examination):-
    proceeding_status(PersonId, started).

has_right(article4_b_iii, PersonId, right_to_information, limitation_to_deprivation_of_liberty):-
    proceeding_status(PersonId, started).

has_right(article4_b_iii, PersonId, right_to_information, use_of_alternative_measures):-
    proceeding_status(PersonId, started).

has_right(article4_b_iv, PersonId, right_to_information, accompanied_by_holder_of_parental_responsibility):-
    proceeding_status(PersonId, started),
    proceeding_matter(PersonId, court_hearing).

has_right(article4_b_v, PersonId, right_to_information, appear_at_trial):-
    proceeding_status(PersonId, started).

has_right(article4_b_vi, PersonId, right_to_information, effective_remedies):-
    proceeding_status(PersonId, started).

has_right(article4_c, PersonId, right_to_information, specific_treatment_deprivation_of_liberty):-
    person_status(PersonId, deprived_of_liberty).

% TODO - at the earliest appropriate stage? Do we WANT to map it? Depends on the desired detail of representation.

%% auxiliary_right(_article4_2, PersonId, _form, _)
%
% Article 4.2-3
%
% 2. Member States shall ensure that the information referred to in paragraph 1 is given in writing, 
% orally, or both, in simple and accessible language, and that the information given is noted, using th
% recording procedure in accordance with national law.
% 3. Where children are provided with a Letter of Rights pursuant to Directive 2012/13/EU, Member States shall
% ensure that such a Letter includes a reference to their rights under this Directive.

auxiliary_right_scope(article4_2, [article4_a_i, article4_a_ii, article4_a_iii, article4_a_iv, article4_a_v, article4_b_i, article4_b_ii, article4_b_iii, article4_b_iv, article4_b_v, article4_b_vi, article5_c]).

auxiliary_right(article4_2, PersonId, form, writing_or_orally).

auxiliary_right(article4_2, PersonId, language, accessible).

auxiliary_right(article4_2, PersonId, record, information).

% auxiliary_right(article4_3, PersonId, letter_of_rights, X):-
    % has_right(_, dir2012_13, PersonId, right_to_information, letter_of_rights),
    % has_right(_, PersonId, right_to_information, X).

%% has_right(_article5_1, PersonId, _right_to_be_informed, HolderId)
%
% Article 5
%
% Right of the child to have the holder of parental responsibility informed
% 1. Member States shall ensure that the holder of parental responsibility is provided, as soon as possible,
% with the information that the child has a right to receive in accordance with Article 4.
% 2. The information referred to in paragraph 1 shall be provided to another appropriate adult who is nominated by the child
% and accepted as such by the competent authority where providing that information to the holder of parental responsibility:
% (a)would be contrary to the child's best interests;
% (b)is not possible because, after reasonable efforts have been made, no holder of parental responsibility can be
% reached or his or her identity is unknown;
% (c)could, on the basis of objective and factual circumstances, substantially jeopardise the criminal proceedings.
% Where the child has not nominated another appropriate adult, or where the adult that has been nominated by the child
% is not acceptable to the competent authority, the competent authority shall, taking into account the child's best interests,
% designate, and provide the information to, another person. That person may also be the representative of an authority or
% of another institution responsible for the protection or welfare of children.
% 3. Where the circumstances which led to the application of point (a), (b) or (c) of paragraph 2 cease to exist,
% any information that the child receives in accordance with Article 4, and which remains relevant in the course of the
% proceedings, shall be provided to the holder of parental responsibility.
has_right(article5_1, PersonId, right_to_be_informed, HolderId):-
    person_status(PersonId, child),
    person_status(HolderId, holder_of_parental_responsibility),
    holds_parental_responsibility(HolderId, PersonId).

has_right(article5_2_a, PersonId, right_to_be_informed, HolderId):-
    holder_nomination(PersonId, HolderId),
    authority_decision(PersonId, accepted),
    person_status(HolderId2, holder_of_parental_responsibility),
    contrary_to_child_interest(HolderId2),
    \+ exception((article5_2_a, HolderId, right_to_be_informed, _), article5_3).

has_right(article5_2_b, PersonId, right_to_be_informed, HolderId):-
    holder_nomination(PersonId, HolderId),
    authority_decision(PersonId, accepted),
    \+ person_status(HolderId2, holder_of_parental_responsibility),
    \+ exception((article5_2_b, PersonId, right_to_be_informed, _), article5_3).

has_right(article5_2_c, PersonId, right_to_be_informed, HolderId):-
    holder_nomination(PersonId, HolderId),
    authority_decision(PersonId, accepted),
    person_status(HolderId2, holder_of_parental_responsibility),
    jeopardises_proceedings(HolderId2),
    \+ exception((article5_2_c, PersonId, right_to_be_informed, _), article5_3).

has_right(article5_2, PersonId, right_to_be_informed, HolderId):-
    authority_decision(HolderId, nomination),
    (   \+ holder_nomination(PersonId, HolderId)
    ;   \+ authority_decision(PersonId, accepted)
    ).

exception(has_right(_, PersonId, right_to_be_informed, HolderId), article5_3):-
    proceeding_status(PersonId, circumstances_cease_to_exist).

% TODO - create a person_status required for applying article17?
% TODO Is this an exception? does this imply all the three previous cases? Is it more/less general?

%% has_right(_article6_1, PersonId, _right_to_access_lawyer, _trial)
%
% Article 6
% Assistance by a lawyer
%
% 1. Children who are suspects or accused persons in criminal proceedings have the right of access to a lawyer in
% accordance with Directive 2013/48/EU. Nothing in this Directive, in particular in this Article, shall affect that right.
% 2. Member States shall ensure that children are assisted by a lawyer in accordance with this Article in order
% to allow them to exercise the rights of the defence effectively.
% 3. Member States shall ensure that children are assisted by a lawyer without undue delay once they are made aware
% that they are suspects or accused persons. In any event, children shall be assisted by a lawyer from whichever of the
% following points in time is the earliest:
% (a)before they are questioned by the police or by another law enforcement or judicial authority;
% (b)upon the carrying out by investigating or other competent authorities of an investigative or other evidence-gathering
% act in accordance with point (c) of paragraph 4;
% (c)without undue delay after deprivation of liberty;
% (d)where they have been summoned to appear before a court having jurisdiction in criminal matters, in due time before
% they appear before that court.
% 4. Assistance by a lawyer shall include the following:
% (a)Member States shall ensure that children have the right to meet in private and communicate with the lawyer representing them,
% including prior to questioning by the police or by another law enforcement or judicial authority;
% (b)Member States shall ensure that children are assisted by a lawyer when they are questioned, and that the lawyer is able to
% participate effectively during questioning. Such participation shall be conducted in accordance with procedures under national law,
% provided that such procedures do not prejudice the effective exercise or essence of the right concerned. Where a lawyer participates
% during questioning, the fact that such participation has taken place shall be noted using the recording procedure under national law;
% (c)Member States shall ensure that children are, as a minimum, assisted by a lawyer during the following investigative or
% evidence-gathering acts, where those acts are provided for under national law and if the suspect or accused person is
% required or permitted to attend the act concerned:
% (i)identity parades;
% (ii)confrontations;
% (iii)reconstructions of the scene of a crime.

article_6_applies(PersonId):-
    (   person_status(PersonId, suspect)
    ;   person_status(PersonId, accused)
    ).

has_right(article6_1, PersonId, right_to_access_lawyer, trial):-
    article_6_applies(PersonId),
    proceeding_type(PersonId, criminal).

has_right(article6_3_a, PersonId, right_to_access_lawyer, questioning):-
    article_6_applies(PersonId),
    person_made_aware(PersonId, personStatus),
    proceeding_matter(PersonId, questioning),
    \+ exception(has_right(article6_3, PersonId, right_to_access_lawyer, _), _).

has_right(article6_3_b, PersonId, right_to_access_lawyer, evidence_gathering_act):-
    article_6_applies(PersonId),
    person_made_aware(PersonId, personStatus),
    proceeding_matter(PersonId, evidence_gathering_act),
    \+ exception(has_right(article6_3, PersonId, right_to_access_lawyer, _), _).

has_right(article6_3_c, PersonId, right_to_access_lawyer, deprivation_of_liberty):-
    article_6_applies(PersonId),
    person_made_aware(PersonId, personStatus),
    proceeding_matter(PersonId, deprivation_of_liberty),
    \+ exception(has_right(article6_3, PersonId, right_to_access_lawyer, _), _).

has_right(article6_3_d, PersonId, right_to_access_lawyer, appearance_in_court):-
    article_6_applies(PersonId),
    person_made_aware(PersonId, personStatus),
    proceeding_type(PersonId, criminal),
    proceeding_matter(PersonId, summoned_court),
    \+ exception(has_right(article6_3, PersonId, right_to_access_lawyer, _), _).

has_right(article6_4_a, PersonId, right_to_access_lawyer, private_communication):-
    article_6_applies(PersonId),
    person_made_aware(PersonId, personStatus).

has_right(article6_4_b, PersonId, right_to_access_lawyer, questioning):-
    article_6_applies(PersonId),
    person_made_aware(PersonId, personStatus),
    proceeding_matter(PersonId, questioning).

proceeding_matter(PersonId, evidence_gathering_act):-
    proceeding_matter(PersonId, identity_parade).

proceeding_matter(PersonId, evidence_gathering_act):-
    proceeding_matter(PersonId, confrontations).

proceeding_matter(PersonId, evidence_gathering_act):-
    proceeding_matter(PersonId, reconstructions_crime_scene).

%% auxiliary_right(_article6_5, PersonId, _privacy, _lawyer_communication)
%
% Article 6.5
%
% Member States shall respect the confidentiality of communication between children and their lawyer in the exercise of the right 
% to be assisted by a lawyer provided for under this Directive. Such communication shall include meetings, correspondence, 
% telephone conversations and other forms of communication permitted under national law.
% 6. Provided that this complies with the right to a fair trial, Member States may derogate from paragraph 3 where assistance 
% by a lawyer is not proportionate in the light of the circumstances of the case, taking into account the seriousness of the 
% alleged criminal offence, the complexity of the case and the measures that could be taken in respect of such an offence, it 
% being understood that the child's best interests shall always be a primary consideration.

auxiliary_right_scope(article6_5, [article6_1, article6_3, article6_3_a, article6_3_b, article6_3_c, article6_3_d, article6_4_a, article6_4_b, article6_6_a, article6_6_b]).

auxiliary_right(article6_5, PersonId, privacy, lawyer_communication).

exception(has_right(article6_3, PersonId, right_to_access_lawyer, _), article6_6Applies(article6_6, PersonId, lawyer_not_appropriate)):-
    assistance_lawyer_not_proportionate(PersonId).

% TODO - How many requisites does this have? Are those elements an open list? Is it a judge's decision?

%% has_right(_article6_6, PersonId, _right_to_access_lawyer, _detention)
%
% Article 6.6
%
% In any event, Member States shall ensure that children are assisted by a lawyer:
% (a)when they are brought before a competent court or judge in order to decide on detention at any stage of the proceedings 
% within the scope of this Directive; and
% (b)during detention.
has_right(article6_6_a, PersonId, right_to_access_lawyer, detention):-
    proceeding_matter(PersonId, summoned_court),
    proceeding_matter(PersonId, detention).

has_right(article6_6_b, PersonId, right_to_access_lawyer, detention):-
    person_status(PersonId, detained).

%Member States shall also ensure that deprivation of liberty is not imposed as a criminal sentence, unless the child has 
%been assisted by a lawyer in such a way as to allow the child to exercise the rights of the defence effectively and, in any 
%event, during the trial hearings before a court.

%% auxiliary_right(_article6_7, PersonId, _arrange_lawyer, _questioning)
%
% Article 6.7
%
% Where the child is to be assisted by a lawyer in accordance with this Article but no lawyer is present, the competent 
% authorities shall postpone the questioning of the child, or other investigative or evidence-gathering acts provided for in 
% point (c) of paragraph 4, for a reasonable period of time in order to allow for the arrival of the lawyer or, where the child 
% has not nominated a lawyer, to arrange a lawyer for the child.

auxiliary_right_scope(article6_7, [article6_1, article6_3, article6_3_a, article6_3_b, article6_3_c, article6_3_d, article6_4_a, article6_4_b, article6_6_a, article6_6_b]).

auxiliary_right(article6_7, PersonId, arrange_lawyer, questioning):-
    proceeding_matter(PersonId, questioning),
    \+ proceeding_event(PersonId, lawyer_present).

%% exception(_has_right(_article6_3, PersonId, _right_to_access_lawyer, Matter), _article6_8Applies(_article6_8_a, PersonId, _))
%
% Article 6.8
%
% In exceptional circumstances, and only at the pre-trial stage, Member States may temporarily derogate from the application 
% of the rights provided for in paragraph 3 to the extent justified in the light of the particular circumstances of the 
% case, on the basis of one of the following compelling reasons:
% (a)where there is an urgent need to avert serious adverse consequences for the life, liberty or physical integrity of a person;
% (b)where immediate action by the investigating authorities is imperative to prevent substantial jeopardy to criminal proceedings 
% in relation to a serious criminal offence.
exception(has_right(article6_3, PersonId, right_to_access_lawyer, Matter), article6_8Applies(article6_8_a, PersonId, _)):-
    (   person_danger(PersonId, life)
    ;   person_danger(PersonId, liberty)
    ;   person_danger(PersonId, physical_integrity)
    ),
    proceeding_matter(PersonId, pre_trial).

exception(has_right(article6_3, PersonId, right_to_access_lawyer, Matter), article6_8Applies(article6_8_b, PersonId, _)):-
    imperative_immediate_action(PersonId, investigating_authority).

% TODO - Does this need to be the same person/child or can it be for someone else?

%Member States shall ensure that the competent authorities, when applying this paragraph, shall take the child's best interests into account.
%A decision to proceed to questioning in the absence of the lawyer under this paragraph may be taken only on a case-by-case basis, either 
%by a judicial authority, or by another competent authority on condition that the decision can be submitted to judicial review.

% TODO - Apply person_status(PersonId, requested) to the following articles for art17
% TODO - How to indicate which is the earliest? Use negation by failure for all of them? What if more than one?

%% has_right(_article7, PersonId, _right_to_assessment, _individual_assessment)
% 
% Article 7
% Right to an individual assessment
%
% 1. Member States shall ensure that the specific needs of children concerning protection, education, training and social 
% integration are taken into account.
%2. For that purpose children who are suspects or accused persons in criminal proceedings shall be individually assessed. 
%The individual assessment shall, in particular, take into account the child's personality and maturity, the child's economic, 
%social and family background, and any specific vulnerabilities that the child may have.
has_right(article7, PersonId, right_to_assessment, individual_assessment):-
    (   has_right(article7_2, PersonId, right_to_assessment, individual_assessment)
    ;   has_right(article7_4_a, PersonId, right_to_assessment, specific_measure)
    ;   has_right(article7_4_b, PersonId, right_to_assessment, precautionary_measure_effectiveness)
    ;   has_right(article7_4_c, PersonId, right_to_assessment, any_decision)
    ),
    \+ exception(has_right(article7, PersonId, right_to_assessment, individual_assessment), article7_9Applies(article7_9, PersonId, derogation)).

has_right(article7_2, PersonId, right_to_assessment, individual_assessment):-
    (   person_status(PersonId, suspect)
    ;   person_status(PersonId, accused)
    ),
    person_made_aware(PersonId, personStatus),
    proceeding_type(PersonId, criminal).

%3. The extent and detail of the individual assessment may vary depending on the circumstances of the case, the measures that 
%can be taken if the child is found guilty of the alleged criminal offence, and whether the child has, in the recent past, 
%been the subject of an individual assessment.

%% right_property(_article7_4, PersonId, _scope, _specific_measure)
%
% Article 7.4
% The individual assessment shall serve to establish and to note, in accordance with the recording procedure in the Member 
% State concerned, such information about the individual characteristics and circumstances of the child as might be of use to 
% the competent authorities when:
% (a)determining whether any specific measure to the benefit of the child is to be taken;
% (b)assessing the appropriateness and effectiveness of any precautionary measures in respect of the child;
% Recital 38 of the Directive identifies as "precautionary measure" any decision concerning provisional detention or any measure 
% alternative to detention.
% (c)taking any decision or course of action in the criminal proceedings, including when sentencing.
right_property(article7_4_a, PersonId, scope, specific_measure):-
    proceeding_matter(PersonId, specific_measure).

right_property(article7_4_b, PersonId, scope, precautionary_measure_effectiveness):-
    proceeding_matter(PersonId, precautionary_measure_effectiveness).

right_property(article7_4_c, PersonId, scope, any_decision):-
    proceeding_matter(PersonId, any_decision).

%% auxiliary_right(_article7_5, PersonId, _phase, _earliest_of_the_proceedings)
%
% Article 7.5
%
% The individual assessment shall be carried out at the earliest appropriate stage of the proceedings 
% and, subject to paragraph 6, before indictment.

auxiliary_right_scope(article7_5, [article7, article7_2, article7_4_a, article7_4_b, article7_4_c]).

auxiliary_right(article7_5, PersonId, phase, earliest_of_the_proceedings).

auxiliary_right(article7_5, PersonId, phase, before_indictment).

%6. In the absence of an individual assessment, an indictment may nevertheless be presented provided that this is in the 
%child's best interests and that the individual assessment is in any event available at the beginning of the trial hearings 
%before a court.
% TODO - Is this a subset of the right to assessment or a completely different one?

%7. Individual assessments shall be carried out with the close involvement of the child. They shall be carried out by qualified 
%personnel, following, as far as possible, a multidisciplinary approach and involving, where appropriate, the holder of parental 
%responsibility, or another appropriate adult as referred to in Articles 5 and 15, and/or a specialised professional.

%% auxiliary_right(_article7_8, PersonId, _update, _trial)
%
% Article 7.8
%
% If the elements that form the basis of the individual assessment change significantly, Member States shall ensure that the 
% individual assessment is updated throughout the criminal proceedings.
% 9. Member States may derogate from the obligation to carry out an individual assessment where such a derogation is warranted in 
% the circumstances of the case, provided that it is compatible with the child's best interests.

auxiliary_right_scope(article7_8, [article7, article7_2, article7_4_a, article7_4_b, article7_4_c]).

auxiliary_right(article7_8, PersonId, update, trial) :-
    proceeding_matter(PersonId, elements_changed).

exception(has_right(article7, PersonId, right_to_assessment, individual_assessment), article7_9Applies(article7_9, PersonId, derogation)):-
    proceeding_matter(PersonId, derogation_compatible_with_child_interests).

%% has_right(_article8, PersonId, _right_to_medical_examination, Matter)
%
% Article 8
% Right to a medical examination
%
% 1. Member States shall ensure that children who are deprived of liberty have the right to a medical examination without undue 
% delay with a view, in particular, to assessing their general mental and physical condition. The medical examination shall be as 
% non-invasive as possible and shall be carried out by a physician or another qualified professional.
% 2. The results of the medical examination shall be taken into account when determining the capacity of the child to be subject 
% to questioning, other investigative or evidence-gathering acts, or any measures taken or envisaged against the child.
% 3. The medical examination shall be carried out either on the initiative of the competent authorities, in particular where specific 
% health indications call for such an examination,
% or on a request by any of the following:
% (a)the child;
% (b)the holder of parental responsibility, or another appropriate adult as referred to in Articles 5 and 15;
% (c)the child's lawyer.
% 4. The conclusion of the medical examination shall be recorded in writing. Where required, medical assistance shall be provided.
% 5. Member States shall ensure that another medical examination is carried out where the circumstances so require.

has_right(article8, PersonId, right_to_medical_examination, Matter):-
    person_status(PersonId, deprived_of_liberty),
    (   has_right(article8_3, PersonId, right_to_medical_examination, Matter)
    ;   has_right(article8_3_a, PersonId, right_to_medical_examination, Matter)
    ;   has_right(article8_3_b, PersonId, right_to_medical_examination, Matter)
    ;   has_right(article8_3_c, PersonId, right_to_medical_examination, Matter)
    ;   has_right(article8_5, PersonId, right_to_medical_examination, Matter)
    ).

has_right(article8_3, PersonId, right_to_medical_examination, ex_officio):-
    person_status(PersonId, specific_health_indications).

has_right(article8_3_a, PersonId, right_to_medical_examination, requested):-
    person_request_submitted(PersonId, medical_exam).

has_right(article8_3_b, PersonId, right_to_medical_examination, requested):-
    person_status(PersonId, child),
    person_request_submitted(HolderId, medical_exam),
    person_status(HolderId, holder_of_parental_responsibility).

has_right(article8_3_c, PersonId, right_to_medical_examination, requested):-
    person_request_submitted(PersonId, lawyer_medical_exam).

auxiliary_right_scope(article8_5, [article7, article7_2, article7_4_a, article7_4_b, article7_4_c]).

auxiliary_right(article8_5, PersonId, medical_examination, new_medical_exam).

% TODO - In particular does not imply always, should we have it to always be applied?
% It could always apply unless there is a request?
% TODO - Add that an exam has already been performed?

%% right_property(art9, PersonId, record, audiovisual)
%
% Article 9
%
% Audiovisual recording of questioning
% 1. Member States shall ensure that questioning of children by police or other law enforcement authorities during the criminal 
% proceedings is audio-visually recorded where this is proportionate in the circumstances of the case, taking into account, inter alia, 
% whether a lawyer is present or not and whether the child is deprived of liberty or not, provided that the child's best interests 
% are always a primary consideration.
right_property_scope(art9, [article7, article7_2, article7_4_a, article7_4_b, article7_4_c]).

right_property(art9, PersonId, record, audiovisual) :-
    proceeding_matter(PersonId, questioning).

%2. In the absence of audiovisual recording, questioning shall be recorded in another appropriate manner, such as by written minutes 
%which are duly verified.

%3. This Article shall be without prejudice to the possibility to ask questions for the sole purpose of the identification of the 
%child without audiovisual recording.

%Article 10
%Limitation of deprivation of liberty
%1. Member States shall ensure that deprivation of liberty of a child at any stage of the proceedings is limited to the 
%shortest appropriate period of time. Due account shall be taken of the age and individual situation of the child, and of the 
%particular circumstances of the case.

%has_right(article_10, PersonId, deprived_of_liberty, time_limit).

%2. Member States shall ensure that deprivation of liberty, in particular detention, shall be imposed on children only as a measure 
%of last resort. Member States shall ensure that any detention is based on a reasoned decision, subject to judicial review by a court. 
%Such a decision shall also be subject to periodic review, at reasonable intervals of time, by a court, either ex officio or at the 
%request of the child, of the child's lawyer, or of a judicial authority which is not a court. Without prejudice to judicial 
%independence, Member States shall ensure that decisions to be taken pursuant to this paragraph are taken without undue delay.

%% has_right(_article11, PersonId, _right_to_alternative_measure, _detention)
%
% Article 11
% Alternative measures
%
% Member States shall ensure that, where possible, the competent authorities have recourse to measures alternative to detention 
% (alternative measures).
has_right(article11, PersonId, right_to_alternative_measure, detention):-
    proceeding_matter(PersonId, detention).

% you only need to know this right if detention is the obvious solution, if the proceedings are already for a different measure then it should not be considered alternative.

%Article 12
%Specific treatment in the case of deprivation of liberty
%1. Member States shall ensure that children who are detained are held separately from adults, unless it is considered to be in the 
%child's best interests not to do so.

%2. Member States shall also ensure that children who are kept in police custody are held separately from adults, unless:
%(a)it is considered to be in the child's best interests not to do so; or
%(b)in exceptional circumstances, it is not possible in practice to do so, provided that children are held together with adults 
%in a manner that is compatible with the child's best interests.

%3. Without prejudice to paragraph 1, when a detained child reaches the age of 18, Member States shall provide for the possibility 
%to continue to hold that person separately from other detained adults where warranted, taking into account the circumstances of 
%the person concerned, provided that this is compatible with the best interests of children who are detained with that person.

%4. Without prejudice to paragraph 1, and taking into account paragraph 3, children may be detained with young adults, unless 
%this is contrary to the child's best interests.

%% has_right(_article12_5, PersonId, _right_of_detained, _)
%
% Article 12.5
%
% When children are detained, Member States shall take appropriate measures to:
% (a)ensure and preserve their health and their physical and mental development;
% (b)ensure their right to education and training, including where the children have physical, sensory or learning disabilities;
% (c)ensure the effective and regular exercise of their right to family life;
% (d)ensure access to programmes that foster their development and their reintegration into society; and
% (e)ensure respect for their freedom of religion or belief.

has_right(article12_5_a, PersonId, right_of_detained, preserve_health_physical_mental_development):-
    person_status(PersonId, detained).

has_right(article12_5_b, PersonId, right_of_detained, education_training):-
    person_status(PersonId, detained).

has_right(article12_5_c, PersonId, right_of_detained, effective_family_life):-
    person_status(PersonId, detained).

has_right(article12_5_d, PersonId, right_of_detained, reintegration):-
    person_status(PersonId, detained).

has_right(article12_5_e, PersonId, right_of_detained, freedom_of_religion):-
    person_status(PersonId, detained).

%The measures taken pursuant to this paragraph shall be proportionate and appropriate to the duration of the detention.

%% has_right(_article12_5, PersonId, _right_of_deprived_of_liberty, _)
%
% Article 12.5-6
%
% Points (a) and (e) of the first subparagraph shall also apply to situations of deprivation of liberty other than detention. 
% The measures taken shall be proportionate and appropriate to such situations of deprivation of liberty.
% Points (b), (c), and (d) of the first subparagraph shall apply to situations of deprivation of liberty other than detention only 
% to the extent that is appropriate and proportionate in the light of the nature and duration of such situations.
% 6. Member States shall endeavour to ensure that children who are deprived of liberty can meet with the holder of parental responsibility 
% as soon as possible, where such a meeting is compatible with investigative and operational requirements. This paragraph shall be 
% without prejudice to the nomination or designation of another appropriate adult pursuant to Article 5 or 15.
has_right(article12_5_a, PersonId, right_of_deprived_of_liberty, preserve_health_physical_mental_development):-
    person_status(PersonId, deprived_of_liberty).

has_right(article12_5_e, PersonId, right_of_deprived_of_liberty, freedom_of_religion):-
    person_status(PersonId, deprived_of_liberty).

has_right(article12_5_b, PersonId, right_of_deprived_of_liberty, education_training):-
    person_status(PersonId, deprived_of_liberty).

has_right(article12_5_c, PersonId, right_of_deprived_of_liberty, effective_family_life):-
    person_status(PersonId, deprived_of_liberty).

has_right(article12_5_d, PersonId, right_of_deprived_of_liberty, reintegration):-
    person_status(PersonId, deprived_of_liberty).

has_right(article12_6, PersonId, right_to_meet, HolderId):-
    person_status(PersonId, deprived_of_liberty),
    person_status(HolderId, holder_of_parental_responsibility).

%% has_right(_article13, PersonId, _right_to_be_treated, _)
%
% Article 13
% Timely and diligent treatment of cases
%
% 1. Member States shall take all appropriate measures to ensure that criminal proceedings involving children are treated as a matter 
% of urgency and with due diligence.
% 2. Member States shall take appropriate measures to ensure that children are always treated in a manner which protects their dignity 
% and which is appropriate to their age, maturity and level of understanding, and which takes into account any special needs, 
% including any communication difficulties, that they may have.
has_right(article13_1, PersonId, right_to_be_treated, urgency_diligence):-
    proceeding_type(PersonId, criminal).

has_right(article13_2, PersonId, right_to_be_treated, protection_dignity):-
    person_status(PersonId, child).

%% has_right(_article14, PersonId, _right_to_privacy, _protection)
%
% Article 14
% Right to protection of privacy
%
% 1. Member States shall ensure that the privacy of children during criminal proceedings is protected.
% 2. To that end, Member States shall either provide that court hearings involving children are usually held in the absence of the 
% public, or allow courts or judges to decide to hold such hearings in the absence of the public.
has_right(article14, PersonId, right_to_privacy, protection):-
    proceeding_status(PersonId, started),
    proceeding_type(PersonId, criminal).

has_right(article14, PersonId, right_to_privacy, absence_of_public):-
    proceeding_status(PersonId, started),
    proceeding_matter(PersonId, court_hearing).

%3. Member States shall take appropriate measures to ensure that the records referred to in Article 9 are not publicly disseminated.

%4. Member States shall, while respecting freedom of expression and information, and freedom and pluralism of the media, encourage 
%the media to take self-regulatory measures in order to achieve the objectives set out in this Article.

%% has_right(_article15_1, PersonId, _right_to_be_accompanied, HolderId)
%
% Article 15
% Right of the child to be accompanied by the holder of parental responsibility during the proceedings
%
% 1. Member States shall ensure that children have the right to be accompanied by the holder of parental responsibility during court 
% hearings in which they are involved.
% 2. A child shall have the right to be accompanied by another appropriate adult who is nominated by the child and accepted as such 
% by the competent authority where the presence of the holder of parental responsibility accompanying the child during court hearings:
% (a)would be contrary to the child's best interests;
% (b)is not possible because, after reasonable efforts have been made, no holder of parental responsibility can be reached or his 
% or her identity is unknown; or
% (c)would, on the basis of objective and factual circumstances, substantially jeopardise the criminal proceedings.
% Where the child has not nominated another appropriate adult, or where the adult that has been nominated by the child is not acceptable 
% to the competent authority, the competent authority shall, taking into account the child's best interests, designate another person 
% to accompany the child. That person may also be the representative of an authority or of another institution responsible for the 
% protection or welfare of children.
% 3. Where the circumstances which led to an application of point (a), (b) or (c) of paragraph 2 cease to exist, the child shall have the 
% right to be accompanied by the holder of parental responsibility during any remaining court hearings.
% 4. In addition to the right provided for under paragraph 1, Member States shall ensure that children have the right to be accompanied 
% by the holder of parental responsibility, or by another appropriate adult as referred to in paragraph 2, during stages of the 
% proceedings other than court hearings at which the child is present where the competent authority considers that:
% (a)it is in the child's best interests to be accompanied by that person; and
% (b)the presence of that person will not prejudice the criminal proceedings.

has_right(article15_1, PersonId, right_to_be_accompanied, HolderId):-
    person_status(HolderId, holder_of_parental_responsibility),
    proceeding_matter(PersonId, court_hearing).

has_right(article15_2_a, PersonId, right_to_be_accompanied, HolderId):-
    holder_nomination(PersonId, HolderId),
    authority_decision(PersonId, accepted),
    person_status(HolderId2, holder_of_parental_responsibility),
    contrary_to_child_interest(HolderId2),
    \+ exception((_, PersonId, right_to_be_informed, HolderId), article15_3).

has_right(article15_2_b, PersonId, right_to_be_accompanied, HolderId):-
    holder_nomination(PersonId, HolderId),
    authority_decision(PersonId, accepted),
    \+ person_status(HolderId2, holder_of_parental_responsibility),
    \+ exception((_, PersonId, right_to_be_informed, HolderId), article15_3).

has_right(article15_2_c, PersonId, right_to_be_accompanied, HolderId):-
    holder_nomination(PersonId, HolderId),
    authority_decision(PersonId, accepted),
    person_status(HolderId2, holder_of_parental_responsibility),
    jeopardises_proceedings(HolderId2),
    \+ exception((_, PersonId, right_to_be_informed, HolderId), article15_3).

has_right(article15_2, PersonId, right_to_be_accompanied, HolderId):-
    authority_nominates(PersonId, HolderId).


exception((_, PersonId, right_to_be_informed, HolderId), article15_3):-
    proceeding_status(PersonId, circumstances_cease_to_exist),
    proceeding_matter(PersonId, court_hearing).

has_right(article15_4_a, PersonId, right_to_be_accompanied, HolderId):-
    person_status(PersonId, child),
    proceeding_event(HolderId, child_interest),
    \+ proceeding_type(PersonId, court_hearing).

has_right(article15_4_b, PersonId, right_to_be_accompanied, HolderId):-
    person_status(PersonId, child),
    proceeding_event(PersonId, child_interest),
    authority_nominates(PersonId, HolderId),
    \+ proceeding_event(HolderId, prejudice_fairness),
    \+ proceeding_matter(PersonId, court_hearing).

% TODO change to neg by failure

%% has_right(_article16_1, PersonId, _right_to_be_present, _trial)
%
% Article 16
% Right of children to appear in person at, and participate in, their trial
%
% 1. Member States shall ensure that children have the right to be present at their trial and shall take all necessary measures to 
% enable them to participate effectively in the trial, including by giving them the opportunity to be heard and to express their views.
% 2. Member States shall ensure that children who were not present at their trial have the right to a new trial or to another legal 
% remedy, in accordance with, and under the conditions set out in, Directive (EU) 2016/343.
has_right(article16_1, PersonId, right_to_be_present, trial):-
    person_status(PersonId, child).

has_right(article16_2, PersonId, right_to_be_present, new_trial):-
    person_status(PersonId, child),
    proceeding_matter(PersonId, trial_in_absentia).

%%Article 17
%European arrest warrant proceedings
%Member States shall ensure that the rights referred to in Articles 4, 5, 6 and 8, Articles 10 to 15 and Article 18 apply mutatis 
%mutandis, in respect of children who are requested persons, upon their arrest pursuant to European arrest warrant proceedings in 
%the executing Member State.
article_6_applies(PersonId):-
    person_status(PersonId, requested).

article_4_applies(PersonId):-
    person_status(PersonId, requested).

%% auxiliary_right(_article18, PersonId, _access_lawyer, _effective_exercise)
%
% Article 18
% Right to legal aid
%
% Member States shall ensure that national law in relation to legal aid guarantees the effective exercise of the right to be 
% assisted by a lawyer pursuant to Article 6.

auxiliary_right_scope(article19, [article6_1, article6_3, article6_3_a, article6_3_b, article6_3_c, article6_3_d, article6_4_a, article6_4_b, article6_6_a, article6_6_b]).

auxiliary_right(article18, PersonId, access_lawyer, effective_exercise):-
    (   person_status(PersonId, suspect)
    ;   person_status(PersonId, accused)
    ;   person_status(PersonId, requested)
    ),
    person_made_aware(PersonId, personStatus).

%% auxiliary_right(_article19, PersonId, _remedy, _breach_of_rights)
%
% Article 19
% Remedies
%
% Member States shall ensure that children who are suspects or accused persons in criminal proceedings and children who are 
% requested persons have an effective remedy under national law in the event of a breach of their rights under this Directive.

auxiliary_right_scope(article19, [_]).

auxiliary_right(article19, PersonId, remedy, breach_of_rights):-
    proceeding_matter(PersonId, breach_of_rights).

%%Article 20
%Training
%1. Member States shall ensure that staff of law enforcement authorities and of detention facilities who handle cases involving 
%children, receive specific training to a level appropriate to their contact with children with regard to children's rights, 
%appropriate questioning techniques, child psychology, and communication in a language adapted to the child.

%2. Without prejudice to judicial independence and differences in the organisation of the judiciary across the Member States, 
%and with due respect for the role of those responsible for the training of judges and prosecutors, Member States shall take 
%appropriate measures to ensure that judges and prosecutors who deal with criminal proceedings involving children have specific 
%competence in that field, effective access to specific training, or both.

%3. With due respect for the independence of the legal profession and for the role of those responsible for the training of lawyers, 
%Member States shall take appropriate measures to promote the provision of specific training as referred to in paragraph 2 to 
%lawyers who deal with criminal proceedings involving children.

%4. Through their public services or by funding child support organisations, Member States shall encourage initiatives enabling those 
%providing children with support and restorative justice services to receive adequate training to a level appropriate to their 
%contact with children and observe professional standards to ensure such services are provided in an impartial, respectful and 
%professional manner.
