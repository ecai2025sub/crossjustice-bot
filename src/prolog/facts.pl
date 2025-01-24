:- module(facts, []).

%% assistance_lawyer_not_proportionate(PersonId)
%
% With regard to the child's interest, lawyer is not needed due to severity of the offence
%

assistance_lawyer_not_proportionate(PersonId).

%% authority_decision(HolderId, _nomination)
%
% The authority has nominated a new holder of parental responsibility
%

authority_decision(HolderId, nomination).

%% authority_decision(PersonId, _absolute_urgency)
%
% The authority can interrogate without lawyer in urgent cases - IT
%

authority_decision(PersonId, absolute_urgency).

%% authority_decision(PersonId, _accepted)
%
% The authority has accepted the nomination of the child concerning the holder of parental responsibility
%

authority_decision(PersonId, accepted).

%% authority_decision(PersonId, _access_materials)
%
% The authority has allowed the parties to access documents of the case - IT
%

authority_decision(PersonId, access_materials).

%% authority_decision(PersonId, _access_to_counsel)
%
% The authority has deemed necessary the presence of the lawyer
%

authority_decision(PersonId, access_to_counsel).

%% authority_decision(PersonId, _appearance_mandatory)
%
% The authority has decreed the presence of the accused mandatory in court
%

authority_decision(PersonId, appearance_mandatory).

%% authority_decision(PersonId, _authorized)
%
% The authority has authorized visits to convicted persons
%

authority_decision(PersonId, authorized).

%% authority_decision(PersonId, _check_evidence)
%
% The authority has authorized the parties to check a piece of evidence
%

authority_decision(PersonId, check_evidence).

%% authority_decision(PersonId, _confidant)
%
% The authority has deemed the confidant to be appropriate
%

authority_decision(PersonId, confidant).

%% authority_decision(PersonId, _custody_established)
%
% If there is no parents to take responsibility, the authority establishes it
%

authority_decision(PersonId, custody_established).

%% authority_decision(PersonId, _denied_access)
%
% The authority has denied access to the files of preparatory proceedings
%

authority_decision(PersonId, denied_access).

%% authority_decision(PersonId, _deny_lawyer)
%
% The authority has denied the lawyer to participate in the defendant's questioning
%

authority_decision(PersonId, deny_lawyer).

%% authority_decision(PersonId, _deny_participation)
%
% The authority has denied the lawyer to access an investigation procedure
%

authority_decision(PersonId, deny_participation).

%% authority_decision(PersonId, _essential_document)
%
% The authority has decreed any document to be essential
%

authority_decision(PersonId, essential_document).

%% authority_decision(PersonId, _exceptional_reasons_caution)
%
% The authority has deferred the right to consult with a lawyer due to exceptional reasons
%

authority_decision(PersonId, exceptional_reasons_caution).

%% authority_decision(PersonId, _grounds_to_consider_communication_corpus_delicti)
%
% The authority has decreed that the communication can be considered corpus delicti
%

authority_decision(PersonId, grounds_to_consider_communication_corpus_delicti).

%% authority_decision(PersonId, _guardianship)
%
% The guardianship court has established a guardian for the child
%

authority_decision(PersonId, guardianship).

%% authority_decision(PersonId, _permission_given)
%
% The authority has permitted the person to meet with the next of kin
%

authority_decision(PersonId, permission_given).

%% authority_decision(PersonId, _person_is_child)
%
% The authority has decided that a person is to be considered a child
%

authority_decision(PersonId, person_is_child).

%% authority_decision(PersonId, _postal_supervision)
%
% The authority has decided to exercise supervion over the letters and items
%

authority_decision(PersonId, postal_supervision).

%% authority_decision(PersonId, _translation_needed)
%
% The authority has decided that a document needs to be translated
%

authority_decision(PersonId, translation_needed).

%% authority_nominates(PersonId, HolderId)
%
% The authority has nominated someone to accompany the child as responsibility holder
%

authority_nominates(PersonId, HolderId).

%% contrary_to_child_interest(HolderId)
%
% The person is acting contrary to the interests of the child
%

contrary_to_child_interest(HolderId).

%% contrary_to_child_interest(PersonId)
%
% The person is acting contrary to the interests of the child
%

contrary_to_child_interest(PersonId).

%% directive_application_appropriate(PersonId)
%
% Application of the Dir 2016/800 is appropriate with regard to circumstances of the case
%

directive_application_appropriate(PersonId).

%% essential_document(_, PersonId, _documents)
%
% The document is essential
%

essential_document(_, PersonId, documents).

%% expert_decision(PersonId, _no_decision)
%
% Experts could not decide with regard to the age of the child
%

expert_decision(PersonId, no_decision).

%% expert_decision(PersonId, _person_is_child)
%
% Experts have decided that the person is a child
%

expert_decision(PersonId, person_is_child).

%% familiarise_with_evidence_content(PersonId, _translation)
%
% There is a need to familiarise a party with the content of the evidence
%

familiarise_with_evidence_content(PersonId, translation).

%% holder_nomination(ChildId, HolderId)
%
% The child has nominated someone as holder of parental responsibility
%

holder_nomination(ChildId, HolderId).

%% holds_parental_responsibility(HolderId, ChildId)
%
% This person holds parental responsibility over the child
%

holds_parental_responsibility(HolderId, ChildId).

%% holds_parental_responsibility(HolderId, PersonId)
%
% This person holds parental responsibility over the child
%

holds_parental_responsibility(HolderId, PersonId).

%% holds_parental_responsibility(PersonId, ChildId)
%
% This person holds parental responsibility over the child
%

holds_parental_responsibility(PersonId, ChildId).

%% imperative_immediate_action(PersonId, _investigating_authority)
%
% Investigating authority must intervene to avoid jeopardising the proceedings
%

imperative_immediate_action(PersonId, investigating_authority).

%% jeopardises_proceedings(HolderId)
%
% This person's acting jeopardises the proceedings
%

jeopardises_proceedings(HolderId).

%% jeopardises_proceedings(PersonId)
%
% This person's acting jeopardises the proceedings
%

jeopardises_proceedings(PersonId).

%% jeopardises_proceedings(PersonId2)
%
% This person's acting jeopardises the proceedings
%

jeopardises_proceedings(PersonId2).

%% jeopardises_proceedings(_parent)
%
% This person's acting jeopardises the proceedings
%

jeopardises_proceedings(parent).

%% lawyer_language(PersonId, Language)
%
% The lawyer can speak, read and understand this language
%

lawyer_language(PersonId, Language).

%% lawyer_language(PersonId, _italian)
%
% The lawyer can speak, read and understand italian
%

lawyer_language(PersonId, italian).

%% member_states_decision(PersonId, _directive_2016_800_does_not_apply)
%
% Member States have decided not to apply the directive 2016/800
%

member_states_decision(PersonId, directive_2016_800_does_not_apply).

%% nationalLawApplies(Article, PersonId, Matter)
%
% Need to change this predicate, check OG article
%

nationalLawApplies(Article, PersonId, Matter).

