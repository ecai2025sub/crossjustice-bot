:- module(directive_2016_800_pl, [has_right/5, auxiliary_right/5, auxiliary_right_checked/5, right_property/5, right_property_checked/5, explain/2]).

:- include('./../../utils.pl').

has_right(Right, pl, Article, PersonId, Matter) :-
    person_status(PersonId, child),
    has_right(Article, PersonId, Right, Matter).

person_status(PersonId, child):-
    person_age(PersonId, X),
    X < 18.

%Polish Implementation 16/800

% Article 71(1-3) criminal procedure code
%1. A suspect is a person, with regard to whom a decision presenting charges was issued, 
%or who, without the issuance of such a decision, was informed about the charges in connection 
%with his interrogation in the capacity of a suspect.
person_status(PersonId, suspect):-
    person_document(PersonId, charge);
    person_status(PersonId, informed_about_charge).

%2. An accused is a person, against whom an indictment was submitted to a court, and also a person, 
%with regard to whom a public prosecutor has filed a request referred to in Article 335 § 1 or a request 
%for a conditional discontinuation of proceedings.
person_status(PersonId, accused):-
    person_document(PersonId, indictment);
    person_document(PersonId, request_discontinuation_proceedings).

%3. If the term “accused” is used in this Code with a general meaning, relevant provisions apply also to the suspect.
person_status(PersonId, accused):-
    person_status(PersonId, suspect).

%Article 313(1-4) criminal procedure code
%1. If information existing at the moment of initiating the investigation or collected during the investigation sufficiently justifies 
%the suspicion that the offence was committed by a specific individual, a written decision to bring charges is drawn up. 
%It is immediately announced to the suspect and the suspect is interrogated, unless the announcement of the decision and the interrogation 
%are not possible because the suspect is hiding or abroad.
%2. The written decision to bring charges shall indicate the suspect, an exact description of the offence and its legal qualification.
%3. The suspect may - until he is notified of the date of final disclosure of the case file at the end of investigation - demand that 
%the grounds of the charges are explained to him verbally, as well as that a written statement of reasons is drawn up. 
%The suspect has to be advised of these rights. The statement of reasons is served upon the suspect and the appointed defence counsel 
%within 14 days.
%4. The statement of reasons should clarify in particular on what facts and evidence the charges are based.

%Article 325g(1-2) criminal procedure code
%1. It is not required to issue a written decision to bring charges or to issue a decision to close an inquiry, unless the suspect 
%is detained on remand.
%2. The interrogation of a person suspected of an offence starts with information on the charges which are specified in the transcript 
%of the interrogation. This person is considered as a suspect from the beginning of the interrogation.
person_status(PersonId, suspect):-
    person_status(PersonId, informed_about_charge),
    proceeding_matter(PersonId, interrogation).

%Article 10(1 and 2) criminal procedure code
%1. An indvidual who commits a criminal act after the age of 17 bears responsibility under the principles set by this Code.
criminal_code_applies(article10_1, PersonId):-
    person_age(PersonId, X, act_committed),
    X > 17.

%2. A juvenile who after the age of 15 commits a criminal act specified in art. 134, art. 148 § 1, 2 or 3, art. 156 § 1 or 3, 
%art. 163 § 1 or 3, art. 166, art. 173 § 1 or 3, art. 197 § 3 or 4, art. 223 § 2, art. 252 § 1 or 2 and in art. 280, may respond under 
%the principles set out in this code, if the circumstances of the case and the degree of development of the perpetrator, his features 
%and personal conditions speak for it, and in particular if the previously used educational or corrective measures have proved ineffective.
criminal_code_applies(article10_2, PersonId, Article, Matter):-
    person_age(PersonId, X, act_committed),
    X > 15,
    nationalLawApplies(Article, PersonId, Matter). 

%Crimes specified in articles mentioned in art. 10 § 2 are: 
%-attempt to assassinate the Presidenf of Poland
%-murder
%-causing serious damage to health
%-causing a threat to life or health of many people or to property of an enormous size
%-hijacking of a ship or aircraft
%-causing a catastrophy in land, sea or wind traffic
%-aggravated rape
%-assault on public official
%-kidnaping
%-robbery.

%Article 1(1 and 2) Law of October 26th, 1982 on proceedings in juvenile cases
%1. The provisions of the Act shall apply to:
%1) preventing and combating demoralization - in relation to persons under 18 years of age;
%law1982_applies(article1_1, PersonId):-
%    person_age(PersonId, X),
%    X < 18.

%2) proceedings in cases of punishable offenses - in relation to persons who have committed such an act after completing 13 years of age, 
%but have not completed 17 years of age;
law1982_applies(article1_2, PersonId):-
    proceeding_type(PersonId, criminal), % TODO - Should there be another argument for punishable offence?
    person_age(PersonId, X, act_committed),
    X > 13,
    X < 17.

%3) the implementation of educational or corrective measures - in relation to persons for whom these measures have been imposed, but 
%no longer than until their completion by the age of 21.
law1982_applies(article1_3, PersonId):-
    (   proceeding_matter(PersonId, educational_measure)
    ;   proceeding_matter(PersonId, corrective_measure)
    ),
    person_age(PersonId, X),
    X < 21.

%2. Whenever the act refers to:
%1) "minors" - shall mean the persons referred to in § 1;
person_status(PersonId, minor):-
    law1982_applies(article1_1, PersonId).

%2) "punishable act" - it means an act prohibited by law as:
%a) crime or fiscal offense either
proceeding_type(PersonId, punishable_act):-
    proceeding_type(PersonId, criminal).

proceeding_type(PersonId, punishable_act):-
    proceeding_matter(PersonId, fiscal_offense).

