facts = """
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% proceeding_type(PersonId, _europeanArrestWarrant)
%
% The proceedings concern the execution of a European Arrest Warrant.
% The European Arrest Warrant ("EAW") is a simplified cross-border judicial surrender procedure for the purpose of prosecution.
%

proceeding_type(PersonId, europeanArrestWarrant).


%% person_status(PersonId, _suspect)
%
% The person is a suspect.
%

person_status(PersonId, suspect).


%% person_status(PersonId, _accused)
%
% The person is an accused.
%

person_status(PersonId, accused).

%% proceeding_language(PersonId, Language)
%
% The language of the proceedings is X
%

proceeding_language(PersonId, Language).


%% person_status(PersonId, _deprived_of_liberty)
%
% The person has been deprived of liberty. A person is deprived by arrest or detention.
%

person_status(PersonId, deprived_of_liberty).

"""

facts_dir_2010_64 = """
%% person_document(PersonId, _europeanArrestWarrant)
%
% The document issued is the european arrest warrant
%

person_document(PersonId, europeanArrestWarrant).


%% authority_decision(PersonId, _essential_document)
%
% The authority has decreed any document to be essential
%

authority_decision(PersonId, essential_document).


%% person_request_submitted(PersonId, _essential_document)
%
% The person has submitted a request to consider a document to be essential
%

person_request_submitted(PersonId, essential_document).


%% person_document(PersonId, _document_deprives_liberty)
%
% The document issued is any document that deprives liberty
%

person_document(PersonId, document_deprives_liberty).


%% person_document(PersonId, _charge)
%
% The document issued is the charge
%

person_document(PersonId, charge).


%% person_document(PersonId, _indictment)
%
% The document issued is an indictment
%

person_document(PersonId, indictment).


%% person_document(PersonId, _judgement)
%
% The document issued is a judgement
%

person_document(PersonId, judgement).

%% person_speaks(PersonId, Language).
%
% The person speaks language X
%

person_speaks(PersonId, Language)

%% person_understands(PersonId, Language)
%
% The person reads and understands language X
%

person_understands(PersonId, Language).

%% lawyer_language(PersonId, Language)
%
% The lawyer can speak, read and understand this language
%

lawyer_language(PersonId, Language).

"""

facts_dir_2013_48 = """

%% person_status(PersonId, _requested)
%
% The person is requested or subject to an european arrest warrant
%
person_status(PersonId, requested).


%% person_status(PersonId, _deprived_of_liberty)
%
% The person has been deprived of liberty
%
person_status(PersonId, deprived_of_liberty).


%% proceeding_matter(PersonId, _questioning)
%
% The defendant has been subject to questioning
%

proceeding_matter(PersonId, questioning).


%% proceeding_matter(PersonId, _evidence_gathering_act)
%
% The proceedings concern any evidence gathering act
%

proceeding_matter(PersonId, evidence_gathering_act).


%% proceeding_matter(PersonId, _summoned_court)
%
% The proceedings concern the summon to court of the person
%

proceeding_matter(PersonId, summoned_court).


%% proceeding_matter(PersonId, _pre_trial)
%
% The proceedings are happening before the trial has started
%

proceeding_matter(PersonId, pre_trial).


%% person_event(PersonId, _geographical_remoteness)
%
% The person's geographical remoteness makes it impossible to ensure no delay to the presence of the lawyer
%

person_event(PersonId, geographical_remoteness).


%% person_nominate(PersonId, PersonId2)
%
% The person would like to nominate X as a third person to communicate with
%

person_nominate(PersonId, PersonId2).


%% person_danger(PersonId, _life)
%
% A serious concern or threat has risen, that concerns the life of a person
%

person_danger(PersonId, life).


%% person_danger(PersonId, _liberty)
%
%  A serious concern or threat has risen, that concerns the liberty of a person
%

person_danger(PersonId, liberty).


%% person_danger(PersonId, _physical_integrity)
%
% A serious concern or threat has risen, that concerns the physical integrity of a person
%

person_danger(PersonId, physical_integrity).


%% proceeding_danger(PersonId, _substantially_jeopardised)
%
% There is danger of the proceedings being substantially jeopardised
%

proceeding_danger(PersonId, substantially_jeopardised).


%% proceeding_country(PersonId, Country)
%
% The proceedings are located in a [Country]
%

proceeding_country(PersonId, Country).


%% person_nationality(PersonId, Country)
%
% The person is a national of [Country].
%

person_nationality(PersonId, Country).


%% proceeding_matter(PersonId, _hearing)
%
% The proceedings concern an hearing
%

proceeding_matter(PersonId, hearing).

"""



