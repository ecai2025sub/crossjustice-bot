:- module(directive_2012_13_bg, [has_right/5, auxiliary_right/5, auxiliary_right_checked/5, right_property/5, right_property_checked/5, explain/2]).

:- include('./../../utils.pl').

has_right(Right, bg, Article, PersonId, Matter) :-
    has_right(Article, PersonId, Right, Matter).

%%
%
% Article 15(1) Criminal Procedure Code
%
% Right of defence
% (1) The accused party shall enjoy the right of defence.
% (2) The accused party and the other persons who take part in criminal proceedings shall be afforded all procedural
% means necessary for the defence of their rights and legal interests.
% (3) The court, the prosecutor and investigative bodies shall explain the persons under Paragraph 2 their procedural
% rights and shall ensure the possibility to exercise them.

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

%% has_right(_art64, PersonId, _right_to_be_present, _trial)
%
% Article 64 - Fully implemented
%
% Taking the measure of remand in custody in pre-trial proceedings
% (1) At the request of the prosecutor, the competent court of first instance shall apply the measure of remand in custody in the context of pre-trial proceedings.
% (2) The prosecutor shall immediately ensure for the accused party to appear before court and, if needed, he/she may rule the detention of the accused party for up to 72 hours
% until the latter is brought before court.
has_right(art64, PersonId, right_to_be_present, trial) :-
    proceeding_matter(PersonId, pre_trial),
    proceeding_matter(PersonId, custody_in_remand).

%% has_right(_art74_2_2, PersonId, _right_to_information, _legal_grounds)
%
% Article 74(2)(2) - Fully implemented
%
% (2) The following shall be specified in the warrant under paragraph 1:
% 2. the factual and legal grounds for the detention;
has_right(art74_2_2, PersonId, right_to_information, legal_grounds) :-
    person_status(PersonId, detained).

%% proceeding_matter(PersonId, _lawyer_presence_required)
%
% Article 94 - Fully implemented
%
% Mandatory participation of defence counsel
% (1) Participation of the defence counsel in criminal proceedings shall be mandatory in cases where:
% 1. The accused party is underage;
proceeding_matter(PersonId, lawyer_presence_required) :-
    person_age(PersonId, minor).

%% proceeding_matter(PersonId, _lawyer_presence_required)
%
% Article 94 - Fully implemented
%
% 2. The accused party suffers from physical or mental deficiencies, which prevent him/her from proceeding pro se;
proceeding_matter(PersonId, lawyer_presence_required) :-
    person_status(PersonId, physical_mental_deficiencies).

%% proceeding_matter(PersonId, _lawyer_presence_required)
%
% Article 94 - Fully implemented
%
% 3. the case is concerned with a criminal offence punishable by deprivation of liberty of no less than ten years or another heavier punishment;
proceeding_matter(PersonId, lawyer_presence_required) :-
    proceeding_matter(PersonId, punishment_deprivation_liberty_no_less_ten_years).

%% proceeding_matter(PersonId, _lawyer_presence_required)
%
% Article 94 - Fully implemented
%
% 4. The accused party does not have command of the Bulgarian language;
proceeding_matter(PersonId, lawyer_presence_required) :-
    \+ person_language(PersonId, bulgarian),
    \+ person_event(PersonId, waive_right).

%% proceeding_matter(PersonId, _lawyer_presence_required)
%
% Article 94 - Fully implemented
%
% 5. The interests of the accused parties are contradictory and one of the parties has his/her own defence counsel;
proceeding_matter(PersonId, lawyer_presence_required) :-
    proceeding_event(PersonId, interest_parties_contradictory),
    \+ person_event(PersonId, waive_right).

%% proceeding_matter(PersonId, _lawyer_presence_required)
%
% Article 94 - Fully implemented
%
% 6. A request under Article 64 has been made or the accused party is detained;
proceeding_matter(PersonId, lawyer_presence_required) :-
    person_status(PersonId, detained).

%% proceeding_matter(PersonId, _lawyer_presence_required)
%
% Article 94 - Fully implemented
%
% 8. The case is tried in the absence of the accused party;
proceeding_matter(PersonId, lawyer_presence_required) :-
    proceeding_matter(PersonId, trial_in_absentia).

%% proceeding_matter(PersonId, _lawyer_presence_required)
%
% Article 94 - Fully implemented
%
% 9. The accused party cannot afford to pay a lawyer fee, wishes to have a defence counsel and the interests of justice so require.
proceeding_matter(PersonId, lawyer_presence_required) :-
    person_status(PersonId, cannot_afford_lawyer).

%% has_right(_art94_3, PersonId, _right_to_appoint_lawyer, _ex_officio)
%
% Article 94 - Fully implemented
%
% Mandatory participation of defence counsel
% (2) In cases within the scope of Paragraph 1, items 4 and 5, the participation of a defence counsel shall not be mandatory, provided the accused party makes a statement he/she wishes to dispense with having a defence counsel.
% (3) Where participation of a defence counsel is mandatory, the respective body shall appoint a lawyer as a defence counsel.
has_right(art94_3, PersonId, right_to_appoint_lawyer, ex_officio) :-
    proceeding_matter(PersonId, lawyer_presence_required).