%b) petty offense specified in art. 50a, art. 51, art. 69, art. 74, art. 76, art. 85, art. 87, art. 119, art. 122, art. 124, art. 133 or 
%art. 143 of the Code of Offenses.
proceeding_type(PersonId, punishable_act):-
    proceeding_matter(PersonId, petty_offense),
    nationalLawApplies(_, PersonId). % TODO - List of articles?

%% has_right(_article79_1, PersonId, _right_to_access_lawyer, _trial)
%
% Article 79(1-3) criminal procedure code
%
% 1. In the criminal proceedings, the accused must be assisted by a defence counsel if:
% 1) he has not attained eighteen years of age,
% 2) he is deaf, mute or blind,
% 3) there is a justified doubt whether his ability to comprehend the meaning of his deed or to control his behaviour was not, 
% at the time of committing the offence, excluded or significantly reduced,
% 4) there is a justified doubt whether the condition of his mental health allows him to participate in the proceedings or to conduct his 
% defence in an independent and reasonable manner.
% 2. The accused must also have a defence counsel if the court deems it necessary due to other circumstances impeding the defence.
% 3. In the cases specified in § 1 and 2, the participation of a defence counsel is obligatory at the trial and at those hearings, 
% where the participation of the accused is obligatory.

has_right(article79_1_1, PersonId, right_to_access_lawyer, trial):-
    person_age(PersonId, X),
    X < 18.

has_right(article79_1_2, PersonId, right_to_access_lawyer, trial):-
    person_condition(PersonId, deaf);
    person_condition(PersonId, mute);
    person_condition(PersonId, blind).

has_right(article79_1_3, PersonId, right_to_access_lawyer, trial):-
    person_age(PersonId, _, act_committed),
    person_condition(PersonId, mental_disability, act_committed).

has_right(article79_1_4, PersonId, right_to_access_lawyer, trial):-
    person_condition(PersonId, mental_disability),
    proceeding_status(PersonId, started).

has_right(article79_2, PersonId, right_to_access_lawyer, trial):-
    authority_decision(PersonId, access_to_counsel).

has_right(article79_3, PersonId, right_to_access_lawyer, obligatory):-
    (   has_right(article79_1_1, PersonId, right_to_access_lawyer, trial)
    ;    has_right(article79_1_2, PersonId, right_to_access_lawyer, trial) 
    ;    has_right(article79_1_3, PersonId, right_to_access_lawyer, trial)
    ;    has_right(article79_1_3, PersonId, right_to_access_lawyer, trial)
    ;    has_right(article79_2, PersonId, right_to_access_lawyer, trial)
    ),
    proceeding_status(PersonId, started),
    person_status(PersonId, accused).

%% has_right(_article81_1, PersonId, _right_to_access_lawyer, _authority_appointment)
%
% Article 81(1) criminal procedure code
%
% If in the circumstances specified in Article 78 § 1, Article 78 § 1a, Article 79 § 1 and 2 and Article 80, the accused does not have a 
% defence counsel of his own choice, the president or the court referendary of the court competent to hear the case appoints for him a 
% defence counsel ex officio.
has_right(article81_1, PersonId, right_to_access_lawyer, authority_appointment):-
    (   has_right(article79_1_1, PersonId, right_to_access_lawyer, trial)
    ;    has_right(article79_1_2, PersonId, right_to_access_lawyer, trial) 
    ;    has_right(article79_1_3, PersonId, right_to_access_lawyer, trial)
    ;    has_right(article79_1_3, PersonId, right_to_access_lawyer, trial)
    ;    has_right(article79_2, PersonId, right_to_access_lawyer, trial)
    ),
    proceeding_matter(PersonId, lawyer_not_appointed).

% TODO - \+ person_event(PersonId, lawyer_appointed) OR have a new predicate for the existence of a lawyer?

%Article 87(1-3) criminal procedure code
%1. A party other than the accused may appoint an attorney.
%2. A person, who is not a party to the proceedings, may appoint an attorney if his interest in the proceedings so requires.
%3. The court, and in preparatory proceedings the public prosecutor, may refuse to admit the attorney referred to in § 2 to 
%participation in the proceedings, if in their opinion it is not necessary for the protection of the interests of the person, who 
%is not a party to the proceedings.

%% person_status(PersonId, _holder_of_parental_responsibility)
%
% Article 93(1) criminal procedure code
%
% 1. Both parents have parental responsibility.
person_status(PersonId, holder_of_parental_responsibility):-
    person_status(PersonId, parent).

%% person_status(PersonId, _holder_of_parental_responsibility)
%
% Article 94(1-3) criminal procedure code
%
% 1. If one of the parents is dead or does not have full legal capacity, parental responsibility is vested in the other parent. Same 
% applies when one of the parents has been deprived of parental authority or when his or her parental responsibility has been suspended.
% 3. If neither of the parents has parental responsibility or if parents are unknown, custody is established for the child.
person_status(PersonId, holder_of_parental_responsibility):-
    authority_decision(PersonId, custody_established),
    \+ person_status(PersonId, parent).

%Article 95(1 and 3) criminal procedure code
%1. Parental responsibility includes in particular the obligation and the right
%parents to care for the person and property of the child and to raise child, with respect for their dignity and rights.
%3. Parental responsibility should be exercised as required by the good child and social interest.
%
%4. Parents should hear the child before making decisions on important matters relating to the person or property of the child, if the 
%child's mental development, state of health and maturity allow it, and take into account, as far as possible, his reasonable wishes.

%Article 98(1-3) criminal procedure code
%1. Parents are the legal representatives of a child remaining under their parental authority. If the child is under the parental 
%authority of both parents, each of them may act independently as the child's legal representative.