facts_dir_2016_800 = """
% Directive 2016/800

%% person_status(PersonId, _child)
%
% The person is a child
%

person_status(PersonId, child).


%% person_status(PersonId, _subject_to_proceedings)
%
% The person is the subject of the proceedings
%

person_status(PersonId, subject_to_proceedings).


%% person_age(PersonId, Age, _start_proceeding)
%
% The person was X years of age at the start of the proceedings
%

person_age(PersonId, Age, start_proceeding).


%% person_age(PersonId, Age)
%
% The person is currently X years of age
%

person_age(PersonId, Age).


%% person_status(PersonId, _deprived_of_liberty)
%
% The person has been deprived of liberty
%

person_status(PersonId, deprived_of_liberty).


%% person_nature(PersonId, _natural)
%
% The person is a natural person
%

person_nature(PersonId, natural).


%% person_nature(PersonId, _legal)
%
% The person is a legal person
%

person_nature(PersonId, legal).


%% holds_parental_responsibility(PersonId, ChildId)
%
% This person holds parental responsibility over the child
%

holds_parental_responsibility(HolderId, PersonId).



%% responsibility_assigned(PersonId, ChildId, _judgement)
%
% The responsiblity over the child has been assigned through a judgement
%

responsibility_assigned(PersonId, ChildId, judgement).


%% responsibility_assigned(PersonId, ChildId, _operation_of_law)
%
% The responsiblity over the child has been assigned through an operation of law
%

responsibility_assigned(PersonId, ChildId, operation_of_law).


%% responsibility_assigned(PersonId, ChildId, _agreement_having_legal_effects)
%
% The responsiblity over the child has been assigned through an agreement having legal effect
%

responsibility_assigned(PersonId, ChildId, agreement_having_legal_effects).


%% person_status(PersonId, _age_unknown)
%
% The person's age is unknown
%

person_status(PersonId, age_unknown).


%% proceeding_matter(PersonId, _court_hearing)
%
% The proceedings concern the court hearing
%

proceeding_matter(PersonId, court_hearing).


%% proceeding_matter(PersonId, _questioning)
%
% The defendant has been subject to questioning
%

proceeding_matter(PersonId, questioning).


%% proceeding_matter(PersonId, _evidence_gathering_act)
%
% The proceedings concern any evidence gathering act
%

proceeding_matter(PersonId, evidence_gathering_act).


%% proceeding_matter(PersonId, _summoned_court)
%
% The proceedings concern the summon to court of the person
%

proceeding_matter(PersonId, summoned_court).


%% proceeding_matter(PersonId, _identity_parade)
%
% The proceedings concern an identity parade
%

proceeding_matter(PersonId, identity_parade).


%% proceeding_matter(PersonId, _confrontations)
%
% The proceedings concern confrontation
%

proceeding_matter(PersonId, confrontations).


%% proceeding_matter(PersonId, _reconstructions_crime_scene)
%
% The proceedings concern the reconstructions of a crime scene
%

proceeding_matter(PersonId, reconstructions_crime_scene).

%% holder_nomination(ChildId, HolderId)
%
% The child has nominated someone as holder of parental responsibility
%

holder_nomination(ChildId, HolderId).


%% authority_decision(PersonId, _accepted)
%
% The authority has accepted the nomination of the child concerning the holder of parental responsibility
%

authority_decision(PersonId, accepted).


%% authority_nominates(PersonId, HolderId)
%
% The authority has nominated someone to accompany the child as responsibility holder
%

authority_nominates(PersonId, HolderId).


%% person_status(HolderId, _holder_of_parental_responsibility)
%
% The person is an holder of parental responsibility
%

person_status(HolderId, holder_of_parental_responsibility).


%% contrary_to_child_interest(PersonId)
%
% The person is acting contrary to the interests of the child
%

contrary_to_child_interest(PersonId).


%% jeopardises_proceedings(HolderId)
%
% This person's acting jeopardises the proceedings
%

jeopardises_proceedings(HolderId).

%% authority_decision(HolderId, _nomination)
%
% The authority has nominated a new holder of parental responsibility
%

authority_decision(HolderId, nomination).


%% proceeding_matter(PersonId, _detention)
%
% The proceedings concern detention
%

proceeding_matter(PersonId, detention).


%% person_status(PersonId, _detained)
%
% The person has been detained
%

person_status(PersonId, detained).


%% person_status(PersonId, _specific_health_indications)
%
% The person is in need of specific health indications
%

person_status(PersonId, specific_health_indications).


%% person_request_submitted(PersonId, _medical_exam)
%
% The person has submitted a request to perform a medical exam
%

person_request_submitted(PersonId, medical_exam).


%% person_request_submitted(HolderId, _medical_exam)
%
% The holder of parental responsibility has submitted a request to perform a medical exam
%

person_request_submitted(HolderId, medical_exam).


%% person_request_submitted(PersonId, _lawyer_medical_exam)
%
% The person's lawyer has submitted a request to perform a medical exam
%

person_request_submitted(PersonId, lawyer_medical_exam).


%% person_danger(PersonId, _life)
%
% There is need to avoid damage to someone's life
%

person_danger(PersonId, life).


%% person_danger(PersonId, _liberty)
%
% There is need to avoid damage to someone's liberty
%

person_danger(PersonId, liberty).


%% person_danger(PersonId, _physical_integrity)
%
% There is need to avoid damage to someone's physical integrity
%

person_danger(PersonId, physical_integrity).


%% proceeding_matter(PersonId, _pre_trial)
%
% The proceedings are happening before the trial has started
%

proceeding_matter(PersonId, pre_trial).


%% imperative_immediate_action(PersonId, _investigating_authority)
%
% Investigating authority must intervene to avoid jeopardising the proceedings
%

imperative_immediate_action(PersonId, investigating_authority).


%% proceeding_matter(PersonId, _trial_in_absentia)
%
% The proceedings have been conducted in absentia
%

proceeding_matter(PersonId, trial_in_absentia).
"""

