:- module(directive_2016_343_bg, [has_right/5, auxiliary_right/5, auxiliary_right_checked/5, right_property/5, right_property_checked/5, explain/2]).

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

%% has_right(_art16, PersonId, _right_to_be_presumed_innocent, _until_guilty)
%
% Article 16 Criminal Procedure Code
%
% Presumption of innocence
% The accused party shall be presumed innocent until the reverse is established by virtue of an effective verdict.
has_right(art16, PersonId, right_to_be_presumed_innocent, until_guilty) :-
    person_status(PersonId, accused).

%% has_right(_art31_3, PersonId, _right_to_be_presumed_innocent, _until_guilty)
%
% Article 31(3) Constitution of the Republic of Bulgaria
%
% Article 31
% (3) An accused party shall be presumed innocent until otherwise proven by an enforceable sentence.
has_right(art31_3, PersonId, right_to_be_presumed_innocent, until_guilty) :-
    person_status(PersonId, accused).

%% auxiliary_right(_art55_1, PersonId, _remedy, _breach_of_rights)
%
% Article 55(1) Criminal Procedure Code
%
% (1) The accused party shall have the following rights:
% file appeal from acts infringing on his/her rights and legal interests
% (4) take part in criminal proceedings
auxiliary_right_scope(art55_1, [art16, art115_4, art116]).

auxiliary_right(art55_1, PersonId, remedy, breach_of_rights) :-
    proceeding_matter(PersonId, breach_of_rights).

has_right(art55_1, PersonId, right_to_be_present, trial) :-
    person_status(PersonId, accused).

%% has_right(_art65_1, PersonId, _right_to_request_transformation, _custody_remand)
%
% Article 65(1) Criminal Procedure Code
%
% Judicial control over remand in custody in the course of pre-trial proceedings
% (1) The accused party or his/her defence counsel may request transformation of the measure of remand in custody at
% any time in the course of pre-trial proceedings.
% 2) The request of the accused party or his/her defence counsel shall be made through the prosecutor who shall be
% obligated to forthwith refer the case to the court.
% (3) The hearing of the case shall be scheduled within three days after the file has been received in court on the occasion
% of a public court hearing attended by the prosecutor, the accused party and his/her defence counsel. The case shall be heard
% in the absence of the accused party, where he/she does not wish to appear, having made a statement to this effect, or his/her
% bringing is impracticable due to his/her health condition.
% (4) The court shall assess all circumstances pertaining to the lawfulness of detention and shall make pronouncement by a ruling
% which is to be announced to the parties at the court hearing. Upon announcing the ruling, the court shall schedule the case before
% the intermediate appellate review court within seven days in case an accessory appeal or protest has been filed.
has_right(art65_1, PersonId, right_to_request_transformation, custody_remand) :-
    person_status(PersonId, accused),
    proceeding_matter(PersonId, pre_trial),
    proceeding_matter(PersonId, detention_on_remand).

%% auxiliary_right(_art94_1_8, PersonId, _access_lawyer, _mandatory)
%
% Article 94(1)(8) Criminal Procedure Code
%
% Mandatory participation of defence counsel
%
% (1) Participation of the defence counsel in criminal proceedings shall be mandatory in cases where:
% 8. The case is tried in the absence of the accused party;
auxiliary_right_scope(art94_1_8, [art16, art115_4, art116]).

auxiliary_right(art94_1_8, PersonId, access_lawyer, mandatory) :-
    auxiliary_right(art269_3_3, PersonId, right_to_be_absent, trial_in_absentia).

%% right_property(_art103_1, PersonId, _burden_of_proof, _prosecution)
%
% Article 103(1) Criminal Procedure Code
%
% Burden of proof
% (1) The burden of proving the accusation in publicly actionable cases shall lie with the prosecutor and the investigative bodies, and in cases actionable
% by complaint of the victim - with the private complainant.
% (2) The accused party shall not be obligated to prove that he or she is not guilty.
right_property_scope(art103_1, [art16, art115_4, art116]).

right_property(art103_1, PersonId, burden_of_proof, prosecution).

%% auxiliary_right(_art103_3, PersonId, _exercise_of_right, _not_evidence)
%
% Article 103(3) Criminal Procedure Code
%
% Burden of proof
% (3) No inferences may be made to the detriment of the accused party on account of the fact that he or she has not provided, or refuses to provide explanations, or has not proved his/her objections.
auxiliary_right_scope(art103_3, [art115_4]).

auxiliary_right(art103_3, PersonId, exercise_of_right, not_evidence).

%% has_right(_art115_4, PersonId, _right_to_remain_silent, _trial)
%
% Article 115(4) Criminal Procedure Code
%
% Explanations of the accused party
% (1) The accused party shall give explanations orally and directly before the respective body.
% (2) The accused party shall not be interrogated by letter rogatory or through a video conference, except where he or she is outside the territory of the country
% and the interrogation will not obstruct the discovery of the objective truth.
% (3) The accused party may provide explanations at any moment during the investigation and the judicial trial.
% (4) The accused party shall have the right to refuse providing explanations.
has_right(art115_4, PersonId, right_to_remain_silent, trial) :-
    person_status(PersonId, accused).