%2. However, no parent can represent the child:
%1) in legal transactions between children under their parental authority;
%2) in legal transactions between the child and one of the parents or his spouse, unless the legal act consists of providing free of 
%charge to the child or that it concerns the means of subsistence and education due to the child from the other parent.
%3. The provisions of the preceding paragraph shall apply accordingly in proceedings before a court or other state authority.

%§ 3. The provisions of the preceding paragraph shall apply accordingly in proceedings before a court or other state authority.

%% person_status(PersonId, _holder_of_parental_responsibility)
%
% Article 99(1 and 2) criminal procedure code
%
% Whenever neither of the parents can legally represent a child under their parental authority, the guardianship court appoints a 
% guardian to represent the child.
person_status(PersonId, holder_of_parental_responsibility):-
    authority_decision(PersonId, guardianship),
    \+ person_status(PersonId, parent).

%2. The guardian representing the child is authorized to perform all activities connected with the case, also in the scope of appealing 
%and enforcement of the decision. The provisions of art. 95 § 3 and 4 and art. 154 shall apply accordingly.

%Article 99(1)(1-3) criminal procedure code
%1. Only a barrister or an attorney-at-law who has a special knowledge of matters relating to child or of the same type that the case 
%in which child representation is required or who has completed training on the rules of representing the child, children's rights or 
%needs may be appointed as a guardian.
%2. If the degree of complexity of the case does not require it, in particular if the guardianship court specifies the activities to be 
%conducted in detail, another person holding a law degree and demonstrating knowledge of the child's needs may be appointed as guardian. 
%In special special circumstances a person without a law degree may be appointed as guardian.
%3. The provision of § 2 does not apply to a guardian representing a child in criminal proceedings.

%Article 99 (2)(3) criminal procedure code
%If the child's mental development, health condition and level of maturity allow it, the probation officer representing the child 
%establishes contact with the child and informs them about the activities undertaken, the course of the proceedings and the manner 
%of its completion, and the consequences of the actions taken for their legal situation, in an understandable manner and adapted to 
%the child's degree development.

%Article 154 criminal procedure code
%The guardian is obliged to perform his activities with due diligence, as required by the welfare of the cared for and the social interest.

%% has_right(_article300_1, PersonId, _right_to_information_writing, _)
%
% Article 300(1) criminal procedure code
%
% Prior to the first interrogation, the suspect should be instructed of his rights: to give or to refuse giving testimony or to decline 
% to answer questions, to be informed of the charges and any changes thereof, to submit requests for investigatory acts to be undertaken 
% in investigation or inquiry, to be assisted by defence counsel, including the right to request the appointment of the defence counsel 
% ex officio in the case specified in Article 78 and the content of Article 338b and to be acquainted, at the end of the proceedings, 
% with the material gathered in its course, as well as of the rights defined under Article 23a § 1, Article 72 § 1, Article 156 § 5 and 5a, 
% Article 301, Article 335, Article 338a and Article 387 and of the duties and consequences mentioned in Article 74, Article 75, 
% Article 133 § 2, Article 138 and Article 139. This instruction should be given to the suspect in writing, who acknowledges receipt with 
% his signature.
has_right(article300_1, PersonId, right_to_information_writing, give_refuse_testimony):-
    person_status(PersonId, suspect).

has_right(article300_1, PersonId, right_to_information_writing, informed_about_charge):-
    person_status(PersonId, suspect).

has_right(article300_1, PersonId, right_to_information_writing, request_investigatory_acts):-
    person_status(PersonId, suspect).

has_right(article300_1, PersonId, right_to_information_writing, access_lawyer):-
    person_status(PersonId, suspect).

has_right(article300_1, PersonId, right_to_information_writing, various_articles):-
    person_status(PersonId, suspect).

%% has_right(_article244_2, PersonId, _right_to_information, _)
%
% Article 244(2 and 5) criminal procedure code
%
% 2. The arrestee is immediately informed of the reasons for the arrest and of his rights, including the right to use the assistance of 
% an advocate or legal counsel and a gratuitous help of an interpreter, if the arrestee does not have a sufficient command of Polish, 
% to make statements and to refuse making statements, to obtain copy of an arrest report, to have access to medical first aid, as well as 
% of his rights indicated in Article 245, Article 246 § 1 and Article 612 § 2 and of the contents of Article 248 § 1 and 2. 
% The arrestee’s explanations should also be heard.

has_right(article244_2, PersonId, right_to_information, access_lawyer):-
    person_status(PersonId, arrested).

has_right(article244_2, PersonId, right_to_information, interpreter):-
    person_status(PersonId, arrested),
    \+ person_language(PersonId, polish).

has_right(article244_2, PersonId, right_to_information, make_refuse_stamentes):-
    person_status(PersonId, arrested).

has_right(article244_2, PersonId, right_to_information, arrest_report):-
    person_status(PersonId, arrested).

has_right(article244_2, PersonId, right_to_information, medical_aid):-
    person_status(PersonId, arrested).

has_right(article244_2, PersonId, right_to_information, various_articles):-
    person_status(PersonId, arrested).

% TODO - necessity of making the instruction comprehensible to the persons not using the assistance of an attorney.

%% has_right(_article263_8, PersonId, _right_to_information, _)
%
% Article 263(8) criminal procedure code
%
% The Minister of Justice shall define by way of a regulation the form of instruction about the rights of the accused in case of imposition 
% of detention on remand: to give explanations, to refuse to give testimony or answer questions, to obtain information on the charges, to 
% review case files in the part containing evidence indicated in the motion to order detention on remand, to have access to medical first 
% aid, as well as of the rights indicated in Article 72 § 1, Article 78 § 1, Article 249 § 5, Article 252, Article 254 § 1 i 2, 
% Article 261 § 1, 2 and 2a and Article 612 § 1, 
has_right(article263_8, PersonId, right_to_information, give_explanation):-
    person_status(PersonId, accused),
    proceeding_matter(PersonId, detention_on_remand).