facts_dir_2013_48_it = """

%% proceeding_matter(PersonId, _precautionary_detention)
%
% The proceedings concern precautionary detention
%

proceeding_matter(PersonId, precautionary_detention).


%% person_status(PersonId, _detained)
%
% The person has been detained
%

person_status(PersonId, detained).


%% person_status(PersonId, _arrested)
%
% The person is arrested
%

person_status(PersonId, arrested).

%% proceeding_matter(PersonId, _precautionary_measure)
%
% The person is under a precautionary measure different from precautionary detention.
%

proceeding_matter(PersonId, _precautionary_measure).


%% proceeding_matter(PersonId, _investigative_questioning)
%
% Police officials will conduct investigative questioning.
%

proceeding_matter(PersonId, investigative_questioning).


%% proceeding_matter(PersonId, _inspection)
%
% Public Prosecutor must carry out an inspection.
%

proceeding_matter(PersonId, inspection).


%% proceeding_matter(PersonId, _informal_identification)
%
% Public Prosecutor must carry out an informal_identification.
%

proceeding_matter(PersonId, informal_identification).


%% physical_presence_required(PersonId, _lawyer).
%
% The lawyer must be present for an investigation activity.
%

physical_presence_required(PersonId, lawyer)



%% proceeding_matter(PersonId, _hearing)
%
% A hearing is scheduled for the proceedings involving PersonId.
%

proceeding_matter(PersonId, hearing).



%% person_status(PersonId, _inmate)
%
% PersonId is currently in custody as an inmate.
%

person_status(PersonId, inmate).



%% person_status(PersonId, _convicted)
%
% PersonId has been convicted of a crime.
%

person_status(PersonId, convicted).



%% authority_decision(PersonId, _authorized)
%
% The authority has granted authorization for actions related to PersonId.
%

authority_decision(PersonId, authorized).



%% person_status(PersonId, _temporary_custody)
%
% PersonId is being held in temporary custody.
%

person_status(PersonId, temporary_custody).

"""