%% has_right(_art97_2, PersonId, _right_to_information, _access_lawyer)
%
% Article 97(2) - Fully implemented
%
% Joinder of defence counsel to criminal proceedings
% (2) The body entrusted with the pre-trial proceedings shall be obligated to explain to the accused party that he/she has the right to defence counsel, as well
% as to immediately allow him/her to contact one. Said body shall be prevented from taking any action within the context of investigation, as well as any other
% procedural action involving the accused party until it has been acquitted of this obligation.
has_right(art97_2, PersonId, right_to_information, access_lawyer) :-
    person_status(PersonId, accused).

%% auxiliary_right(_art128, PersonId, _record, _evidence_gathering_act)
%
% Article 128 - Fully implemented
%
% Drawing up record
% For every investigative action and judicial trial action a record shall be drawn up at the place where it is performed.
auxiliary_right_scope(art128, [art227]).

auxiliary_right(art128, PersonId, record, evidence_gathering_act).

%% person_status(PersonId, _accused)
%
% Article 219 - Fully implemented
%
% Constituting the accused party and presentation of the decree to this effect
% (1) Where sufficient evidence is collected for the guilt of a certain individual in the perpetration of a publicly actionable
% criminal offence, and none of the grounds for terminating criminal proceedings are present, the investigative body shall report
% to the prosecutor and issue a decree to constitute the person as accused party.
% (2) The investigative body may also constitute the accused party in this particular capacity upon drafting the record for the first
% investigative action against him/her, of which it shall report to the prosecutor.
% person_status(PersonId, accused) :-
%    person_status(PersonId, raise_suspicion).

% person_status(PersonId, accused) :-
%    proceeding_matter(PersonId, evidence_gathering_act).

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

% (4) The investigative body shall present the decree for constitution to the accused party and his/her defence counsel, allowing them to gain
% knowledge of its full content and, where needed, giving additional explanations. The investigative body shall serve against a signature a copy
% of the decree on the accused party.
% (8) The investigative body may not take investigative action involving the accused party until the former has fulfilled its duties under Paragraphs 1 - 7.

%% auxiliary_right(_art225, PersonId, _accusation, _indictment_changes)
%
% Article 225 - Fully implemented
%
% New constitution of the accused party
% Where during investigation the presence of grounds is found require the application of a law concerning a criminal offence punishable by a more serious sanction or the factual circumstances have
% considerably changed, or new offences need to be introduced or new individuals need to be constituted, the investigative body shall report this to the prosecutor and perform a new constitution of the accused party.
auxiliary_right_scope(art225, [art15_1, art13_2, art74_2_2, art55]).

auxiliary_right(art225, PersonId, accusation, indictment_changes) :-
    proceeding_matter(PersonId, elements_changed).

%% has_right(_art227, PersonId, _right_to_be_present, _investigation)
%
% Article 227 - Fully implemented
%
% Presentation of the investigation
% (1) Following completion of action under Article 226, the investigative body shall present the investigation.
% (2) The accused party and his/her defence counsel, and the victim and his/her counsel shall be summonsed for the presentation of the investigation, if they have requested so.
has_right(art227, PersonId, right_to_be_present, investigation) :-
    proceeding_matter(PersonId, evidence_gathering_act).

%%%%% Legal Aid Act %%%%%

%% has_right(_art30_2, PersonId, _right_to_information, _access_lawyer)
%
% Article 30(2) - Fully implemented
%
% (2) Immediately after a person is detained or after a person is constituted as an accused party, the authority referred to in Article 25 (1) herein shall explain
% to the detainee the right thereof to defence, serving upon the said detainee, upon signed acknowledgement, a form stating the right thereof to assistance of a retained or assigned lawyer.
has_right(art30_2, PersonId, right_to_information, access_lawyer) :-
    (   person_status(PersonId, detained)
    ;   person_status(PersonId, accused)
    ).


%%%%% Instuction No. 8121h-78 of 24 January 2015 on the procedure for detention, the furnishing of the premises for accommodation of detainees and the order therein at the Ministry of Interior %%%%%

%% has_right(_art15_1, PersonId, _right_to_information, _)
%
% Article 15 - Partially implemented
%
% (1) Immediately after detention, the detained person shall be informed of the reasons for the detention, the liability, provided by law as well as his/her rights under the Ministry of the Interior Act, including his/her right to:
has_right(art15_1, PersonId, right_to_information, reasons_for_detention) :-
    person_status(PersonId, detained).

%% has_right(_art15_1, PersonId, _right_to_information, _)
%
% Article 15 - Partially implemented
%
% 1. appeal before the court the legality of the detention;
has_right(art15_1, PersonId, right_to_information, appeal) :-
    person_status(PersonId, detained).