has_right(article263_8, PersonId, right_to_information, give_refuse_testimony):-
    person_status(PersonId, accused),
    proceeding_matter(PersonId, detention_on_remand).

has_right(article263_8, PersonId, right_to_information, informed_about_charge):-
    person_status(PersonId, accused),
    proceeding_matter(PersonId, detention_on_remand).

has_right(article263_8, PersonId, right_to_information, review_case_files):-
    person_status(PersonId, accused),
    proceeding_matter(PersonId, detention_on_remand).

has_right(article263_8, PersonId, right_to_information, medical_aid):-
    person_status(PersonId, accused),
    proceeding_matter(PersonId, detention_on_remand).

has_right(article263_8, PersonId, right_to_information, various_articles):-
    person_status(PersonId, accused),
    proceeding_matter(PersonId, detention_on_remand).

% TODO - bearing in mind also the necessity of making the instruction comprehensible to the persons not using the assistance of an attorney.

%% has_right(_article338_1, PersonId, _right_to_information, _)
%
% Article 338(1 and 1a) criminal procedure code
%
% 1. If the indictment meets the formal requirements, the president of the court or the court referendary immediately orders that a 
% copy be served upon the accused summoning him to submit evidentiary motions within seven days of the service of the indictment.
% 1a. The accused is also instructed of the contents of Article 291 § 3, Article 338a, Article 341 § 1, Article 349 § 8, Article 374, 
% Article 376, Article 377 and Article 422 and of the fact that the motion for the appointment of the defence counsel ex officio should 
% be submitted no later than within seven days of the service of the summons or notification of the date of trial or hearing referred to 
% in Article 341 or Article 343. The accused should also be advised of the fact that depending on the results of the trial, he may be 
% charged with the costs of appointment of the defence counsel ex officio.
has_right(article338_1, PersonId, right_to_information, indictment):-
    person_status(PersonId, accused).

has_right(article338_1a, PersonId, right_to_information, various_articles):-
    person_status(PersonId, accused).

%% has_right(_article374_1, PersonId, _right_to_participate, _trial)
%
% Article 374(1) criminal procedure code
%
% The accused has the right to participate in the main trial. The presiding judge or the court may decide that the presence of the accused 
% at the main trial is mandatory.
has_right(article374_1, PersonId, right_to_participate, trial):-
    person_status(PersonId, accused).

%% has_right(_article100_8, PersonId, _right_to_information, _appeal)
%
% Article 100(8) criminal procedure code
%
% After the announcement or while serving the decision or order, participants to the proceedings should be instructed of their rights, 
% time limit and manner of submitting an appeal or about the fact that the decision cannot be appealed.
has_right(article100_8, PersonId, right_to_information, appeal):-
    person_status(PersonId, party_to_proceedings).

%% has_right(_article76, PersonId, _right_to_act_on_behalf, HolderId)
%
% Article 76 criminal procedure code
%
% If an accused is underage or incapacitated, his legal representative or a person under whose care the accused remains, may undertake 
% all actions on his behalf in the proceedings, especially submit appeals, requests and appoint a defence counsel.
has_right(article76, PersonId, right_to_act_on_behalf, HolderId):-
    person_status(HolderId, holder_of_parental_responsibility),
    person_status(PersonId, accused).

% TODO - Should we map incapacited, legal representative?

%% has_right(_article140, PersonId, _right_to_be_informed, HolderId)
%
% Article 140 criminal procedure code
%
% If the law does not provide otherwise, decisions, orders, notifications and their copies, which by law must be served upon the parties, 
% are served upon defence counsels, attorneys and legal representatives.
has_right(article140, PersonId, right_to_be_informed, HolderId):-
    person_status(HolderId, holder_of_parental_responsibility),
    person_status(PersonId, minor).

% TODO - Should we map defence counsel and legal representatives? How to map if the law does not provide otherwise?

%% has_right(_article18_1_b, PersonId, _right_to_access_lawyer, _trial)
%
% Article 18(1-2) criminal procedure code
%
% Article 18. § 1. The court having jurisdiction under the provisions of the Code of Penal Procedure shall examine the case if:
% 1) there are grounds for a ruling on a minor penalty under Art. 10 § 2 of the Penal Code;
% 2. The proceedings in the cases referred to in § 1 shall be conducted in accordance with the provisions of the Code of Criminal Procedure, 
% however, in the cases in question:
% 1) in point 1, when proceedings were instituted before a minor turns 18:
% b) the minor must have a defence counsel,
has_right(article18_1_b, PersonId, right_to_access_lawyer, trial):-
    person_status(PersonId, minor).

% proceedings istituted before 18?

%% has_right(_article18_1_c, PersonId, _right_to_have_rights, _)
%
% Article 18.1
%
% (c) parents or gudian of a minor have the rights of a party,

%% has_right(_article301, PersonId, _right_to_access_lawyer, _interrogation)
%
% Article 301 criminal procedure code
%
% At the request of the suspect, the interrogation should be conducted with the participation of the appointed defence counsel. 
% Failure of defence counsel to appear does not halt the examination.
has_right(article301, PersonId, right_to_access_lawyer, interrogation):-
    person_request_submitted(PersonId, defence_counsel),
    person_status(PersonId, suspect).

%% has_right(_article245_1, PersonId, _right_to_access_lawyer, _pretrial)
%
% Article 245(1 and 2) criminal procedure code
%
% 1. The arrestee, at his request, should be allowed to contact an advocate or legal counsel in an available form and have a direct 
% conversation with him. In exceptional cases, justified by particular circumstances, the arresting authority may reserve that it will 
% be present during said conversation.
has_right(article245_1, PersonId, right_to_access_lawyer, pretrial):-
    person_status(PersonId, arrested),
    person_request_submitted(PersonId, defence_counsel).