%% has_right(_art116, PersonId, _right_to_not_incriminate_themselves, _confession)
%
% Article 116 Criminal Procedure Code
%
% Probative value of confessions by the accused party
% (1) The accusation and the sentence may not be solely based on the confessions of the accused party.
% (2) A confession of the accused party shall not exempt the respective bodies from their obligation to collect other evidence in the case as well.
has_right(art116, PersonId, right_to_not_incriminate_themselves, confession) :-
    person_status(PersonId, accused).

%% auxiliary_right(_art198, PersonId, _investigation, _dissemination_materials)
%
% Article 198 Criminal Procedure Code
%
% (1) Investigation materials may not be made public without authorisation by the prosecutor.
% (2) Should it be necessary, the pre-trial body shall warn, against signature, the persons attending at investigative actions that they may not make public,
% without authorisation, any case materials, and that otherwise they shall be held responsible pursuant to Article 360 of the Criminal Code.
auxiliary_right_scope(art198, [art16, art115_4, art116]).

auxiliary_right(art198, PersonId, investigation, dissemination_materials) :-
    proceeding_matter(PersonId, investigation).

%% has_right(_art247b_1, PersonId, _right_to_be_present, _hearing)
%
% Article 247b(1) Criminal Procedure Code
%
% Notification of scheduling the operative hearing
% (1) At the order of the judge-rapporteur a copy of the indictment shall be served on the defendant. Upon serving the indictment, the defendant shall be
% notified of the date of the operative hearing and of the matters specified in Article 248, Paragraph (1), of his/her right to appear with a defence counsel
% and of the possibility to have a defence counsel appointed in the cases set out in Article 94, Paragraph (1), as well as of the fact that the case can be tried
% and adjudicated in the defendant’s absence as per the provisions of Article 269.
has_right(art247b_1, PersonId, right_to_be_present, hearing) :-
    (   person_status(PersonId, suspect)
    ;   person_status(PersonId, accused)
    ),
    proceeding_matter(PersonId, hearing).

%% auxiliary_right(_art269_3_3, PersonId, _right_to_be_absent, _trial_in_absentia)
%
% Article 269(3)(3) Criminal Procedure Code
%
% Presence of the accused party in the court hearing
% (3) Provided this shall not obstruct the discovery of the objective truth, the case may be tried in the absence of the accused party if:
% 1. the person could not be found at the address specified by him, or he has changed his/her address without notifying the respective body;
% 2. his/her place of residence in this country is not known and has not been identified after a thorough search;
% 3. the person had been validly summonsed but failed to show good cause for not appearing, and where the procedure under Article 247b, Paragraph (1) has been complied with;
% 4. is located outside the boundaries of the Republic of Bulgaria:
% a) his/her place of residence is not known;
% b) may not be otherwise summonsed;
% c) has been validly summonsed, but has failed to specify good reasons for his/her non-appearance.
auxiliary_right_scope(art269_3_3, [art16, art115_4, art116]).

auxiliary_right(art269_3_3, PersonId, right_to_be_absent, trial_in_absentia) :-
    person_event(PersonId, address_unknown).

%% right_property(_art303, PersonId, _burden_of_proof, _beyond_doubt)
%
% Article 303 Criminal Procedure Code
%
% Finding the defendant guilty
% (1) Sentences may not be based on supposition.
% (2) The court shall find the defendant guilty where the accusation is proved beyond doubt.
right_property_scope(art303, [art16, art115_4, art116]).

right_property(art303, PersonId, burden_of_proof, beyond_doubt).

%% right_property(_art391_3_6, PersonId, _presentation, _security_directorate_general)
%
% Article 391(3)(6) Criminal Procedure Code
%
% Article 391
% (3) The Security Directorate General shall:
% 6. escort accused parties and defendants in respect whereof detention in custody is requested or has been decreed as a precautionary measure to secure the appearance thereof,
% or persons serving sentences at the places of deprivation of liberty, to the judicial authorities;
right_property_scope(art391_3_6, [art16, art115_4, art116]).

right_property(art391_3_6, PersonId, presentation, security_directorate_general).

%% auxiliary_right(_art423, PersonId, _remedy, _new_trial)
%
% Article 423 Criminal Procedure Code
%
% Re-opening of a criminal case upon request of an individual sentenced in absentia due to the convict's non-participation in the criminal proceedings
% (1) Within six months from the date when the convict sentenced in absentia has come to knowledge of a sentence that has entered into force or of the actual hand-over by another
% state to the Republic of Bulgaria, he/she may file a request for re-opening the criminal case due to the convict’s non-participation in the criminal proceedings.
% The request shall be honoured, unless the convict - upon being charged within the pre-trial proceedings - absconded, which hindered the procedure under Article 247b, Paragraph (1) or,
% once the afore-mentioned procedure was completed, the convict failed to appear to a court hearing with no cogent reason.
auxiliary_right_scope(art423, [art16, art115_4, art116]).

auxiliary_right(art423, PersonId, remedy, new_trial) :-
    person_request_submitted(PersonId, new_trial),
    proceeding_matter(PersonId, trial_in_absentia).

%%
%
% Article 45 Obligations and Contracts Act
%
% 45. Every person must redress the damage he has guiltily caused to another person.
% In all cases of tort guilt is presumed until proven otherwise.