facts_dir_2013_48_nl = """
%% person_status(PersonId, arrested)
%
% PersonId has been arrested and is in custody.
%
person_status(PersonId, arrested).

%% person_status(PersonId, raise_suspicion)
%
% The person who was initially questioned as a witness becomes, in the course of the interview, suspect.
%

person_status(PersonId, raise_suspicion).



%% person_status(PersonId, _detention)
%
% The detention of the person has been ordered for investigation at the arraignment.
%

person_status(PersonId, detention).



%% person_status(PersonId, vulnerable)
%
% PersonId is in a vulnerable state, requiring special attention or measures.
%

person_status(PersonId, vulnerable).



%% proceeding_matter(PersonId, imprisonment_over_twelve_years)
%
% The proceedings involve potential imprisonment exceeding twelve years.
%

proceeding_matter(PersonId, imprisonment_over_twelve_years).



%% proceeding_matter(PersonId, _pre_trial_detention)
%
% The proceedings involve potential pre-trial detention.
%

proceeding_matter(PersonId, pre_trial_detention).



%% person_request_submitted(PersonId, _waive_right)
%
% PersonId has submitted a request to waive their rights to legal assistance.
%

person_request_submitted(PersonId, waive_right).



%% person_status(PersonId, _informed_consequences)
%
% The defendant has waived their right to legal assistance and has been informed of the consequences of doing so.
%

person_status(PersonId, informed_consequences).



%% person_request_submitted(PersonId, _lawyer_participation)
%
% PersonId has requested the participation of a lawyer in their proceedings.
%

person_request_submitted(PersonId, lawyer_participation).



%% proceeding_matter(PersonId, _prevent_damage_investigation)
%
% There is a need to prevent substantial damage to the investigation..
%

proceeding_matter(PersonId, prevent_damage_investigation).



%% proceeding_matter(PersonId, arraignment)
%
% An arraignment is scheduled as part of the proceedings involving PersonId.
%

proceeding_matter(PersonId, arraignment).



%% proceeding_event(PersonId, superseding_interest)
%
% The interest of theinvestigation does not permit the lawyer's presence.
%

proceeding_event(PersonId, superseding_interest).



%% person_status(PersonId, detained)
%
% The defendant is currently detained.
%

person_status(PersonId, detained).



%% person_request_submitted(PersonId, appoint_lawyer)
%
% PersonId has submitted a request to appoint a lawyer for their case.
%

person_request_submitted(PersonId, appoint_lawyer).



%% proceeding_matter(PersonId, _surrender)
%
% The proceedings concern the surrender of the person
%

proceeding_matter(PersonId, surrender).

%% person_status(PersonId, _prisoner)
%
% The person is a prisoner
%

person_status(PersonId, prisoner).



%% person_status(PersonId, _child)
%
% The person is a child
%

person_status(PersonId, child).



%% proceeding_matter(PersonId, _identity_parade)
%
% The proceedings concern an identity parade
%

proceeding_matter(PersonId, identity_parade).



%% person_request_submitted(PersonId, _communicate_consul)
%
% The person has submitted a request to communicate with the consul
%

person_request_submitted(PersonId, communicate_consul).
"""

facts_dir_2013_48_bg = """

%% person_status(PersonId, _detained)
%
% The person has been detained
%

person_status(PersonId, detained).


%% proceeding_matter(PersonId, _arrest)
%
% The proceedings concern an arrest
%

proceeding_matter(PersonId, arrest).


%% proceeding_matter(PersonId, _breach_of_rights)
%
% The proceedings concern a breach of the rights of the defendant
%

proceeding_matter(PersonId, breach_of_rights).


%% proceeding_matter(PersonId, _lawyer_presence_required)
%
% The proceedings concern a case where the presence of the lawyer is required
%

proceeding_matter(PersonId, lawyer_presence_required).


%% person_event(PersonId, waive_right)
%
% The person has waived his defence rights.
%
person_event(PersonId, waive_right).


%% person_status(PersonId, _waive_right)
%
% The person has decided to waive a right
%

person_status(PersonId, waive_right)


%% proceeding_matter(PersonId, _interrogation)
%
% The proceedings concern an interrogation
%

proceeding_matter(PersonId, interrogation).

"""




facts_dir_2013_48_pl = """

%% proceeding_matter(PersonId, _detention_on_remand)
%
% The proceedings concern detention on remand
%

proceeding_matter(PersonId, detention_on_remand).


%% proceeding_matter(PersonId, _preparatory_proceedings)
%
% The proceedings are of preparatory nature
%

proceeding_matter(PersonId, preparatory_proceedings).


%% person_request_submitted(PersonId, _defence_counsel)
%
% The person has submitted a request to communicate with his defence counsel
%

person_request_submitted(PersonId, defence_counsel).


%% person_request_submitted(PersonId, _new_notice)
%
% The person has submitted a request to notify a new person of the decision on detention
%

person_request_submitted(PersonId, new_notice).


%% proceeding_type(PersonId, _accelerated_proceedings)
%
% The proceedings are accelerated
%

proceeding_type(PersonId, accelerated_proceedings).


%% person_nationality(PersonId, _none)
%
% The person does not have a citizenship
%

person_nationality(PersonId, none).


"""