%% person_age(PersonId, Age)
%
% The person is X years of age
%

person_age(PersonId, Age).

%% person_age(PersonId, Age, _start_proceeding)
%
% The person was X years of age at the start of the proceedings
%

person_age(PersonId, Age, start_proceeding).

%% person_age(PersonId, Age2)
%
% The person is X years of age
%

person_age(PersonId, Age2).

%% person_age(PersonId, X)
%
% The person is X years of age
%

person_age(PersonId, X).

%% person_age(PersonId, X, _act_committed)
%
% The person is was years of age at the moment he committed the offence
%

person_age(PersonId, X, act_committed).

%% person_age(PersonId, _)
%
% The person is X years of age
%

person_age(PersonId, _).

%% person_age(PersonId, _, _act_committed)
%
% The person was X years of age at the moment he committed the offence
%

person_age(PersonId, _, act_committed).

%% person_age(PersonId, _cannot_be_more_14)
%
% The person cannot be more than 14 years of age
%

person_age(PersonId, cannot_be_more_14).

%% person_challenges_decision(PersonId, _essential_document)
%
% The person has challenged the decision to consider a document not essential
%

person_challenges_decision(PersonId, essential_document).

%% person_challenges_decision(PersonId, _interpretation)
%
% The person has challenged the decision to not allow the interpreter
%

person_challenges_decision(PersonId, interpretation).

%% person_circumstances(PersonId, _condition_requires_treatment)
%
% The person requires permanent or periodic treatment
%

person_circumstances(PersonId, condition_requires_treatment).

%% person_circumstances(PersonId, _force_majeur)
%
% The person's absence at his hearing is due to force majeur
%

person_circumstances(PersonId, force_majeur).

%% person_circumstances(PersonId, _inculpable_absence)
%
% The person's absence at his trial was due to inculpable unawareness
%

person_circumstances(PersonId, inculpable_absence).

%% person_circumstances(PersonId, _legal_impediment)
%
% The person's absence at his hearing is due to a legal impediment
%

person_circumstances(PersonId, legal_impediment).

%% person_circumstances(PersonId, _necessary)
%
% It is necessary for a minor to be placed in temporary detention
%

person_circumstances(PersonId, necessary).

%% person_circumstances(PersonId, _need_to_acquire_information)
%
% It is necessary to do an assessment to acquire information on defendant
%

person_circumstances(PersonId, need_to_acquire_information).

%% person_circumstances(PersonId, _probable_guilt)
%
% It is highly probable that the accused has committed the offence
%

person_circumstances(PersonId, probable_guilt).

%% person_circumstances(PersonId, _state_of_emergency)
%
% The person is in need of emergency medical services
%

person_circumstances(PersonId, state_of_emergency).

%% person_circumstances(PersonId, _unforeseeable)
%
% The person's absence at his hearing is due to unforeseeable circumenstances
%

person_circumstances(PersonId, unforeseeable).

%% person_circumstances(PersonId, _visible_injuries)
%
% The person suffers from visible injuries
%

person_circumstances(PersonId, visible_injuries).

%% person_condition(PersonId, _blind)
%
% The person is blind
%

person_condition(PersonId, blind).

%% person_condition(PersonId, _deaf)
%
% The person is deaf
%

person_condition(PersonId, deaf).

%% person_condition(PersonId, _hearingImpediment)
%
% The person suffers from a hearing impediment
%

person_condition(PersonId, hearingImpediment).

%% person_condition(PersonId, _hearingSpeechImpediments)
%
% The person suffers from a hearing or speech impediment
%

person_condition(PersonId, hearingSpeechImpediments).

%% person_condition(PersonId, _mental_disability)
%
% The person suffers from a mental disability
%

person_condition(PersonId, mental_disability).

%% person_condition(PersonId, _mental_disability, _act_committed)
%
% The person suffered from a mental disability at the moment he committed the offence
%

person_condition(PersonId, mental_disability, act_committed).

%% person_condition(PersonId, _mute)
%
% The person is mute
%

person_condition(PersonId, mute).

%% person_condition(PersonId, _sensoryDisability)
%
% The person suffers from a sensory disability
%

person_condition(PersonId, sensoryDisability).

%% person_condition(PersonId, _speechImpediment)
%
% The person suffers from a speech impediment
%

person_condition(PersonId, speechImpediment).

%% person_danger(PersonId, _another_offence)
%
% There is danger that the person may commit another offence
%

person_danger(PersonId, another_offence).

%% person_danger(PersonId, _commit_incite_offence)
%
% There is need to avoid the danger that a meeting shall be used to commit or incite an offence
%

person_danger(PersonId, commit_incite_offence).

%% person_danger(PersonId, _prevent_contact_third_parties)
%
% There is danger that the person may enter into contact with third parties
%

person_danger(PersonId, prevent_contact_third_parties).

%% person_danger(PersonId, _links_to_criminal_circles)
%
% There is danger to enter into contact with criminal circles
%

person_danger(PersonId, links_to_criminal_circles).

%% person_danger(PersonId, _escape)
%
% There is need to avoid the escape of a person
%

person_danger(PersonId, escape).

%% person_danger(PersonId, _flight_risk)
%
% There is need to avoid the danger of the person being a flight risk
%

person_danger(PersonId, flight_risk).

%% person_danger(PersonId, _fundamental_rights)
%
% There is need to avoid damage to the fundamental rights of any person
%

person_danger(PersonId, fundamental_rights).

%% person_danger(PersonId, _hinder_criminal_proceedings)
%
% There is need to avoid the danger that a meeting shall be used to hinder the criminal proceedings
%

person_danger(PersonId, hinder_criminal_proceedings).

%% person_danger(PersonId, _inhibit_explanations_coaccused)
%
% There is need to avoid the danger that the presence of the accused may inhibit the explanations of a coaccused
%

person_danger(PersonId, inhibit_explanations_coaccused).

%% person_danger(PersonId, _inhibit_testimonies)
%
% There is need to avoid the danger that the presence of the accused may inhibit the explanations of a witness
%

person_danger(PersonId, inhibit_testimonies).

%% person_danger(PersonId, _liberty)
%
% There is need to avoid damage to a person's liberty
%

person_danger(PersonId, liberty).

%% person_danger(PersonId, _life)
%
% There is need to avoid damage to a person's life
%

person_danger(PersonId, life).

%% person_danger(PersonId, _physical_integrity)
%
% There is need to avoid damage to a person's physical integrity
%

person_danger(PersonId, physical_integrity).

%% person_danger(PersonId, _proper_conduct_proceedings)
%
% There is a need to secure the proper conduct of the proceedings
%

person_danger(PersonId, proper_conduct_proceedings).

%% person_danger(PersonId, _public_interest)
%
% There is a need to secure the public interest of the proceedings
%

person_danger(PersonId, public_interest).

%% person_danger(PersonId, _safety)
%
% There is need to avoid damage to a person's safety
%

person_danger(PersonId, safety).

%% person_danger(PersonId, _security_reasons)
%
% There is danger to the security of the person
%

person_danger(PersonId, security_reasons).