%2. Article 517j § 1 and regulations enacted on the ground of Article 517j § 2 apply accordingly.

%% has_right(_article517, PersonId, _right_to_access_lawyer, _accelerated_proceedings)
%
% Article 517(1 and 2) criminal procedure code
%
% 1. In order to make it possible for the accused to use the assistance of a defence counsel, in accelerated proceedings advocates and 
% legal advisors shall be on duty in the time and place determined in separate provisions.
% 2. The Minister of Justice shall determine by way of a regulation the manner of ensuring the assistance of a defence counsel to the 
% accused, and the possibility of appointing one in accelerated proceedings, including the organisation of on-call duties referred to 
% in § 1, bearing in mind the need for the proper course of the accelerated proceedings and the necessity of ensuring the possibility 
% of appointing a defence counsel to the accused.
has_right(article517, PersonId, right_to_access_lawyer, accelerated_proceedings):-
    person_status(PersonId, accused),
    proceeding_type(PersonId, accelerated_proceedings).

%% has_right(_article73_1, PersonId, _right_to_access_lawyer, _private_communication)
%
% Article 73(1-3) criminal procedure code
%
% 1. An accused, who is detained on remand, may communicate with his defence counsel without the presence of other persons and by 
% correspondence.
has_right(article73_1, PersonId, right_to_access_lawyer, private_communication):-
    person_status(PersonId, accused),
    proceeding_matter(PersonId, detention_on_remand).

%2. In preparatory proceedings, the public prosecutor, allowing the communication, may, in a particularly justified case, make a 
%restriction that he personally, or another person authorised by him, will be present at the time.
%3. If the interest of preparatory proceedings so requires, in a particularly justified case the public prosecutor may order that 
%the correspondence of the accused with his defence counsel be controlled.
%4. Restrictions mentioned in § 2 and 3 may not last longer or be imposed later than fourteen days of the date, when the suspect 
%was detained on remand.

%% has_right(_article215_1, PersonId, _right_to_access_lawyer, _communication)
%
% Article 215(1-2) criminal procedure code
%
% 1. A detained person has a right to communicate with a defence lawyer or attorney, who is a an advocate or legal advisor
% and a representative who is not an advocate or legal adviser, who has been approved by the President of the Chamber of the 
% European Court of Human Rights to represent the convicted person before this Tribunal, in the absence of other persons and by 
% correspondence . If the authority at whose disposal the detainee is still staying reserves the presence of himself or an authorized 
% person upon seeing - the visit shall take place in the manner indicated by that authority.
has_right(article215_1, PersonId, right_to_access_lawyer, communication):-
    person_status(PersonId, detained).

%1a. If a foreign national is temporarily arrested, he / she has the right to communicate with the competent consular post or 
%diplomatic mission, and if the person who is temporarily arrested is a person without any citizenship - with a representative 
%of the country in which he / she has permanent residence, on the terms referred to in § 1.

%% has_right(_article215_2, PersonId, _right_to_prepare_defence, _pretrial)
%
% Article 215.2
%
% 2. A detainee should be allowed to prepare for defence.
has_right(article215_2, PersonId, right_to_prepare_defence, pretrial):-
    person_status(PersonId, detained).

% Article 6_4_b directive implentation?

%% has_right(_article315_1, PersonId, _right_to_request, _conduct_investigation_procedure)
%
% Article 315(1) criminal procedure code
%
% 1. A suspect and his defence counsel, as well as the aggrieved party and his attorney may submit requests that certain procedures 
% of the investigation be conducted.
has_right(article315_1, PersonId, right_to_request, conduct_investigation_procedure):-
    person_status(PersonId, suspect),
    person_request_submitted(PersonId, conduct_investigation_procedure).

%% has_right(_article315_2, PersonId, _right_to_participate, _trial)
%
% Article 315(2) criminal procedure code
%
% 2. A party, who submitted a request, his defence counsel or attorney cannot be denied the right to participate in the procedure, 
% if they so demand. Article 318, the second sentence, applies accordingly.
has_right(article315_2, PersonId, right_to_participate, trial):-
    person_status(PersonId, party_to_proceeding),
    person_request_submitted(PersonId, participate_investigation).

% Does this imply that the party submits the request and not the attorney? does this even make sense?

%% has_right(_article316_1, PersonId, _right_to_participate, _investigation_procedure)
%
% Article 316(1-3) criminal procedure code
%
% 1. If a procedure of the investigation cannot be repeated at the trial, the suspect, the aggrieved party and their legal representatives, 
% as well as defence counsels and attorneys, if they have already been appointed in the case, should be allowed to participate in the 
% procedure, unless a delay might result in the loss or distortion of evidence.
has_right(article316_1, PersonId, right_to_participate, investigation_procedure):-
    proceeding_matter(PersonId, investigation),
    person_status(PersonId, suspect),
    \+ proceeding_matter(PersonId, may_result_loss_distortion_evidence).

%2. A suspect in custody will not be brought to the court if the delay might result in the loss or distortion of evidence.
% TODO - is this also a positive right? right to be brought to court?

%3. If there is a risk that it will not be possible to examine a witness at the trial, a party, the public prosecutor or other agency 
%conducting the proceedings may request the court to examine the witness.