facts_dir_2010_64_nl = """

%% person_status(PersonId, _requested)
%
% The person is requested or subject to an european arrest warrant
%
person_status(PersonId, requested).

%% proceeding_matter(PersonId, police_custody)
%
% The person was issued an order to be taken into police custody
%
proceeding_matter(PersonId, police_custody)

%% proceeding_matter(PersonId, pretrial_detention)
%
% The person was issued an order to be taken into pre trial detention
%
proceeding_matter(PersonId, pretrial_detention)

%% proceeding_matter(PersonId, _questioning)
%
% The proceedings concern the questioning of the defendant
%
proceeding_matter(PersonId, questioning).

%% person_document(PersonId, _penal_order)
%
% The defendant has been given a penal order.
%
person_document(PersonId, penal_order).


%% proceeding_matter(PersonId, _minor_offence)
%
% The proceedings concern an offence declared to be of minor importance.
%
proceeding_matter(PersonId, minor_offence).

%% proceeding_matter(PersonId, _summoned_court)
%
% The proceedings concern the summon to court of the person
%
proceeding_matter(PersonId, summoned_court).
"""

facts_dir_2010_64_bg = """

%% person_document(PersonId, decree_constitution)
%
% The person is associated with a document indicating the decree of constitution.
%
person_document(PersonId, decree_constitution).

%% person_document(PersonId, remand_measure)
%
% The person is associated with a document concerning a remand measure.
%
person_document(PersonId, remand_measure).

%% person_document(PersonId, indictment)
%
% The person is associated with a document specifying an indictment.
%
person_document(PersonId, indictment).

%% person_document(PersonId, conviction)
%
% The person is associated with a document indicating a conviction.
%
person_document(PersonId, conviction).

%% person_document(PersonId, appeal)
%
% The person is associated with a document related to an appeal.
%
person_document(PersonId, appeal).

%% proceeding_matter(PersonId, interrogation)
%
% The proceedings involve the interrogation of the person.
%
proceeding_matter(PersonId, interrogation).
"""

facts_dir_2010_64_it = """

%% person_document(PersonId, notice_of_investigation)
%
% The person is associated with a notice of investigation document.
%
person_document(PersonId, notice_of_investigation).

%% person_document(PersonId, notice_of_right_to_defence)
%
% The person is associated with a document informing them of their right to defence.
%
person_document(PersonId, notice_of_right_to_defence).

%% person_document(PersonId, decision_precautionary_measure)
%
% The person is associated with a document detailing a decision on a precautionary measure.
%
person_document(PersonId, decision_precautionary_measure).

%% person_document(PersonId, notice_conclusion_investigation)
%
% The person is associated with a document notifying the conclusion of an investigation.
%
person_document(PersonId, notice_conclusion_investigation).

%% person_document(PersonId, decree_preliminary_hearing)
%
% The person is associated with a document for a decree on a preliminary hearing.
%
person_document(PersonId, decree_preliminary_hearing).

%% person_document(PersonId, decree_trial_summons)
%
% The person is associated with a document summoning them to trial.
%
person_document(PersonId, decree_trial_summons).

%% person_document(PersonId, decree_conviction)
%
% The person is associated with a document indicating a decree of conviction.
%
person_document(PersonId, decree_conviction).

%% proceeding_matter(PersonId, temporary_detention)
%
% The proceedings involve the temporary detention of the person.
%
proceeding_matter(PersonId, temporary_detention).

%% proceeding_matter(PersonId, arrest)
%
% The proceedings involve the arrest of the person.
%
proceeding_matter(PersonId, arrest).

%% proceeding_matter(PersonId, precautionary_detention)
%
% The proceedings involve the precautionary detention of the person.
%
proceeding_matter(PersonId, precautionary_detention).
"""

facts_dir_2010_64_pl = """

%% person_status(PersonId, informed_about_charge)
%
% The person has been informed about the charge against them.
%
person_status(PersonId, informed_about_charge).

%% person_document(PersonId, request_discontinuation_proceedings)
%
% The person is associated with a request to discontinue the proceedings.
%
person_document(PersonId, request_discontinuation_proceedings).

%% familiarise_with_evidence_content(PersonId, translation)
%
% The person needs to familiarise themselves with the content of evidence through a translation, as he is not aware of such.
%
familiarise_with_evidence_content(PersonId, translation).

%% proceeding_matter(PersonId, arrest)
%
% The proceedings involve the arrest of the person.
%
proceeding_matter(PersonId, arrest).

%% person_document(PersonId, decision_supplementing_charge)
%
% The person is associated with a document concerning a decision to supplement the charge.
%
person_document(PersonId, decision_supplementing_charge).

%% person_document(PersonId, decision_changing_charge)
%
% The person is associated with a document concerning a decision to change the charge.
%
person_document(PersonId, decision_changing_charge).

"""