%% person_danger(PersonId, _violence_risk)
%
% There is need to avoid the danger of the person being a violence risk
%

person_danger(PersonId, violence_risk).

%% person_document(PersonId, _appeal_resolution)
%
% The document issued is the resolution of the appeal
%

person_document(PersonId, appeal_resolution).

%% person_document(PersonId, _challenge_arrest)
%
% The document issued is needed to challenge the arrest
%

person_document(PersonId, challenge_arrest).

%% person_document(PersonId, _challenge_detention)
%
% The document issued is needed to challenge the detention
%

person_document(PersonId, challenge_detention).

%% person_document(PersonId, _charge)
%
% The document issued is the charge
%

person_document(PersonId, charge).

%% person_document(PersonId, _decision_changing_charge)
%
% The document issued is the decision changing the charge
%

person_document(PersonId, decision_changing_charge).

%% person_document(PersonId, _decision_precautionary_measure)
%
% The document issued is the decision on precautionary measure
%

person_document(PersonId, decision_precautionary_measure).

%% person_document(PersonId, _decision_supplementing_charge)
%
% The document issued is the decision supplementing the charge
%

person_document(PersonId, decision_supplementing_charge).

%% person_document(PersonId, _decree_committal_court_hearing)
%
% The document issued is the decree on the committal to court hearing
%

person_document(PersonId, decree_committal_court_hearing).

%% person_document(PersonId, _decree_conviction)
%
% The document issued is the decree on the conviction
%

person_document(PersonId, decree_conviction).

%% person_document(PersonId, _decree_preliminary_hearing)
%
% The document issued is the decree on preliminary hearing
%

person_document(PersonId, decree_preliminary_hearing).

%% person_document(PersonId, _decree_trial_summons)
%
% The document issued is decree for the summon at trial
%

person_document(PersonId, decree_trial_summons).

%% person_document(PersonId, _document_deprives_liberty)
%
% The document issued is any document that deprives liberty
%

person_document(PersonId, document_deprives_liberty).

%% person_document(PersonId, _europeanArrestWarrant)
%
% The document issued is the european arrest warrant
%

person_document(PersonId, europeanArrestWarrant).

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

%% person_document(PersonId, _new_evidence)
%
% The document issued provides new evidence to the case
%

person_document(PersonId, new_evidence).

%% person_document(PersonId, _notice_conclusion_investigation)
%
% The document issued is the notice of the conclusion of the investigation
%

person_document(PersonId, notice_conclusion_investigation).

%% person_document(PersonId, _notice_of_investigation)
%
% The document issued is the notice of the start of the investigation
%

person_document(PersonId, notice_of_investigation).

%% person_document(PersonId, _notice_of_right_to_defence)
%
% The document issued is the notice that informs of the right to defense
%

person_document(PersonId, notice_of_right_to_defence).

%% person_document(PersonId, _order_precautionary_detention)
%
% The document issued is the order of precautionary detention
%

person_document(PersonId, order_precautionary_detention).

%% person_document(PersonId, _request_discontinuation_proceedings)
%
% The document issued is a request for the discontinuation of the proceedings
%

person_document(PersonId, request_discontinuation_proceedings).

%% person_document(PersonId, _sentence)
%
% The document issued is the sentence
%

person_document(PersonId, sentence).

%% person_document(PersonId, _statement, _appoint_lawyer)
%
% The person has asked a lawyer to be appointed through a statement to the authority
%

person_document(PersonId, statement, appoint_lawyer).

%% person_document(PersonId, _translation_needed)
%
% The document issued needs to be translated
%

person_document(PersonId, translation_needed).

%% person_domicile(PersonId, Country)
%
% The person is domiciled in country X
%

person_domicile(PersonId, Country).

%% person_event(PersonId, _attend_confrontation)
%
% The person has requested to attend or attended the confrontation
%

person_event(PersonId, attend_confrontation).

%% person_event(PersonId, _attend_idendity_parade)
%
% he person has requested to attend or attended the identity parade
%

person_event(PersonId, attend_idendity_parade).

%% person_event(PersonId, _attend_investigative_act)
%
% he person has requested to attend or attended any investigative act
%

person_event(PersonId, attend_investigative_act).

%% person_event(PersonId, _attend_reconstructions_crime_scene)
%
% he person has requested to attend or attended the reconstruction of a crime scene
%

person_event(PersonId, attend_reconstructions_crime_scene).

%% person_event(PersonId, _breach_of_rights)
%
% The person's rights have been breached
%

person_event(PersonId, breach_of_rights).

%% person_event(PersonId, _cannot_be_located)
%
% The person cannot be located
%

person_event(PersonId, cannot_be_located).

%% person_event(PersonId, _convicted_tax_evasion)
%
% The person has been convicted for tax evasion
%

person_event(PersonId, convicted_tax_evasion).

%% person_event(PersonId, _gave_consent)
%
% The person has given his consent to have his picture published while handcuffed or otherwise restrained
%

person_event(PersonId, gave_consent).

%% person_event(PersonId, _geographical_remoteness)
%
% The person's geographical remoteness makes it impossible to ensure no delay to the presence of the lawyer
%

person_event(PersonId, geographical_remoteness).

%% person_event(PersonId, _incapable_to_participate)
%
% The person has rendered himself incapable of participating in a trial or hearing
%

person_event(PersonId, incapable_to_participate).

%% person_event(PersonId, _informed_consequences_absence)
%
% The person has been informed of the consequences of his absence at the trial
%

person_event(PersonId, informed_consequences_absence).

%% person_event(PersonId, _make_statements)
%
% The person has been asked to make a statement
%

person_event(PersonId, make_statements).

%% person_event(PersonId, _not_appear_hearing)
%
% The person has not appeared at his hearing
%

person_event(PersonId, not_appear_hearing).

%% person_event(PersonId, _represented_by_lawyer)
%
% The person has been represented by a lawyer at the trial
%

person_event(PersonId, represented_by_lawyer).

%% person_event(PersonId, _share_householder)
%
% The person shares a household with one or more persons
%

person_event(PersonId, share_householder).

%% person_event(PersonId, _single_householder)
%
% The person is the single owner of a household
%

person_event(PersonId, single_householder).

%% person_event(PersonId, _surrender)
%
% The person has surrendered to the national authority
%

person_event(PersonId, surrender).

%% person_event(PersonId, _waive_right)
%
% The person has decided to waive a right
%

person_event(PersonId, waive_right).

%% person_family_assistant(HolderId)
%
% A family assistant has been required to accompany a minor to an interview
%

person_family_assistant(HolderId).

%% person_family_foster_care(HolderId)
%
% A coordinator of family foster care has been required to accompany a minor to an interview
%

person_family_foster_care(HolderId).

%% person_income(PersonId, X)
%
% The income of the person is X
%

person_income(PersonId, X).

%% person_language(PersonId, Language)
%
% The person speaks, reads and understands language X
%

person_language(PersonId, Language).

%% person_language(PersonId, _polish)
%
% The person speaks, reads and understands polish
%