%% has_right(_article317_1, PersonId, _right_to_participate, _investigation)
%
% Article 317(1 and 2) criminal procedure code
%
% 1. Parties and their defence counsels or attorneys, if such have already been appointed, should also, upon their demand, 
% be allowed to participate in other procedures of the investigation.
% 2. In a particularly justified case, the public prosecutor may, by way of a decision, deny participation in a procedure due to the 
% important interests of the investigation or decline to bring the accused in custody if this would cause serious difficulties.
has_right(article317_1, PersonId, right_to_participate, investigation):-
    person_status(PersonId, party_to_proceeding),
    person_request_submitted(PersonId, participate_investigation),
    \+ exception(has_right(article317_1, PersonId, right_to_participate, investigation), _).

exception(has_right(article317_1, PersonId, right_to_participate, investigation), _):-
    authority_decision(PersonId, deny_participation).

%Article 318 criminal procedure code
%If an expert opinion or an opinion of a scientific or specialised institution is admitted, the suspect and his defence counsel, 
%as well as the aggrieved party and his attorney receive a copy of the decision admitting evidence and they are allowed to participate 
%in the examination of experts and to review the opinion, if it was given in writing. A suspect in custody is not brought to the court, 
%if it would cause serious difficulties.

%Article 173(1-4) criminal procedure code
%1. A testifying person may be shown another person, his image or an object with the purpose of recognition. Presentation should be 
%conducted in a manner excluding suggestion.
%2. If necessary, presentation may also be conducted in a manner excluding the possibility of recognition of a testifying person by 
%the person being recognised.
%3. During a presentation, the person being presented should be in a group consisting of at least four persons.
%4. The Minister of Justice, upon consultation with the Minister of Internal Affairs, shall define by way of a regulation the technical 
%conditions of conducting presentations, bearing in mind the necessity of ensuring an effective course of proceedings and a proper 
%realisation of the rights of the participants to the trial.

%Article 172 criminal procedure code
%Testifying persons may be confronted with the purpose of explaining contradictions. Confrontation is not admissible in cases 
%specified in Article 184.

%% has_right(_article396_3, PersonId, _right_to_access_lawyer, _inspection_evidence)
%
%Article 396(1, 1a and 3) criminal procedure code
%
% 1. If the party applied for it or the court decided it is necessary to check a piece of evidence and doing this by all members of 
% the adjudicating panel is significantly difficult or the parties so agree, the court designates one of its members or another court 
% to conduct such action.
% 1a The provision of § 1 applies accordingly to conducting an inspection.
% 3. The parties, defence counsels and attorneys may participate in the procedures referred to in § 1-2. The accused deprived of liberty 
% is brought only if the court deems is necessary.
has_right(article396_3, PersonId, right_to_access_lawyer, inspection_evidence):-
    (   person_request_submitted(PersonId, check_evidence)
    ;   authority_decision(PersonId, check_evidence)
    ).

%Article 178(1) criminal procedure code
%It is not permitted to examine as a witness:
%1) a defence counsel or an advocate or legal advisor acting pursuant to Article 245 § 1 with regard to facts learned while giving 
%legal advice or conducting a case,

%Article 226 criminal procedure code
%The use of documents containing confidential information, or information constituting a professional secret as evidence in criminal 
%proceedings is subject to the prohibitions and restrictions defined under Article 178-181. However, the use in preparatory 
%proceedings of documents containing a medical secret is decided upon by the public prosecutor.

%% has_right(_article439_1, PersonId, _right_to_appeal, _breach_of_rights)
%
% Article 439(1)(10) criminal procedure code
%
% 1. Regardless of the limits of the appeal, of the objections raised and impact of the flaw on the contents of the judgment, 
% the appellate court in a hearing reverses the appealed judgment, if:
% 10) the accused was not assisted in judicial proceedings by a defence counsel in situations specified in art. 79 § 1 and 2 and art. 80 
% or the defence counsel did not participate in the procedures in which his or her participation was mandatory.
% Article 439(2) criminal procedure code
% The reversing of a judgment for the reasons defined in § 1 point 9-11 may occur only in favour of the accused.
has_right(article439_1, PersonId, right_to_appeal, breach_of_rights):-
    person_status(PersonId, accused),
    proceeding_matter(PersonId, remedy),
    \+ proceeding_event(PersonId, lawyer_present).
% TODO CHANGE INTO AUX RIGHT

%TODO - Check the articles required?

%Article 249(3 and 5) criminal procedure code
%3. Before a preventive measure is ordered, the court or the public prosecutor examines the accused, unless it is not possible to 
%do so due to the fact that the accused is in hiding or staying out of the country. Defence counsel appointed by the accused should 
%be allowed to participate in the examination, if he appears. It is not obligatory to notify the defence counsel of the date of the 
%examination, unless the accused requests so and this will not obstruct the proceedings. The public prosecutor is notified of the 
%date of the examination by the court.

%5. The public prosecutor and the defence counsel are entitled to participate in a court hearing regarding the extension of detention 
%on remand or an appeal against the use or extension of this preventive measure. At the request of arrestee who does not have a defence 
%counsel, a defence counsel ex officio is appointed for this procedure. The order may also be issued by a court referendary. 
%The absence of a properly notified public prosecutor or defence counsel does not stay the proceedings.

%% has_right(_article214_1, PersonId, _right_to_individual_assessment, _)
%
% Article 214(1-4) criminal procedure code
%
% If needed, and in particular when it is necessary to acquire information concerning the personal condition and lifestyle of 
% the accused, the court and, in preparatory proceedings, the public prosecutor, orders a individual assessment into the accused to be 
% conducted by a professional court probation officer or another entity authorised to do so by virtue of separate provisions and, 
% in particularly justified cases, by the Police.
% 2. The individual assessment is obligatory:
% 1) in cases concerning felonies,
% 2) in case of the accused charged with the intentional commission of an offence against life who, at the time of committing a crime,
% was under 21 years of age.
% 3. An individual assessment need not be conducted with regard to an accused, who has no permanent residence in Poland.
has_right(article214_1, PersonId, right_to_individual_assessment, ex_officio):-
    person_status(PersonId, accused),
    person_circumstances(PersonId, need_to_acquire_information),
    \+ exception(has_right(article214_1, PersonId, right_to_individual_assessment, ex_officio), article214_3Applies(PersonId)).