facts_dir_2012_13 = """
%% person_status(PersonId, _requested)
%
% The person is requested or subject to an european arrest warrant
%

person_status(PersonId, requested).


%% proceeding_matter(PersonId, _minor_offence)
%
% The proceedings concern an offence declared to be of minor importance.
%

proceeding_matter(PersonId, minor_offence).


%% person_status(PersonId, _arrested)
%
% The person has been arrested
%

person_status(PersonId, arrested).


%% person_status(PersonId, _detained)
%
% The person has been detained
%

person_status(PersonId, detained).


%% person_document(PersonId, _new_evidence)
%
% The document issued provides new evidence to the case
%

person_document(PersonId, new_evidence).

%% person_document(PersonId, challenge_arrest)
%
% The document issued is needed to challenge the arrest
%

person_document(PersonId, challenge_arrest).

%% person_document(PersonId, challenge_detention)
%
% The document issued is needed to challenge the detention
%

person_document(PersonId, challenge_detention).


%% authority_decision(PersonId, _essential_document)
%
% The authority has decreed any document to be essential
%

authority_decision(PersonId, essential_document).


%% person_danger(PersonId, _life)
%
% There is need to avoid damage to a person's life
%

person_danger(PersonId, life).


%% person_danger(PersonId, _fundamental_rights)
%
% There is need to avoid damage to the fundamental rights of any person
%

person_danger(PersonId, fundamental_rights).


%% person_danger(PersonId, _public_interest)
%
% There is a need to secure the public interest of the proceedings
%

person_danger(PersonId, public_interest).

"""

facts_dir_2012_13_bg = """
%% person_document(PersonId, decree_for_constitution)
%
% The person is associated with a document concerning a decree for constitution.
%
person_document(PersonId, decree_for_constitution).

%% person_document(PersonId, remand_measure)
%
% The person is associated with a document concerning a remand measure.
%
person_document(PersonId, remand_measure).

%% person_document(PersonId, indictment)
%
% The person is associated with a document concerning an indictment.
%
person_document(PersonId, indictment).

%% person_document(PersonId, _indictment)
%
% The document issued is an indictment
%
person_document(PersonId, indictment).

%% person_document(PersonId, _judgement)
%
% The document issued is a judgement.
%
person_document(PersonId, judgement).

%% proceeding_matter(PersonId, pre_trial)
%
% The legal proceeding has not yet reached the phase of the trial.
%
proceeding_matter(PersonId, pre_trial).

%% proceeding_matter(PersonId, evidence_gathering_act)
%
% The proceeding matter involves evidence gathering.
%
proceeding_matter(PersonId, evidence_gathering_act).

%% proceeding_matter(PersonId, custody_in_remand)
%
% The proceeding matter involves custody in remand.
%
proceeding_matter(PersonId, custody_in_remand).

%% proceeding_matter(PersonId, punishment_deprivation_liberty_no_less_ten_years)
%
% The proceeding matter involves punishment of deprivation of liberty for no less than ten years.
%
proceeding_matter(PersonId, punishment_deprivation_liberty_no_less_ten_years).

%% proceeding_matter(PersonId, trial_in_absentia)
%
% The trial has proceeded in absentia, meaning the defendant was not physically present without a valid reason.
%
proceeding_matter(PersonId, trial_in_absentia).

%% person_event(PersonId, waive_right)
%
% The person has waived his defence rights.
%
person_event(PersonId, waive_right).

%% person_status(PersonId, cannot_afford_lawyer)
%
% The person cannot afford a lawyer
%
person_status(PersonId, cannot_afford_lawyer).

%% person_status(PersonId, physical_mental_deficiencies)
%
% The person has physical or mental deficiencies
%
person_status(PersonId, physical_mental_deficiencies).
"""

facts_dir_2012_13_nl = """
%% proceeding_matter(PersonId, detention)
%
% The proceeding matter involves detention
%
proceeding_matter(PersonId, detention).

%% proceeding_matter(PersonId, pre_trial)
%
% The legal proceeding has not yet reached the phase of the trial.
%
proceeding_matter(PersonId, pre_trial).

%% proceeding_matter(PersonId, _detention)
%
% The proceedings concern detention
%
proceeding_matter(PersonId, detention).

%% person_request_submitted(PersonId, medical_assistance)
%
% The person has submitted a request for medical assistance
%
person_request_submitted(PersonId, medical_assistance).

%% person_status(PersonId, need_medical_assistance)
%
% The person needs medical assistance
%
person_status(PersonId, need_medical_assistance).
"""