person_language(PersonId, polish).

%% person_language_unknown_verified_by(PersonId, _italian, _judicialAuthority)
%
% The judicial authority has verified that the person speaks, reads and understands italian
%

person_language_unknown_verified_by(PersonId, italian, judicialAuthority).

%% person_made_aware(PersonId, _personStatus)
%
% The person has been made aware of his status
%

person_made_aware(PersonId, personStatus).

%% person_nationality(PersonId, Country)
%
% The person is of nationality X
%

person_nationality(PersonId, Country).

%% person_nationality(PersonId, _dutch)
%
% The person is a dutch citizen
%

person_nationality(PersonId, dutch).

%% person_nationality(PersonId, _italian)
%
% The person is an italian citizen
%

person_nationality(PersonId, italian).

%% person_nationality(PersonId, _none)
%
% The person does not have a citizenship
%

person_nationality(PersonId, none).

%% person_nationality(PersonId, _polish)
%
% The person is a polish citizen
%

person_nationality(PersonId, polish).

%% person_nationality(PersonId, _stateless)
%
% The person is stateless
%

person_nationality(PersonId, stateless).

%% person_nature(PersonId, _legal)
%
% The person is a legal person
%

person_nature(PersonId, legal).

%% person_nature(PersonId, _natural)
%
% The person is a natural person
%

person_nature(PersonId, natural).

%% person_nominate(PersonId, PersonId2)
%
% The person has nominated X as a third person to communicate with
%

person_nominate(PersonId, PersonId2).

%% person_organization_representative(HolderId)
%
% A representative of a social organization has been required to accompany a minor to an interview
%

person_organization_representative(HolderId).

%% person_punishment(PersonId, _community_service_less_22)
%
% The possible punishment of the person shall be no more than 22 hours of community service
%

person_punishment(PersonId, community_service_less_22).

%% person_punishment(PersonId, _compensation_more_euros_200)
%
% The possible punishment of the person shall be at least a compensation of 200 euros or more
%

person_punishment(PersonId, compensation_more_euros_200).

%% person_punishment(PersonId, _fine_max_250_euros)
%
% The punishment upon the person was a fine of not more than 250 euros
%

person_punishment(PersonId, fine_max_250_euros).

%% person_punishment(PersonId, _fine_max_50_euros)
%
% The punishment upon the person was a fine of not more than 50 euros
%

person_punishment(PersonId, fine_max_50_euros).

%% person_punishment(PersonId, _fines)
%
% The possible punishment of the person shall be at least a fine
%

person_punishment(PersonId, fines).

%% person_punishment(PersonId, _not_imposed)
%
% A punishment or any other measure was not imposed during the decision of first istance
%

person_punishment(PersonId, not_imposed).

%% person_request_submitted(HolderId, _medical_exam)
%
% The holder of parental responsibility has submitted a request to perform a medical exam
%

person_request_submitted(HolderId, medical_exam).

%% person_request_submitted(PersonId, RequestMatter)
%
% The person has submitted a request for matter X during preliminary investigation
%

person_request_submitted(PersonId, RequestMatter).

%% person_request_submitted(PersonId, _access_materials)
%
% The person has submitted a request to access the materials of the case
%

person_request_submitted(PersonId, access_materials).

%% person_request_submitted(PersonId, _appoint_lawyer)
%
% The person has submitted a request to appoint a lawyer
%

person_request_submitted(PersonId, appoint_lawyer).

%% person_request_submitted(PersonId, _check_evidence)
%
% The person has submitted a request to check a piece of evidence
%

person_request_submitted(PersonId, check_evidence).

%% person_request_submitted(PersonId, _communicate_consul)
%
% The person has submitted a request to communicate with the consul
%

person_request_submitted(PersonId, communicate_consul).

%% person_request_submitted(PersonId, _conduct_investigation_procedure)
%
% The person has submitted a request to conduct an investigative procedure
%

person_request_submitted(PersonId, conduct_investigation_procedure).

%% person_request_submitted(PersonId, _defence_counsel)
%
% The person has submitted a request to communicate with his defence counsel
%

person_request_submitted(PersonId, defence_counsel).

%% person_request_submitted(PersonId, _diplomat)
%
% The person has submitted a request to communicate with a diplomat
%

person_request_submitted(PersonId, diplomat).

%% person_request_submitted(PersonId, _essential_document)
%
% The person has submitted a request to consider a document to be essential
%

person_request_submitted(PersonId, essential_document).

%% person_request_submitted(PersonId, _inform_person)
%
% The person has submitted a request to inform a person of his arrest
%

person_request_submitted(PersonId, inform_person).

%% person_request_submitted(PersonId, _lawyer_medical_exam)
%
% The person's lawyer has submitted a request to perform a medical exam
%

person_request_submitted(PersonId, lawyer_medical_exam).

%% person_request_submitted(PersonId, _lawyer_participation)
%
% The person has submitted a request to have the lawyer participate during questioning
%

person_request_submitted(PersonId, lawyer_participation).

%% person_request_submitted(PersonId, _medical_assistance)
%
% The person has submitted a request to receive medical assistance
%

person_request_submitted(PersonId, medical_assistance).

%% person_request_submitted(PersonId, _medical_exam)
%
% The person has submitted a request to perform a medical exam
%

person_request_submitted(PersonId, medical_exam).

%% person_request_submitted(PersonId, _new_notice)
%
% The person has submitted a request to notify a new person of the decision on detention
%

person_request_submitted(PersonId, new_notice).

%% person_request_submitted(PersonId, _participate_investigation)
%
% The person has submitted a request to participate in the investigation procedure
%

person_request_submitted(PersonId, participate_investigation).

%% person_request_submitted(PersonId, _postponement)
%
% The person has submitted a request to postpone the hearing of his case
%

person_request_submitted(PersonId, postponement).

%% person_request_submitted(PersonId, _present_trial)
%
% The person has submitted a request to be present at the trial
%

person_request_submitted(PersonId, present_trial).

%% person_request_submitted(PersonId, _private_hearing)
%
% The person has submitted a request to conduct a private hearing
%

person_request_submitted(PersonId, private_hearing).

%% person_request_submitted(PersonId, _public_hearing)
%
% The person has submitted a request to conduct a public hearing
%

person_request_submitted(PersonId, public_hearing).

%% person_request_submitted(PersonId, _replace_lawyer)
%
% The person has submitted a request to be appointed a new lawyer
%

person_request_submitted(PersonId, replace_lawyer).

%% person_request_submitted(PersonId, _waive_right)
%
% The person has submitted a request to waive one of his rights
%

person_request_submitted(PersonId, waive_right).

%% person_residence(PersonId, Country)
%
% The person's residence is in country X
%

person_residence(PersonId, Country).

%% person_school_representative(HolderId)
%
% A representative of the school has been required to accompany a minor to an interview
%

person_school_representative(HolderId).

%% person_status(HolderId, _holder_of_parental_responsibility)
%
% The person is an holder of parental responsibility
%

person_status(HolderId, holder_of_parental_responsibility).