has_right(article214_2_1, PersonId, right_to_individual_assessment, obligatory):-
    proceeding_matter(PersonId, felony),
    \+ exception(has_right(article214_2_1, PersonId, right_to_individual_assessment, ex_officio), article214_3Applies(PersonId)).

has_right(article214_2_2, PersonId, right_to_individual_assessment, obligatory):-
    person_age(PersonId, X, act_committed),
    X < 21,
    proceeding_matter(PersonId, intentional_offence_against_life),
    \+ exception(has_right(article214_2_2, PersonId, right_to_individual_assessment, ex_officio), article214_3Applies(PersonId)).

exception(has_right(_, PersonId, right_to_individual_assessment, ex_officio), article214_3Applies(PersonId)):-
    person_status(PersonId, accused),
    person_residence(PersonId, Country),
    Country \= poland.

%% has_right(_paragraph1_3, PersonId, _right_to_medical_examination, _obligatory)
%
% Paragraph 1(3) Regulation of the Minister of Internal Affairs of September 13, 2012 on the medical examination of persons detained by the police
%
% 1.3. The detained person shall undergo a medical examination when:
% (1) the person declares that he or she suffers from a condition requiring permanent or periodic treatment, the interruption of which 
% would pose a threat to life or health, demands a medical examination or has visible injuries which do not indicate a state of sudden 
% health threat;
has_right(paragraph1_3, PersonId, right_to_medical_examination, obligatory):-
    person_status(PersonId, detained),
    (   person_circumstances(PersonId, condition_requires_treatment)
    ;   person_request_submitted(PersonId, medical_exam)
    ;   person_circumstances(PersonId, visible_injuries)
    ).

%% has_right(_paragraph1_1, PersonId, _right_to_first_aid, _emergency)
%
% Paragraph Regulation of the Minister of Internal Affairs of September 13, 2012 on the medical examination of persons detained by the police
%
% 1.1. A person detained by the Police, hereinafter referred to as “detained person”, shall be provided without delay with first aid 
% or qualified first aid in the event that the person is in a state of emergency, as defined in emergency medical services
has_right(paragraph1_1, PersonId, right_to_first_aid, emergency):-
    person_status(PersonId, detained),
    person_circumstances(PersonId, state_of_emergency).

%% has_right(_paragraph7, PersonId, _right_to_be_placed, _separately_from_adults)
%
% Paragraph 7 Regulation of the Minister of Internal Affairs of September 13, 2012 on the medical examination of persons detained by the police
%
% 3) persons under 18 years of age shall not be placed in a room together with adults.
has_right(paragraph7, PersonId, right_to_be_placed, separately_from_adults):-
    person_status(PersonId, detained),
    person_age(PersonId, X),
    X < 18.

%% has_right(_article115_1, PersonId, _right_to_specific_treatment, _free_health_care)
%
% Article 115(1) criminal procedure code
%
% A convicted person is provided with free health services, medicines and sanitary items.
has_right(article115_1, PersonId, right_to_specific_treatment, free_health_care):-
    person_status(PersonId, convicted).

%% has_right(_article212c_1, PersonId, _right_to_specific_treatment, _medical_examination)
%
% Article 212c(1) criminal procedure code
%
% A person detained on remand shall be subjected to personal examination to the extent necessary to prevent the mutual demoralisation of 
% detainees and to ensure order and safety in custody. 
% If it is necessary to carry out psychological and psychiatric examinations, they are carried out according to the rules specified in 
% Art. 83 § 1 and 2 and Art. 84 § 3.
has_right(article212c_1, PersonId, right_to_specific_treatment, medical_examination):-
    person_status(PersonId, detained_on_remand).

%Article 130(1-6) criminal procedure code
%Article 131 criminal procedure code
%Article 132 criminal procedure code

%% has_right(_article130_131_132_133, PersonId, _right_to_specific_treatment, _education_training)
%
%Article 133 criminal procedure code
%
%
has_right(article130_131_132_133, PersonId, right_to_specific_treatment, education_training):-
    person_status(PersonId, convicted).

%% has_right(_article102_2, PersonId, _right_to_specific_treatment, _family_ties)
%
% Article 102 criminal procedure code
%
% The convicted person is entitled in particular to:
% 2) maintaining ties with family and other relatives;
has_right(article102_2, PersonId, right_to_specific_treatment, family_ties):-
    person_status(PersonId, convicted).

%% has_right(_article135, PersonId, _right_to_specific_treatment, _)
%
% Article 135(1-2) criminal procedure code
% 
% 1. Prisons create conditions for convicted persons to spend their free time properly. For this purpose, cultural and educational 
% activities, physical and sports education and social activity of prisoners are organised.
% 2. In every prison, there is a book and press rental service for prisoners and the possibility of using audio-visual equipment 
% in day-care centres and for residential purposes. The detainee must not disturb the order in the prison by using these devices.
has_right(article135_1, PersonId, right_to_specific_treatment, cultural_educational_activities):-
    person_status(PersonId, convicted).

has_right(article135_2, PersonId, right_to_specific_treatment, book_rental_service):-
    person_status(PersonId, convicted).