facts_dir_2012_13_it = """
%% physical_presence_required(PersonId, lawyer)
%
% The physical presence of a lawyer is required for the person
%
physical_presence_required(PersonId, lawyer).

%% proceeding_matter(PersonId, precautionary_detention)
%
% The proceeding matter involves precautionary detention
%
proceeding_matter(PersonId, precautionary_detention).

%% proceeding_matter(PersonId, questioning)
%
% The proceeding matter involves questioning
%
proceeding_matter(PersonId, questioning).

%% proceeding_matter(PersonId, precautionary_measure)
%
% The proceeding matter involves a precautionary measure
%
proceeding_matter(PersonId, precautionary_measure).

%% proceeding_matter(PersonId, investigative_questioning)
%
% The proceeding matter involves investigative questioning
%
proceeding_matter(PersonId, investigative_questioning).

%% proceeding_matter(PersonId, inspection)
%
% The proceeding matter involves an inspection
%
proceeding_matter(PersonId, inspection).

%% proceeding_matter(PersonId, informal_identification)
%
% The proceeding matter involves informal identification
%
proceeding_matter(PersonId, informal_identification).

%% proceeding_matter(PersonId, search)
%
% The proceeding matter involves a search
%
proceeding_matter(PersonId, search).

%% proceeding_matter(PersonId, seizure)
%
% The proceeding matter involves a seizure
%
proceeding_matter(PersonId, seizure).

%% proceeding_matter(PersonId, technical_ascertainment)
%
% The proceeding matter involves technical ascertainment
%
proceeding_matter(PersonId, technical_ascertainment).

%% proceeding_matter(PersonId, preliminary_investigation)
%
% The proceeding matter involves a preliminary investigation
%
proceeding_matter(PersonId, preliminary_investigation).

%% proceeding_matter(PersonId, committal_to_trial)
%
% The proceeding matter involves committal to trial
%
proceeding_matter(PersonId, committal_to_trial).

%% proceeding_matter(PersonId, summoned_court)
%
% The person is summoned to court
%
proceeding_matter(PersonId, summoned_court).

%% authority_decision(PersonId, access_materials)
%
% An authority has decided to allow the defendant access to the documents of the case. This includes evidence and related documents.
%
authority_decision(PersonId, access_materials).

%% person_request_submitted(PersonId, access_materials)
%
% The person, or his lawyer, have submitted a request for access to the documents of the case. This includes evidence and related documents.
%
person_request_submitted(PersonId, access_materials).
"""
facts_dir_2012_13_pl = """

%% person_status(PersonId, _arrested)
%
% The person is arrested
%
person_status(PersonId, arrested).

%% proceeding_matter(PersonId, interrogation)
%
% The proceeding matter involves interrogation
%
proceeding_matter(PersonId, interrogation).

%% proceeding_matter(PersonId, detention_on_remand)
%
% The proceeding matter involves detention on remand
%
proceeding_matter(PersonId, detention_on_remand).

%% proceeding_matter(PersonId, investigation)
%
% The proceeding matter involves investigation
%
proceeding_matter(PersonId, investigation).

%% proceeding_matter(PersonId, court_hearing)
%
% The proceeding matter involves a court hearing
%
proceeding_matter(PersonId, court_hearing).

%% proceeding_matter(PersonId, preparatory_proceedings)
%
% The proceeding matter involves preparatory proceedings
%
proceeding_matter(PersonId, preparatory_proceedings).

%% proceeding_matter(PersonId, grounds_close_investigation)
%
% The proceeding matter involves grounds for closing an investigation
%
proceeding_matter(PersonId, grounds_close_investigation).

%% person_request_submitted(PersonId, communicate_consul)
%
% The person has submitted a request to communicate with a consul
%
person_request_submitted(PersonId, communicate_consul).

%% person_request_submitted(PersonId, diplomat)
%
% The person has submitted a request to communicate with a diplomat
%
person_request_submitted(PersonId, diplomat).

%% person_request_submitted(PersonId, access_materials)
%
% The person, or his lawyer, have submitted a request for access to the investigative materials of the case
%
person_request_submitted(PersonId, access_materials).
"""

facts_dir_2016_343 = """
%% person_event(PersonId, cannot_be_located)
%
% The person cannot be located
%
person_event(PersonId, cannot_be_located).

%% person_danger(PersonId, proper_conduct_proceedings)
%
% The person poses a danger to the proper conduct of proceedings
%
person_danger(PersonId, proper_conduct_proceedings).

%% proceeding_danger(PersonId, investigation)
%
% The authority has disseminated the defendant's information due to the necessity of the investigation
%
proceeding_danger(PersonId, investigation).

%% proceeding_danger(PersonId, public_interest)
%
% The authority has disseminated the defendant's information due to the necessity of the public interest
%
proceeding_danger(PersonId, public_interest).

%% proceeding_matter(PersonId, evidence_gathering_act)
%
% The proceeding matter involves an evidence gathering act
%
proceeding_matter(PersonId, evidence_gathering_act).

"""