%% person_status(PersonId, _accused)
%
% The person is an accused
%

person_status(PersonId, accused).

%% person_status(PersonId, _age_unknown)
%
% The person's age is unknown
%

person_status(PersonId, age_unknown).

%% person_status(PersonId, _arrested)
%
% The person has been arrested
%

person_status(PersonId, arrested).

%% person_status(PersonId, _cannot_bear_costs)
%
% The person cannot bear the costs of the proceedings
%

person_status(PersonId, cannot_bear_costs).

%% person_status(PersonId, _child)
%
% The person is a child
%

person_status(PersonId, child).

%% person_status(PersonId, _convicted)
%
% The person has been convicted
%

person_status(PersonId, convicted).

%% person_status(PersonId, _deprived_of_liberty)
%
% The person has been deprived of liberty
%

person_status(PersonId, deprived_of_liberty).

%% person_status(PersonId, _detained)
%
% The person has been detained
%

person_status(PersonId, detained).

%% person_status(PersonId, _detained_on_remand)
%
% The person has been detained on remand
%

person_status(PersonId, detained_on_remand).

%% person_status(PersonId, _holder_of_parental_responsibility)
%
% The person is an holder of parental responsibility
%

person_status(PersonId, holder_of_parental_responsibility).

%% person_status(PersonId, _house_arrest)
%
% The person is under house arrest
%

person_status(PersonId, house_arrest).

%% person_status(PersonId, _imprisoned)
%
% The person has been imprisoned
%

person_status(PersonId, imprisoned).

%% person_status(PersonId, _indigent)
%
% The person is an indigent
%

person_status(PersonId, indigent).

%% person_status(PersonId, _informed_about_charge)
%
% The person has been informed about the charge
%

person_status(PersonId, informed_about_charge).

%% person_status(PersonId, _informed_consequences)
%
% The person has been informed of the consequences of waiving a right
%

person_status(PersonId, informed_consequences).

%% person_status(PersonId, _injured)
%
% The person has been injured
%

person_status(PersonId, injured).

%% person_status(PersonId, _inmate)
%
% The person is an inmate
%

person_status(PersonId, inmate).

%% person_status(PersonId, _need_medical_assistance)
%
% The person needs medical assistance
%

person_status(PersonId, need_medical_assistance).

%% person_status(PersonId, _non_wealthy)
%
% The person is not wealthy
%

person_status(PersonId, non_wealthy).

%% person_status(PersonId, _offended)
%
% This person has been offended by a criminal offence
%

person_status(PersonId, offended).

%% person_status(PersonId, _parent)
%
% The person is the parent of the defendant
%

person_status(PersonId, parent).

%% person_status(PersonId, _party_to_proceeding)
%
% The person is a party to the proceedings
%

person_status(PersonId, party_to_proceeding).

%% person_status(PersonId, _police_custody)
%
% The person is in police custody
%

person_status(PersonId, police_custody).

%% person_status(PersonId, _priorAdviceReceived)
%
% The person has received prior legal advice on the case and consequences of the waiver
%

person_status(PersonId, priorAdviceReceived).

%% person_status(PersonId, _priorInformationReceived)
%
% The person has received prior legal advice on the case and consequences of the waiver
%

person_status(PersonId, priorInformationReceived).

%% person_status(PersonId, _prisoner)
%
% The person is a prisoner
%

person_status(PersonId, prisoner).

%% person_status(PersonId, _raise_suspicion)
%
% The person has raised suspicions of guilt
%

person_status(PersonId, raise_suspicion).

%% person_status(PersonId, _requested)
%
% The person is requested under an european arrest warrant
%

person_status(PersonId, requested).

%% person_status(PersonId, _require_lawyer_assistance)
%
% The person requires the assistance of the lawyer
%

person_status(PersonId, require_lawyer_assistance).

%% person_status(PersonId, _security_measure)
%
% The person is under a security measure
%

person_status(PersonId, security_measure).

%% person_status(PersonId, _specific_health_indications)
%
% The person is in need of specific health indications
%

person_status(PersonId, specific_health_indications).

%% person_status(PersonId, _subject_to_proceedings)
%
% The person is the subject of the proceedings
%

person_status(PersonId, subject_to_proceedings).

%% person_status(PersonId, _subject_to_questioning)
%
% The person is subject to questioning
%

person_status(PersonId, subject_to_questioning).

%% person_status(PersonId, _suspect)
%
% The person is a suspect
%

person_status(PersonId, suspect).

%% person_status(PersonId, _temporarily_detained)
%
% The person has been temporarily detained
%

person_status(PersonId, temporarily_detained).

%% person_status(PersonId, _temporary_custody)
%
% The person is in temporary custody
%

person_status(PersonId, temporary_custody).

%% person_status(PersonId, _temporary_detention)
%
% The person is in temporary detention
%

person_status(PersonId, temporary_detention).

%% person_status(PersonId, _under_custody)
%
% The person is in custody
%

person_status(PersonId, under_custody).

%% person_status(PersonId, _vulnerable)
%
% The person is vulnerable
%

person_status(PersonId, vulnerable).

%% person_status(PersonId, _witness)
%
% The person is a witness
%

person_status(PersonId, witness).

%% person_status(PersonId2, _significant_emotional_connection)
%
% The person is a significant emotional connection to the defendant
%

person_status(PersonId2, significant_emotional_connection).

%% person_status_poland(PersonId, _accused)
%
% The person is an accused under the polish definition
%

person_status_poland(PersonId, accused).

%% person_status_poland(PersonId, _suspect)
%
% The person is a suspect under the polish definition
%

person_status_poland(PersonId, suspect).

%% person_taxable_income(PersonId, X)
%
% The person's taxable income is X
%

person_taxable_income(PersonId, X).

%% person_understands(PersonId, Language)
%
% The person reads and understands language X
%

person_understands(PersonId, Language).

%% physical_presence_required(PersonId, _interpreter, _correct_exercise_right)
%
% The presence of the interpreter is required for the correct exercise of the right to defence
%

physical_presence_required(PersonId, interpreter, correct_exercise_right).

%% physical_presence_required(PersonId, _interpreter, _safeguard_fairness)
%
% The presence of the interpreter is required for safeguarding the fairness of the proceedings
%

physical_presence_required(PersonId, interpreter, safeguard_fairness).

%% physical_presence_required(PersonId, _interpreter, _safeguard_rights)
%
% The presence of the interpreter is required for safeguarding the rights of the defendant
%

physical_presence_required(PersonId, interpreter, safeguard_rights).

%% physical_presence_required(PersonId, _lawyer)
%
% The presence of the lawyer is required
%

physical_presence_required(PersonId, lawyer).

%% proceeding_circumstance(PersonId, _necessary_investigation)
%
% The restriction is necessary for the investigation
%

proceeding_circumstance(PersonId, necessary_investigation).

%% proceeding_circumstances(PersonId, _absence_justified)
%
% The evidentiary proceedings may continue even in the absence of the accused
%

proceeding_circumstances(PersonId, absence_justified).