%% has_right(_article221a_106, PersonId, _right_to_specific_treatment, _freedom_of_religion)
%
% Article 106(1-2) criminal procedure code
% The movement of detainees in custody, teaching and employment, direct participation in services, religious meetings and teaching of 
% religion, and the use of sight-seeing, walking, bathing, cultural and educational activities, physical culture and sport, as well as 
% their participation in trial activities, shall take into account the need to safeguard the proper conduct of criminal proceedings.
% Article 221a criminal procedure code
% 1. A convicted person has the right to perform religious practices and use religious services and to attend services in 
% prison on public holidays and listen to services broadcast by the media, and to have books, writings and objects necessary for this.
% 2. you have the right to take part in religious teaching in prison, to take part in the charity and social activities of the church 
% or other religious association that you belong to, and to have individual meetings with the clergyman of the church or other religious 
% association that you belong to; these clergymen can visit you in the rooms where you are staying.

has_right(article221a_106, PersonId, right_to_specific_treatment, freedom_of_religion):-
    person_status(PersonId, convicted);
    person_status(PersonId, detained).

%% has_right(_article217, PersonId, _right_to_meet, _next_of_kin)
%
% Article 217(1-2) criminal procedure code
%
% 1. A person detained on remand may meet with someone upon the permission issued by the authority that the detainee 
% remains art the disposal of. Where a person remanded in custody is placed at the disposal of several authorities, each authority 
% is required to issue a permission, unless they order otherwise.
% 1a, Subject to § 1b, a person remanded in custody has the right to at least one seeing per month with the next of kin.
% 1b. Not granting permission to meet with the next of kin referred to in § 1a may only take place if there is a justified fear that 
% the meeting will be used:
% 1) in order to illegally hinder criminal proceedings;
% 2) to commit an offence, in particular to incite an offence.
has_right(article217, PersonId, right_to_meet, next_of_kin):-
    person_status(PersonId, detained_on_remand),
    authority_decision(PersonId, permission_given),
    \+ exception(has_right(article217, PersonId, right_to_meet, next_of_kin), article217_1Applies(PersonId)).

exception(has_right(article217, PersonId, right_to_meet, next_of_kin), article217_1Applies(PersonId)):-
    person_danger(PersonId, hinder_criminal_proceedings);
    person_danger(PersonId, commit_incite_offence).

%% has_right(_article360_2, PersonId, _right_to_privacy, _absence_of_public)
%
% Article 360(1-2) criminal procedure code
% 
% 1. The court may exclude the public from the whole or part of the trial:
% 2) if at least one of the accused is a minor or for the duration of the examination of a witness who is below 15 years of age,
has_right(article360_2, PersonId, right_to_privacy, absence_of_public):-
    person_status(PersonId, minor).

%% has_right(_article32f, PersonId, _right_to_be_accompanied, HolderId)
%
% Article 32f Law of October 26th, 1982 on proceedings in juvenile cases
%
% Art. 32f. An interview with a minor by the Police shall be held in relation to the parents who have parental authority, or the minor's 
% guardian or defender, and if it would be impossible to ensure their presence in a given case, a person close to the minor nominated by 
% the minor, a representative of the school the minor attends, a family assistant, a coordinator of family foster care or a representative 
% of a social organization whose statutory tasks include the educational impact on minors, shall be summoned, or to support the process of 
% their rehabilitation. Article 19 shall apply accordingly.
has_right(article32f, PersonId, right_to_be_accompanied, HolderId):-
    person_status(PersonId, minor),
    (   person_status(HolderId, holder_of_parental_responsibility)
    ;   person_nominate(PersonId, HolderId)
    ;   person_school_representative(HolderId)
    ;   person_family_assistant(HolderId)
    ;   person_family_foster_care(HolderId)
    ;   person_organization_representative(HolderId)
    ).

%% has_right(_article62_1, PersonId, _right_to_be_present, _trial)
%
% Article 62(1) criminal procedure code
%
% 1. The participation of a minor in a trial is not mandatory. However, the court hearing case on appeal shall order bringing
% a minor placed in a temporary detention center for juveniles or an educational centre for juveniles, if it is considered necessary, 
% and also when requested by a party or a minor's defender. The provision of Article 32o § 2 shall apply accordingly.
has_right(article62_1, PersonId, right_to_be_present, trial):-
    person_status(PersonId, minor),
    person_status(PersonId, temporary_detention),
    (   person_circumstances(PersonId, necessary)
    ;   person_request_submitted(PersonId, present_trial)
    ).

%% has_right(_article540b, PersonId, _right_to_be_present, _new_trial)
%
% Article 540b(1-2) criminal procedure code
%
% 1. Judicial proceedings concluded with a final and binding court judgment may be reopened at the request of the accused, submitted 
% within a final time limit of one month of the day on which he learns of the judgment issued against him, if the case is heard in the 
% absence of the accused, who was not served a notification of the date of the hearing or trial, or such a notification was not served 
% on him personally and he is able to prove that he was not aware of the date and the possibility of a judgment being delivered in his 
% absence.
% 2. The provisions of § 1 do not apply in cases referred to in Article 133 § 2, Article 136 § 1 and Article 139 § 1, and also if the 
%defence counsel has participated in the trial or hearing.
has_right(article540b, PersonId, right_to_be_present, new_trial):-
    proceeding_status(PersonId, concluded),
    \+ proceeding_matter(PersonId, summoned_court),
    \+ exception(has_right(article540b, PersonId, right_to_be_present, new_trial), article540b_2Applies(PersonId)).

exception(has_right(article540b, PersonId, right_to_be_present, new_trial), article540b_2Applies(PersonId)):-
    person_circumstances(PersonId, lawyer_attended_trial).

% TODO - attended trial new predicate? Add also to EUdir?

has_right(article438_and_7, PersonId, right_to_effective_remedy, breach_of_rights):-
    person_event(PersonId, breach_of_rights).