facts_dir_2016_343_bg = """

%% proceeding_matter(PersonId, pre_trial)
%
% The legal proceeding has not yet reached the phase of the trial.
%
proceeding_matter(PersonId, pre_trial).

%% proceeding_matter(PersonId, detention_on_remand)
%
% The proceeding matter involves detention on remand.
%
proceeding_matter(PersonId, detention_on_remand).

%% proceeding_matter(PersonId, hearing)
%
% The proceeding matter involves a hearing
%
proceeding_matter(PersonId, hearing).
"""

facts_dir_2016_343_nl = """
%% proceeding_matter(PersonId, questioning)
%
% The proceeding matter involves questioning of the defendant
%
proceeding_matter(PersonId, questioning).

%% person_event(PersonId, make_statements)
%
% The person has made statements to the investigative authorities during the course of the proceedings
%
person_event(PersonId, make_statements).

%% person_status(PersonId, witness)
%
% The person has the status of a witness
%
person_status(PersonId, witness).

%% person_event(PersonId, not_appear_hearing)
%
% The person did not appear at the hearing
%
person_event(PersonId, not_appear_hearing).
"""

facts_dir_2016_343_it = """

%% proceeding_matter(PersonId, investigation)
%
% The proceeding matter involves an investigation
%
proceeding_matter(PersonId, investigation).

%% proceeding_matter(PersonId, interrogation)
%
% The proceeding matter involves an interrogation
%
proceeding_matter(PersonId, interrogation).

%% proceeding_matter(PersonId, preliminary_hearing)
%
% The proceeding matter involves a preliminary hearing
%
proceeding_matter(PersonId, preliminary_hearing).

%% person_event(PersonId, waive_right)
%
% The person has waived his defence rights.
%
person_event(PersonId, waive_right).

%% person_event(PersonId, not_appear_hearing)
%
% The person did not appear at the hearing
%
person_event(PersonId, not_appear_hearing).

%% person_circumstances(PersonId, inculpable_absence)
%
% The person was absent due to inculpable circumstances
%
person_circumstances(PersonId, inculpable_absence).
"""

facts_dir_2016_343_pl = """

%% proceeding_matter(PersonId, irresolvable_doubts)
%
% The proceeding matter involves irresolvable doubts
%
proceeding_matter(PersonId, irresolvable_doubts).

%% proceeding_matter(PersonId, external_examination_body)
%
% The proceeding matter involves external examination of the body and other tests not infringing his bodily integrity.
%
proceeding_matter(PersonId, external_examination_body).

%% proceeding_matter(PersonId, evidentiary_procedure)
%
% The proceeding matter involves an evidentiary procedure
%
proceeding_matter(PersonId, evidentiary_procedure).

%% proceeding_matter(PersonId, summary_offences)
%
% The proceeding matter involves summary offences
%
proceeding_matter(PersonId, summary_offences).

%% person_danger(PersonId, inhibit_explanations_coaccused)
%
% The person poses a danger by inhibiting explanations from co-accused individuals
%
person_danger(PersonId, inhibit_explanations_coaccused).

%% person_danger(PersonId, inhibit_testimonies)
%
% The person poses a danger by inhibiting testimonies
%
person_danger(PersonId, inhibit_testimonies).
"""


dir_facts = {
    "directive_2010_64" : facts_dir_2010_64,
    "directive_2013_48" : facts_dir_2013_48,
    "directive_2012_13" : facts_dir_2012_13,
    "directive_2016_343": facts_dir_2016_343
}

national_facts = {
    "directive_2010_64" : {
        "it" : facts_dir_2010_64_it,
        "pl" : facts_dir_2010_64_pl,
        "nl" : facts_dir_2010_64_nl,
        "bg" : facts_dir_2010_64_bg
    },
    "directive_2013_48" : {
        "it" : facts_dir_2013_48_it,
        "pl" : "",
        "nl" : facts_dir_2013_48_nl,
        "bg" : ""
    },
    "directive_2012_13" : {
        "it" : facts_dir_2012_13_it,
        "pl" : facts_dir_2012_13_pl,
        "nl" : facts_dir_2012_13_nl,
        "bg" : facts_dir_2012_13_bg
    },
    "directive_2016_343" : {
        "it" : facts_dir_2016_343_it,
        "pl" : facts_dir_2016_343_pl,
        "nl" : facts_dir_2016_343_nl,
        "bg" : facts_dir_2016_343_bg
    }
}