%% proceeding_country(PersonId, Country)
%
% The proceedings are located in country X
%

proceeding_country(PersonId, Country).

%% proceeding_danger(PersonId, _substantially_jeopardised)
%
% There is danger of the proceedings being substantially jeopardised
%

proceeding_danger(PersonId, substantially_jeopardised).

%% proceeding_event(PersonId, _can_claim_aid_for_previous_assignment)
%
% The person may claim legal aid on the basis of a previous assignment
%

proceeding_event(PersonId, can_claim_aid_for_previous_assignment).

%% proceeding_event(PersonId, _cannot_parent_notified)
%
% The person's parents cannot be notified
%

proceeding_event(PersonId, cannot_parent_notified).

%% proceeding_event(PersonId, _child_interest)
%
% The authority is acting in the interests of the child
%

proceeding_event(PersonId, child_interest).

%% proceeding_event(PersonId, _contrary_to_interest)
%
% The procedure is contrary to the interests of the person
%

proceeding_event(PersonId, contrary_to_interest).

%% proceeding_event(PersonId, _costs_not_proportionate)
%
% The costs of legal aid are not proportionate to the significance of the offence
%

proceeding_event(PersonId, costs_not_proportionate).

%% proceeding_event(PersonId, _disrupt_order)
%
% Granting the person's request may disrupt the order of the proceedings
%

proceeding_event(PersonId, disrupt_order).

%% proceeding_event(PersonId, _exceed_indictment_limits)
%
% The change in accusation exceedds the limits of the indictment
%

proceeding_event(PersonId, exceed_indictment_limits).

%% proceeding_event(PersonId, _execution_perspective_plan)
%
% The authority is acting for the execution of a perspective plan
%

proceeding_event(PersonId, execution_perspective_plan).

%% proceeding_event(PersonId, _impossible_to_notice)
%
% It is impossible to serve the person the notice
%

proceeding_event(PersonId, impossible_to_notice).

%% proceeding_event(PersonId, _institution_safety)
%
% The authority is acting for the safety of the institutions
%

proceeding_event(PersonId, institution_safety).

%% proceeding_event(PersonId, _investigation_criminal_offence)
%
% The authority is acting for investigating a criminal offence
%

proceeding_event(PersonId, investigation_criminal_offence).

%% proceeding_event(PersonId, _lawyer_present)
%
% The lawyer is present at the procedure
%

proceeding_event(PersonId, lawyer_present).

%% proceeding_event(PersonId, _legal_aid_provided)
%
% Legal aid has already been provided to the person
%

proceeding_event(PersonId, legal_aid_provided).

%% proceeding_event(PersonId, _legal_aid_request_devoid_fundation)
%
% The request of legal aid is devoid of any fundation
%

proceeding_event(PersonId, legal_aid_request_devoid_fundation).

%% proceeding_event(PersonId, _national_security)
%
% The authority is acting in the interest of national security
%

proceeding_event(PersonId, national_security).

%% proceeding_event(PersonId, prejudice_fairness)
%
% The procedure does prejudice the fairness of the proceedings
%

proceeding_event(PersonId, prejudice_fairness).

%% proceeding_event(PersonId, _personality_subject)
%
% The circumstances concerning the personality of the subject require audiovisual recording
%

proceeding_event(PersonId, personality_subject).

%% proceeding_event(PersonId, _prejudice)
%
% The procedure does prejudice the proceedings
%

proceeding_event(PersonId, prejudice).

%% proceeding_event(PersonId, _present_court_session)
%
% The person is present at the court session
%

proceeding_event(PersonId, present_court_session).

%% proceeding_event(PersonId, _present_judgement)
%
% The person is present for the pronouncement of the judgement
%

proceeding_event(PersonId, present_judgement).

%% proceeding_event(PersonId, _prevent_criminal_offence)
%
% The authority is acting to prevent a criminal offence
%

proceeding_event(PersonId, prevent_criminal_offence).

%% proceeding_event(PersonId, _problem_easily_settled)
%
% The issues concerning the case are easily settles
%

proceeding_event(PersonId, problem_easily_settled).

%% proceeding_event(PersonId, _public_order)
%
% The authority is acting to preserve the public order
%

proceeding_event(PersonId, public_order).

%% proceeding_event(PersonId, _seriousness_offence)
%
% The circumstances concerning the seriousness of the offence require audiovisual recording
%

proceeding_event(PersonId, seriousness_offence).

%% proceeding_event(PersonId, _simple_legal_advice)
%
% The person only needs simple legal advice
%

proceeding_event(PersonId, simple_legal_advice).

%% proceeding_event(PersonId, _small_fine_imposed)
%
% The punishment of the person can only be the imposition of a small fine
%

proceeding_event(PersonId, small_fine_imposed).

%% proceeding_event(PersonId, _summoned_court)
%
% The person has been summoned to court
%

proceeding_event(PersonId, summoned_court).

%% proceeding_event(PersonId, _superseding_interest)
%
% The authority is not allowing the presence of the lawyer in the interest of the investigation
%

proceeding_event(PersonId, superseding_interest).

%% proceeding_event(PersonId, _victim_protection)
%
% The authority is acting for the protection of the victim
%

proceeding_event(PersonId, victim_protection).

%% proceeding_event(_parent, _contrary_to_interest)
%
% The procedure is contrary to the interests of the parent
%

proceeding_event(parent, contrary_to_interest).

%% proceeding_issuing_state(PersonId, Country)
%
% The state issuing the european arrest warrant is country X
%

proceeding_issuing_state(PersonId, Country).

%% proceeding_language(PersonId, Language)
%
% The language of the proceedings is X
%

proceeding_language(PersonId, Language).

%% proceeding_language(PersonId, _dutch)
%
% The language of the proceedings is dutch
%

proceeding_language(PersonId, dutch).

%% proceeding_language(PersonId, _italian)
%
% The language of the proceedings is italian
%

proceeding_language(PersonId, italian).

%% proceeding_language(PersonId, _polish)
%
% The language of the proceedings is polish
%

proceeding_language(PersonId, polish).

%% proceeding_location(PersonId, Country)
%
% The location of the proceedings is X
%

proceeding_location(PersonId, Country).

%% proceeding_matter(PersonId, _any_decision)
%
% A decision has been taken in the course of the proceedings
%

proceeding_matter(PersonId, any_decision).

%% proceeding_matter(PersonId, _appointment_denied)
%
% The authority has denied the appointment of the legal counsel
%

proceeding_matter(PersonId, appointment_denied).

%% proceeding_matter(PersonId, _arraignment)
%
% The proceedings concern an arraignment
%

proceeding_matter(PersonId, arraignment).

%% proceeding_matter(PersonId, _arrest)
%
% The proceedings concern an arrest
%

proceeding_matter(PersonId, arrest).

%% proceeding_matter(PersonId, _bodily_treatment)
%
% The proceedings concern the bodily examination of the person
%

proceeding_matter(PersonId, bodily_treatment).

%% proceeding_matter(PersonId, _breach_of_rights)
%
% The proceedings concern a breach of the rights of the defendant
%