%% has_right(_art15_1, PersonId, _right_to_information, _)
%
% Article 15 - Partially implemented
%
% 2. defence counsel as of the moment of detention;
has_right(art15_1, PersonId, right_to_information, access_lawyer) :-
    person_status(PersonId, detained).

%% has_right(_art15_1, PersonId, _right_to_information, _)
%
% Article 15 - Partially implemented
%
% 3. medical care;
has_right(art15_1, PersonId, right_to_information, medical_care) :-
    person_status(PersonId, detained).

%% has_right(_art15_1, PersonId, _right_to_information, _)
%
% Article 15 - Partially implemented
%
% 4. a telephone call with which to inform of his/her detention;
has_right(art15_1, PersonId, right_to_information, telephone_call) :-
    person_status(PersonId, detained).

%% has_right(_art15_1, PersonId, _right_to_information, _)
%
% Article 15 - Partially implemented
%
% 5. contact the consular authorities of the respective state in case he/she is not a Bulgarian national;
has_right(art15_1, PersonId, right_to_information, access_consul) :-
    person_status(PersonId, detained),
    \+ person_nationality(PersonId, bulgaria).

%% has_right(_art15_1, PersonId, _right_to_information, _)
%
% Article 15 - Partially implemented
%
% 6. use an interpreter in case he/she does not speak Bulgarian.
has_right(art15_1, PersonId, right_to_information, interpreter) :-
    person_status(PersonId, detained),
    \+ person_language(PersonId, bulgarian).

%% has_right(_art15_1, PersonId, _right_to_information, _)
%
% Article 15 - Partially implemented
%
% (2) The detained person shall fill in a statement that he/she is aware of his/her rights and of his/her intention to exercise or not his/her rights under paragraph 1, item 2 - 6 (Annex 1).
% The declaration shall be filled in two copies, the first of which is attached to the detention warrant at the registry of the respective MoI structure, and the second shall be served to the
% detained person. The refusal of the detained person to sign the declaration shall be ascertained with the signature of one witness.
% (3) If the detained person is illiterate or is not capable to fill the declaration by himself/herself, it shall be filled by a civil servant. In this case the detained person shall dictate
% his statement to the civil servant in the presence of a withness whose signature shall verify the authenticity of the statement.

%% auxiliary_right(_art16_1, PersonId, _assistance, _vulnerablePersons)
%
% Article 16(1) - Partially implemented
%
% (1) The detained person who does not undrerstand Bulgarian or is deaf, dumb or blind shall be acquainted with the reasons for his/her detention and the liability provided by
% law and shall be explained his rights, including those specified in Article 15 (1), and the procedure for action under Article 19 in a language that he/she understands using a translator or an interpreter.
% (2) In cases under paragragh 1 the police body who has detained the person or the operational onduty public servant shall ensure the assistance of a translator or an interpreter.
auxiliary_right_scope(art16_1, [art15_1]).

auxiliary_right(art16_1, PersonId, assistance, vulnerablePersons) :-
    \+ person_language(PersonId, bulgarian);
    person_condition(PersonId, deaf);
    person_condition(PersonId, dumb);
    person_condition(PersonId, blind).

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

%%%%% Customs Act %%%%%

%% has_right(_art16_a_4, PersonId, _right_to_interpretation, _europeanArrestWarrant)
%
% Article 16 - Fully implemented
%
% (4) When an arrested person does not speak Bulgarian, he/she shall be promptly informed of the reasons for his/her arrest in a language the person understands.
has_right(art16_a_4, PersonId, right_to_interpretation, europeanArrestWarrant) :-
    person_status(PersonId, arrested),
    \+ person_language(PersonId, bulgarian).

has_right(art16_a_4, PersonId, right_to_translation, europeanArrestWarrant) :-
    person_document(PersonId, europeanArrestWarrant),
    \+ person_language(PersonId, bulgarian).

%%%%% Judiciary System Act %%%%%

%% auxiliary_right(_art249_1, PersonId, _training, _judges)
%
% Article 249(1) - Fully implemented
%
% Article 249
% (1) The National Institute of Justice shall implement:
% 1. mandatory initial training of candidates for junior judge, junior prosecutor, and junior investigating magistrate;
% 2. mandatory induction training of judges, prosecutors and investigating magistrates when they are appointed for the first time in judicial authorities and when court assessors are elected for their first term of office;
% 3. maintaining and upgrading the qualification of judges, prosecutors and investigating magistrates, of members of the Supreme Judicial Council, of the Inspector General and inspectors of the Inspectorate with the Supreme Judicial Council, of public enforcement agents, recording magistrates, judicial assistants, prosecutorial assistants, judicial officers, court assessors, of the inspectors at the Inspectorate with the Minister of Justice and of other employees of the Ministry of Justice;
% 4. e-learning, and shall organise empirical legal research and analysis.
auxiliary_right_scope(art249_1, [art55]).

auxiliary_right(art249_1, PersonId, training, judges).