proceeding_matter(PersonId, breach_of_rights).

%% proceeding_matter(PersonId, _coercive_measure)
%
% The proceedings concern a coercive measure
%

proceeding_matter(PersonId, coercive_measure).

%% proceeding_matter(PersonId, _collection_mucosa_smear)
%
% The proceedings concern the collection of mucosa smear
%

proceeding_matter(PersonId, collection_mucosa_smear).

%% proceeding_matter(PersonId, _committal_to_trial)
%
% The proceedings concern a committal to trial
%

proceeding_matter(PersonId, committal_to_trial).

%% proceeding_matter(PersonId, _confirmation_hearing)
%
% The proceedings concern a confirmation hearing
%

proceeding_matter(PersonId, confirmation_hearing).

%% proceeding_matter(PersonId, _confrontations)
%
% The proceedings concern confrontation
%

proceeding_matter(PersonId, confrontations).

%% proceeding_matter(PersonId, _corrective_measure)
%
% The proceedings concern a corrective measure
%

proceeding_matter(PersonId, corrective_measure).

%% proceeding_matter(PersonId, _court_hearing)
%
% The proceedings concern the court hearing
%

proceeding_matter(PersonId, court_hearing).

%% proceeding_matter(PersonId, _court_session)
%
% The proceedings concern any court session
%

proceeding_matter(PersonId, court_session).

%% proceeding_matter(PersonId, _custody_execution)
%
% The proceedings concern the execution of custody
%

proceeding_matter(PersonId, custody_execution).

%% proceeding_matter(PersonId, _deprivation_of_liberty)
%
% The proceedings concern the deprivation of liberty
%

proceeding_matter(PersonId, deprivation_of_liberty).

%% proceeding_matter(PersonId, _derogation_compatible_with_child_interests)
%
% The proceedings concern a derogation from a right, compatible with the child's interests
%

proceeding_matter(PersonId, derogation_compatible_with_child_interests).

%% proceeding_matter(PersonId, _detention)
%
% The proceedings concern detention
%

proceeding_matter(PersonId, detention).

%% proceeding_matter(PersonId, _detention_on_remand)
%
% The proceedings concern detention on remand
%

proceeding_matter(PersonId, detention_on_remand).

%% proceeding_matter(PersonId, _elements_changed)
%
% The proceedings concern proceedings where the elements of the case have changed
%

proceeding_matter(PersonId, elements_changed).

%% proceeding_matter(PersonId, _evidence_gathering_act)
%
% The proceedings concern any evidence gathering act
%

proceeding_matter(PersonId, evidence_gathering_act).

%% proceeding_matter(PersonId, _evidentiary_procedure)
%
% The proceedings concern an evidentiary procedure
%

proceeding_matter(PersonId, evidentiary_procedure).

%% proceeding_matter(PersonId, _external_examination_body)
%
% The proceedings concern an external examination of the body
%

proceeding_matter(PersonId, external_examination_body).

%% proceeding_matter(PersonId, _educational_measure)
%
% The proceedings concern an educational measure
%

proceeding_matter(PersonId, educational_measure).

%% proceeding_matter(PersonId, _fiscal_offense)
%
% The proceedings concern a fiscal offense
%

proceeding_matter(PersonId, fiscal_offense).

%% proceeding_matter(PersonId, _felony)
%
% The proceedings concern any felony
%

proceeding_matter(PersonId, felony).

%% proceeding_matter(PersonId, _grounds_close_investigation)
%
% The proceedings concern the grounds for closing an investigation
%

proceeding_matter(PersonId, grounds_close_investigation).

%% proceeding_matter(PersonId, _hearing)
%
% The proceedings concern an hearing
%

proceeding_matter(PersonId, hearing).

%% proceeding_matter(PersonId, _hearing_public_present)
%
% The proceedings concern an hearing where the public is present
%

proceeding_matter(PersonId, hearing_public_present).

%% proceeding_matter(PersonId, _identity_parade)
%
% The proceedings concern an identity parade
%

proceeding_matter(PersonId, identity_parade).

%% proceeding_matter(PersonId, _imprisonment_over_twelve_years)
%
% The proceedings concern an offence where the punishment is imprisonment over twelve years
%

proceeding_matter(PersonId, imprisonment_over_twelve_years).

%% proceeding_matter(PersonId, _informal_identification)
%
% The proceedings concern the informal identification of a person
%

proceeding_matter(PersonId, informal_identification).

%% proceeding_matter(PersonId, _inspection)
%
% The proceedings concern an inspection
%

proceeding_matter(PersonId, inspection).

%% proceeding_matter(PersonId, _intentional_offence_against_life)
%
% The proceedings concern an intentional offence against life
%

proceeding_matter(PersonId, intentional_offence_against_life).

%% proceeding_matter(PersonId, _interrogation)
%
% The proceedings concern an interrogation
%

proceeding_matter(PersonId, interrogation).

%% proceeding_matter(PersonId, _investigation)
%
% The proceedings concern an investigation
%

proceeding_matter(PersonId, investigation).

%% proceeding_matter(PersonId, _investigative_questioning)
%
% The proceedings concern an investigative questioning
%

proceeding_matter(PersonId, investigative_questioning).

%% proceeding_matter(PersonId, _irresolvable_doubts)
%
% The proceedings concern a case where there are irresolvable doubts
%

proceeding_matter(PersonId, irresolvable_doubts).

%% proceeding_matter(PersonId, _lawyer_not_appointed)
%
% The lawyer has not been appointed
%

proceeding_matter(PersonId, lawyer_not_appointed).

%% proceeding_matter(PersonId, _lawyer_presence_required)
%
% The proceedings concern a case where the presence of the lawyer is required
%

proceeding_matter(PersonId, lawyer_presence_required).

%% proceeding_matter(PersonId, _mandatory_procedural_requirements)
%
% The proceedings concern a mandatory procedural requirement
%

proceeding_matter(PersonId, mandatory_procedural_requirements).

%% proceeding_matter(PersonId, _may_result_loss_distortion_evidence)
%
% The proceedings may result in a loss or distortion of the evidence
%

proceeding_matter(PersonId, may_result_loss_distortion_evidence).

%% proceeding_matter(PersonId, _means_test)
%
% A means test has been applied
%

proceeding_matter(PersonId, means_test).

%% proceeding_matter(PersonId, _merits_test)
%
% A merits test has been applied
%

proceeding_matter(PersonId, merits_test).

%% proceeding_matter(PersonId, _minor_offence)
%
% The proceedings concern a minor offence
%

proceeding_matter(PersonId, minor_offence).

%% proceeding_matter(PersonId, _not_proven)
%
% The proceedings concern a case where it has not been proven that the defendant committed the crime
%

proceeding_matter(PersonId, not_proven).

%% proceeding_matter(PersonId, _petty_offense)
%
% The proceedings concern a petty offense
%

proceeding_matter(PersonId, petty_offense).

%% proceeding_matter(PersonId, _preparatory_proceedings)
%
% The proceedings are of preparatory nature
%

proceeding_matter(PersonId, preparatory_proceedings).

%% proceeding_matter(PersonId, _pre_trial)
%
% The proceedings are happening before the trial has started
%

proceeding_matter(PersonId, pre_trial).

%% proceeding_matter(PersonId, _pre_trial_detention)
%
% The proceedings concern pre trial detention
%

proceeding_matter(PersonId, pre_trial_detention).

%% proceeding_matter(PersonId, _pre_trial_detention_not_allowed)
%
% The proceedings concern an offence for which pre trial detention is not allowed
%

proceeding_matter(PersonId, pre_trial_detention_not_allowed).

%% proceeding_matter(PersonId, _precautionary_detention)
%
% The proceedings concern precautionary detention
%

proceeding_matter(PersonId, precautionary_detention).

%% proceeding_matter(PersonId, _precautionary_measure)
%
% The proceedings concern any precautionary measure
%

proceeding_matter(PersonId, precautionary_measure).

%% proceeding_matter(PersonId, _precautionary_measure_effectiveness)
%
% The proceedings concern the effectiveness of a precautionary measure
%

proceeding_matter(PersonId, precautionary_measure_effectiveness).

%% proceeding_matter(PersonId, _preliminary_hearing)
%
% The proceedings concern a preliminary hearing
%

proceeding_matter(PersonId, preliminary_hearing).

%% proceeding_matter(PersonId, _preliminary_investigation)
%
% The proceedings concern a preliminary investigation
%

proceeding_matter(PersonId, preliminary_investigation).

%% proceeding_matter(PersonId, _prevent_damage_investigation)
%
% The authority needs to prevent damage to the investigation
%

proceeding_matter(PersonId, prevent_damage_investigation).

%% proceeding_matter(PersonId, _psychiatric_tests)
%
% The proceedings concern a psychiatric test
%

proceeding_matter(PersonId, psychiatric_tests).

%% proceeding_matter(PersonId, _psychological_tests)
%
% The proceedings concern a psychological test
%

proceeding_matter(PersonId, psychological_tests).

%% proceeding_matter(PersonId, _questioning)
%
% The proceedings concern the questioning of the defendant
%

proceeding_matter(PersonId, questioning).

%% proceeding_matter(PersonId, _reasons_for_accused_to_be_child)
%
% There are reasons for the person to be considered a child
%

proceeding_matter(PersonId, reasons_for_accused_to_be_child).

%% proceeding_matter(PersonId, _reconstructions_crime_scene)
%
% The proceedings concern the reconstructions of a crime scene
%

proceeding_matter(PersonId, reconstructions_crime_scene).

%% proceeding_matter(PersonId, _search)
%
% The authority has performed a search on the person
%

proceeding_matter(PersonId, search).

%% proceeding_matter(PersonId, _seizure)
%
% The authority has seized the person
%

proceeding_matter(PersonId, seizure).

%% proceeding_matter(PersonId, _serious_offence)
%
% The proceedings concern a serious offence
%

proceeding_matter(PersonId, serious_offence).

%% proceeding_matter(PersonId, _specific_measure)
%
% The proceedings concern a specific measure for the child
%

proceeding_matter(PersonId, specific_measure).

%% proceeding_matter(PersonId, _summary_offences)
%
% The proceedings concern a summary offence
%

proceeding_matter(PersonId, summary_offences).

%% proceeding_matter(PersonId, _summoned_court)
%
% The proceedings concern the summon to court of the person
%

proceeding_matter(PersonId, summoned_court).

%% proceeding_matter(PersonId, _surrender)
%
% The proceedings concern the surrender of the person
%

proceeding_matter(PersonId, surrender).

%% proceeding_matter(PersonId, _technical_ascertainment)
%
% The proceedings concern a technical ascertainment
%

proceeding_matter(PersonId, technical_ascertainment).

%% proceeding_matter(PersonId, _temporary_detention)
%
% The proceedings concern temporary detention
%

proceeding_matter(PersonId, temporary_detention).

%% proceeding_matter(PersonId, _trial_in_absentia)
%
% The proceedings have been conducted in absentia
%

proceeding_matter(PersonId, trial_in_absentia).

%% proceeding_matter(PersonId, _urgent_check_scene)
%
% The proceedings concern an urgent check of the scene
%

proceeding_matter(PersonId, urgent_check_scene).

%% proceeding_matter(PersonId, _violation_procedural_law)
%
% The proceedings concern the violation of procedural law
%

proceeding_matter(PersonId, violation_procedural_law).

%% proceeding_matter(PersonId, _witness_questioning)
%
% The proceedings concern the questioning of the witness
%

proceeding_matter(PersonId, witness_questioning).

%% proceeding_status(PersonId, _circumstances_cease_to_exist)
%
% The circumstances behind the nomination of the holder of parental responsibility have ceased to exists
%

proceeding_status(PersonId, circumstances_cease_to_exist).

%% proceeding_status(PersonId, _concluded)
%
% The proceedings have reached the final determination
%

proceeding_status(PersonId, concluded).

%% proceeding_status(PersonId, _started)
%
% The proceedings have started
%

proceeding_status(PersonId, started).

%% proceeding_type(PersonId, _europeanArrestWarrant)
%
% The proceedings concern the execution of a european arrest warrant
%

proceeding_type(PersonId, europeanArrestWarrant).

%% proceeding_type(PersonId, _accelerated_proceedings)
%
% The proceedings are accelerated
%

proceeding_type(PersonId, accelerated_proceedings).

%% proceeding_type(PersonId, _active_delivery)
%
% This is an active delivery procedure
%

proceeding_type(PersonId, active_delivery).

%% proceeding_type(PersonId, _appeal)
%
% The proceedings concern an appeal
%

proceeding_type(PersonId, appeal).

%% proceeding_type(PersonId, _criminal)
%
% The proceedings are of criminal nature
%

proceeding_type(PersonId, criminal).

%% proceeding_type(PersonId, _passive_delivery)
%
% This is a passive delivery procedure
%

proceeding_type(PersonId, passive_delivery).

%% quality_not_sufficient(PersonId, _document_translation)
%
% The quality of the translation is not sufficient
%

quality_not_sufficient(PersonId, document_translation).

%% quality_not_sufficient(PersonId, _interpreter)
%
% The quality of the interpreter is not sufficient
%

quality_not_sufficient(PersonId, interpreter).

%% responsibility_assigned(PersonId, ChildId, _agreement_having_legal_effects)
%
% The responsiblity over the child has been assigned through an agreement having legal effect
%

responsibility_assigned(PersonId, ChildId, agreement_having_legal_effects).

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

%% right_available(PersonId, _individual_assessment)
%
% The individual assessment is available to the person
%

right_available(PersonId, individual_assessment).

%% waiver_status(PersonId, _express_free)
%
% The waiver has been given in an express and free manner
%

waiver_status(PersonId, express_free).

%% waiver_status(PersonId, _unequivocalVoluntary)
%
% The waiver has been given in an unequivocal and voluntary manner
%

waiver_status(PersonId, unequivocalVoluntary).

