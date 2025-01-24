:- module(directive_2016_343_it, [has_right/5, auxiliary_right/5, auxiliary_right_checked/5, right_property/5, right_property_checked/5, explain/2]).

:- include('./../../utils.pl').

% Importable functor
has_right(Right, it, Article, PersonId, Matter) :-
	has_right(Article, PersonId, Right, Matter).

%%%% Lexical Reminder %%%%
%%The Constitution recognizes the presumption of innocence; not only that, even the criminal procedure code (c.p.p.) 
%guarantees the principle with three complementary rules. Articles 60 and 61 c.p.p. have the merit to extending the rights 
%of the defendant also to the suspect in criminal proceedings. So, the lexical distinction (defendant or suspect or accused) 
%does not translate into a different codicistic treatment.

%%%% Italian Constitution %%%%

%% has_right(_art24_2, PersonId, _right_to_defence, _proceedings)
%
% Article 24(2) Italian Constitution
% 
% Defense is an inviolable right at every stage and instance of legal proceedings.
has_right(art24_2, PersonId, right_to_defence, proceedings) :- 
    person_status(PersonId, suspect);
    person_status(PersonId, accused).

%% has_right(_art27_2, PersonId, _right_to_be_presumed_innocent, _proceedings)
%
% Article 27(2) Italian Constitution
% 
% The defendant is not considered guilty until the final judgement is passed
has_right(art27_2, PersonId, right_to_be_presumed_innocent, until_guilty) :- 
    person_status(PersonId, suspect);
    person_status(PersonId, accused),
    \+ proceeding_status(PersonId, concluded).

%% has_right(_art111_3, PersonId, _right_to_information, _accusations)
%
% Article 111(1; 2; 3; 4; 5) Italian Constitution
% 
% Jurisdiction is implemented through due process regulated by law. 
% All court trials are conducted with adversary proceedings and the parties are entitled to equal conditions before an impartial judge 
% in third party position. The law provides for the reasonable duration of trials. 
% In criminal law trials, the law provides that the alleged offender shall be promptly informed confidentially of 
% the nature and reasons for the charges that are brought and shall have adequate time and conditions to prepare a defence. 
% The defendant shall have the right to cross-examine or to have cross-examined before a judge the persons making accusations and to 
% summon and examine persons for the defence in the same conditions as the prosecution, as well as the right to produce all other 
% evidence in favour of the defence. The defendant is entitled to the assistance of an interpreter in the case that he or she does not 
% speak or understand the language in which the court proceedings are conducted.
% In criminal law proceedings, the formation of evidence is based on the principle of adversary hearings. 
% The guilt of the defendant cannot be established on the basis of statements by persons who, out of their own free choice, 
% have always voluntarily avoided undergoing cross-examination by the defendant or the defence counsel.
% The law regulates the cases in which the formation of evidence does not occur in an adversary proceeding with the consent of the 
% defendant or owing to reasons of ascertained objective impossibility or proven illicit conduct.

has_right(art111_3, PersonId, right_to_information, accusations) :-
    (   person_status(PersonId, suspect)
    ;   person_status(PersonId, accused)
    ).

has_right(art111_3, PersonId, right_to_cross_examination, accuser) :-
    person_status(PersonId, accused).

has_right(art111_3, PersonId, right_to_cross_examination, persons) :-
    person_status(PersonId, accused).

%%%% Criminal Procedure Code %%%%

% Article 60(1-2) code of criminal procedure
%1. A suspect becomes an accused person when she/he is charged with an offence in a request for committal to trial, immediate trial, 
%criminal decree of conviction, application of punishment under Article 447, paragraph 1 (called "patteggiamento"), in the decree of 
% direct summons for trial and in direct trial (known as "rito direttissimo");
%2. The person maintains the status of accused person at any subsequent stage and instance of the proceedings, until the judgment of 
% no grounds to proceed is no longer subject to appellate remedies (...).
% TODO - useless article? no difference in application?

%Article 61 code of criminal procedure
%1. The rights and safeguards of the accused person extend to the suspected person (...).

%% has_right(_art63, PersonId, _right_to_not_incriminate_themselves, _statements)
%
% Article 63 code of criminal procedure
%
% 1. If, before the judicial authority or the police, a person that does not have the status of defendant or suspects, makes statements 
% which reveal self-incriminatory evidence, the prosecuting authority shall interrupt the examination. The latter shall warning such 
% person that an investigation may be carried out against him/her as a result of such statements and invite him/her to appoint a lawyer.
% Previous statements may not be used against the person who made them.
% 2. If the person was to be heard from the very beginning as an accused or as a suspect, her/his statements may not be used.
has_right(art63, PersonId, right_to_not_incriminate_themselves, statements) :-
    (   proceeding_matter(PersonId, investigation)
    ;   proceeding_matter(PersonId, interrogation)
    ),
    \+ person_status(PersonId, suspect),
    \+ person_status(PersonId, accused).

%% has_right(_art64, PersonId, _right_to_not_incriminate_themselves, _proceedings)
%
% Article 64 code of criminal procedure
%
% 2. No methods or techniques may be used, even with the consent of the person questioned, which may affect his/her freedom of 
% self-determination or impair his/her ability to recall and assess the facts.
has_right(art64, PersonId, right_to_not_incriminate_themselves, proceedings) :-
    proceeding_matter(PersonId, investigation);
    proceeding_matter(PersonId, interrogation).

%% auxiliary_right(_art64_3a, PersonId, _right_to_not_incriminate_themselves, _)
%
% Article 64.3
%
% 3. Before the interrogation begins, the person must be warned that:
% (a) her/his statements may always be used against her/him;
% b) without prejudice to the provisions of article 66(1) c.p.p., s/he has the right not to answer any questions, but in any case 
% the procedure will follow its course;
% c) if s/he makes statements on facts concerning the liability of others, s/he will assume, with regard to such facts, 
% the office of witness, subject to the incompatibilities provided for in article 197 and the guarantees provided for in 
% article 197-bis c.p.p.
% 3bis. Failure to comply with the provisions of paragraph 3, letters a) and b), makes the statements made by the 
% questioned person unusable.
% In the absence of the warning referred to in paragraph 3(c), any statements made by the questioned person concerning facts 
% relating to the liability of others may not be used in relation to them, and the questioned person shall not assume the office 
% of witness in relation to those facts.
auxiliary_right_scope(art64_3a, [art64]).

auxiliary_right(art64_3a, PersonId, right_to_not_incriminate_themselves, statements) :-
	proceeding_matter(PersonId, interrogation).

auxiliary_right_scope(art64_3b, [art64]).

auxiliary_right(art64_3b, PersonId, right_to_not_incriminate_themselves, refuse_questions) :-
	proceeding_matter(PersonId, interrogation).

auxiliary_right_scope(art64_3c, [art63]).

auxiliary_right(art64_3c, PersonId, witness_quality, statements_concerning_others) :-
	proceeding_matter(PersonId, interrogation).

auxiliary_right_scope(art64_3bis, [art64]).

auxiliary_right(art64_3bis, PersonId, remedy, breach_of_rights) :-
    proceeding_matter(PersonId, breach_of_rights).

%% right_property(_art114_6bis, PersonId, _presentation, _no_pictures_while_physical_coercion)
%
% Article 114(6 bis) code of criminal procedure
%
%  The publication of pictures of a detained person taken while he was being handcuffed or subject to any other means of 
% physical coercion is prohibited without the person‟s consent (...);
right_property_scope(art114_6bis, [art24_2]).

right_property(art114_6bis, PersonId, presentation, no_pictures_while_physical_coercion) :-
    person_status(PersonId, detained),
    \+ person_event(PersonId, gave_consent).

% Article 224bis code of criminal procedure
% 1. When proceeding for a intentional offence, committed or attempted, for which the law establishes the penalty of life 
% imprisonment or imprisonment for a maximum of three years, for the crimes referred to in articles 589-bis and 590-bis of the 
% Penal Code and in the other cases expressly provided for by law, if it is necessary to perform acts that may affect personal 
% freedom in order to carry out the expert opinion, such as the removal of hair or mucous membranes from living persons for the 
% purpose of DNA profiling or medical examinations, and there is no consent from the person to be examined by the expert, 
% the court, including of its own motion, shall order, by reasoned order, the enforcement, if it is absolutely essential to prove the facts.
% 
% 2. In addition to the provisions of article 224, the order referred to in paragraph 1 contains the following provisions 
% on pain of nullity:
% a) the personal details of the person to be examined and anything else that may identify him/her;
% b) an indication of the offence for which the procedure is being carried out, with a summary description of the fact;
% c) the specific indication of the collection or ascertainment to be made and the reasons that make it absolutely essential 
% for the proof of the facts;
% (d) notice of the right to be assisted by a lawyer or a trusted person;
% e) notice that, in case of failure to appear not due to legitimate impediment, compulsory accompaniment may be ordered 
% pursuant to paragraph 6;
% f) the indication of the place, day, and time established for the performance of the act and the manner of performance.

% 3. The order referred to in paragraph 1 shall be served on the person concerned, the accused and his/her defence counsel 
% as well as on the victime at least three days before the date set for the execution of the expert witnesses' proceedings.
% 
% 4. No operations may be ordered which conflict with express prohibitions laid down by law or which may endanger the life, 
% physical integrity or health of the person or the unborn child, or which, according to medical science, may cause suffering of 
% no small amount.
% 
% 5. The expert opinions are in any case carried out with respect for the dignity and modesty of the person undergoing them. 
% In any case, to obtain a certain result, the least invasive techniques shall be chosen.
% 
% 6. If the person invited to appear for the purposes referred to in paragraph 1 does not appear without a legitimate impediment, 
% the judge may order that s/he be accompanied, even compulsorily, to the place, day and time established. 
% If, while appearing, s/he refuses to give her/his consent to the investigations, the judge shall order that they be 
% carried out compulsorily. The use of means of physical coercion is permitted only for the time strictly necessary for 
% the execution of the collection or investigation. The provisions of article 132 (2) c.p.p. shall apply.
% 
% 7. The act is null and void if the person subjected to the sampling or examination is not assisted by an appointed lawyer.

%% auxiliary_right(_art293_1_d, PersonId, _right, _remain_silent)
%
% Article 293(1)(d) code of criminal procedure
% 
% Enforcement requirements
% Without prejudice to Article 156, the official or officer in charge of enforcing the
% order of precautionary detention shall provide the accused person with a copy of the
% decision along with a clear and precise written notice. If the accused does not know
% the Italian language, the notice shall be translated into a language he understands.
% The notice shall contain the following information:
% d) his/her right to silence;
auxiliary_right_scope(art293_1_d, [art24_2, art63, art64]).

auxiliary_right(art293_1_d, PersonId, right, remain_silent) :-
	proceeding_matter(PersonId, precautionary_detention).

%% auxiliary_right(_art369bis_2a, PersonId, _right, _lawyer)
%
% Article 369 bis ((2)(a)) code of criminal procedure
%
% Notice to the suspect about his right to defence
% During the first activity in which the lawyer has the right to be present and, in any case, prior to sending
% the summons to appear for questioning according to the conjunction of Articles 375, paragraph 3, and 416, or no
% later than the service of the notice on the conclusion of preliminary investigations according to Article 415-bis,
% the Public Prosecutor, under penalty of nullity of subsequent acts, shall serve on the suspected person the
% notification of the designation of a court-appointed lawyer.
% The notification referred to in paragraph 1 shall contain:
% a) the information that technical defence in criminal proceedings is mandatory, along with the specification of the rights assigned 
% by law to the suspected person;
auxiliary_right_scope(art369bis_2a, [art24_2, art63, art64]).

auxiliary_right(art369bis_2a, PersonId, right, lawyer) :-
	person_status(PersonId, suspect),
	proceeding_matter(PersonId, lawyer_presence_required).

%% auxiliary_right(_art386_1_d, PersonId, _right, _remain_silent)
%
% Article 386(1)(d) code of criminal procedure
% 
% Duties of the criminal police in case of arrest or temporary detention
% The criminal police officials and officers who have arrested or placed under temporary
% detention the perpetrator or to whom the arrested person has been surrendered, shall
% immediately inform the Public Prosecutor of the place where the perpetrator has been
% arrested or placed under temporary detention. They shall provide the arrested or temporarily
% detained person with a written notice, drafted clearly and precisely. If the arrested or
% temporarily detained person does not know the Italian language, the notice shall be translated into a language he understands.
% The notice shall contain the following information:
% d) his/her right to silence;
auxiliary_right_scope(art386_1_d, [art24_2, art63, art64]).

auxiliary_right(art386_1_d, PersonId, right, remain_silent) :-
	proceeding_matter(PersonId, arrest).

auxiliary_right(art386_1_d, PersonId, right, remain_silent) :-
	proceeding_matter(PersonId, temporary_detention).

%% has_right(_art419_1, PersonId, _right_to_information, _day_time_place_hearing)
%
% Article 419(1) code of criminal procedure
% 
% The Preliminary Hearing Judge shall serve the notice of the day, time and place of the hearing on the accused and the 
% victim whose identity and address for service are specified in the case file, along with the request for committal to trial 
% submitted by the Public Prosecutor and the warning that, if the accused does not appear, the provisions of Articles 420-bis, 
% 420-ter, 420-quater and 420-quinquies shall be applied.
has_right(art419_1, PersonId, right_to_information, day_time_place_hearing) :-
    person_status(PersonId, accused),
    proceeding_matter(PersonId, preliminary_hearing).

%% has_right(_art420bis_1, PersonId, _right_to_appear, _hearing)
%
% Article 420 bis(1 - 3) code of criminal procedure
% 
% If the accused, free or detained, is not present at the hearing and, even if unable to appear, has expressly waived his right 
% to be present, the Preliminary Hearing Judge shall proceed in his absence;
has_right(art420bis_1, PersonId, right_to_appear, hearing) :-
    person_status(PersonId, accused),
    proceeding_matter(PersonId, preliminary_hearing),
    \+ person_event(PersonId, waive_right),
    \+ exception(has_right(art420bis_1, PersonId, right_to_appear, hearing), _).

% Without prejudice to the provisions of Article 420-ter, the Preliminary Hearing Judge shall also proceed in the absence of the 
% accused if the latter has lready declared or chosen an address for service during the proceedings or has been arrested or placed 
% under temporary detention or has been ordered a precautionary measure or has appointed a retained lawyer (...);

%% auxiliary_right(_art420bis_3, PersonId, _lawyer_represented, _hearing)
%
% Article 420bis.3 code of criminal procedure
%
% In the cases provided for in paragraph 1 and 2, the accused shall be represented by his lawyer. The accused who, after his/her 
% appearance, leaves the hearing room or, after appearing at a hearing, is not present at the following hearings, shall also be 
% considered present and represented by his/her lawyer.
auxiliary_right_scope(art420bis_3, [art420bis_1]).

auxiliary_right(art420bis_3, PersonId, lawyer_represented, hearing).

%% has_right(_art420ter_1, PersonId, _right_to_appear, _hearing)
%
% Article 420 ter(1) code of criminal procedure
% 
% If the accused, also detained, does not appear at the hearing and his absence is due to an absolute impossibility to appear 
% due to unforeseeable circumstances, force majeure or legal impediment, the Preliminary Hearing Judge, by means of an order, 
% also of his own motion, shall adjourn the hearing and order the renewal of the notice to the accused (...).
has_right(art420ter_1, PersonId, right_to_appear, hearing) :-
    person_status(PersonId, accused),
    person_status(PersonId, detained),
    proceeding_matter(PersonId, preliminary_hearing).

auxiliary_right_scope(art420ter_1, [art420ter_1]).

auxiliary_right(art420ter_1, PersonId, hearing_adjourned, renewal_notice) :-
    person_event(PersonId, not_appear_hearing), 
    (   person_circumstances(PersonId, unforeseeable)
    ;   person_circumstances(PersonId, force_majeur)
    ;   person_circumstances(PersonId, legal_impediment)
    ).

%% auxiliary_right(_art420quater_1, PersonId, _hearing, _)
%
% Article 420 quater(1; 2) code of criminal procedure
%
% 1. With the exception of the cases set out in Articles 420-bis and 420-ter and the cases of nullity of the service, 
% if the accused is not present, the Preliminary Hearing Judge shall adjourn the hearing and order the notice to be served 
% personally on the accused by the criminal police;
%% 2. When it is impossible to serve the notice according to paragraph 1 and unless a judgment must be delivered in line with 
% Article 129, the Preliminary Hearing Judge shall direct by order suspension of the trial against the accused who failed to appear. 
% The provision of Article 18, paragraph 1, letter b), shall apply. The provision of Article 75, paragraph 3, shall not apply.
auxiliary_right_scope(art420quater_1, [art420ter_1]).

auxiliary_right(art420quater_1, PersonId, hearing_adjourned, renewal_notice) :-
    person_status(PersonId, accused),
    person_event(PersonId, not_appear_hearing),
    proceeding_matter(PersonId, preliminary_hearing),
    \+ has_right(art420bis_1, PersonId, right_to_appear, hearing),
    \+ auxiliary_right(art420ter_1, PersonId, hearing_adjourned, renewal_notice).

auxiliary_right_scope(art420quater_2, [art420ter_1]).

auxiliary_right(art420quater_2, PersonId, trial_suspension, preliminary_hearing_judge) :-
    proceeding_event(PersonId, impossible_to_notice).

%% exception(_has_right(_art420bis_1, PersonId, _right_to_appear, _hearing), _art471_4_2)
%
% Article 471(4)(2) code of criminal procedure
% 
% Anyone disrupting the regular course of the hearing shall be removed by injunction of the President of the bench or, 
% in his absence, by the Public Prosecutor, and prevented from attending further activities at trial.
exception(has_right(art420bis_1, PersonId, right_to_appear, hearing), art471_4_2) :-
    person_danger(PersonId, proper_conduct_proceedings).

exception(has_right(art420ter_1, PersonId, right_to_appear, hearing), art471_4_2) :-
    person_danger(PersonId, proper_conduct_proceedings).

%% right_property(_art474, PersonId, _presentation, _not_physical_restraint_hearing) 
%
% Article 474 code of criminal procedure
% 
% The accused shall attend the hearing free from physical restraint devices, even if detained, unless in the latter case such devices 
% are necessary for preventing the risk of flight or violence (...).
right_property_scope(art474, [art24_2]).

right_property(art474, PersonId, presentation, not_physical_restraint_hearing) :-
    person_status(PersonId, accused),
    proceeding_matter(PersonId, hearing).

right_property(art474, PersonId, presentation, not_physical_restraint_hearing) :-
    person_status(PersonId, accused),
    person_status(PersonId, detained),
    proceeding_matter(PersonId, hearing),
    (   \+ person_danger(PersonId, flight_risk)
    ;   \+ person_danger(PersonId, violence_risk)
    ).

%% has_right(_art489_1, PersonId, _right_to_make_statements, _art494)
%
% Article 489 code of criminal procedure
% 
% 1. The accused who was prosecuted while he/she was absent during the preliminary hearing may request to make the statements 
% provided for in Article 494;
% 2. If the accused proves that his/her absence during the preliminary hearing was due to one of the situations referred to 
% in Article 420-bis, paragraph 4, he/she is granted a new time limit in order to submit the requests according to Articles 438 
% (known as "rito abbreviato") and 444 (called "patteggiamento").
has_right(art489_1, PersonId, right_to_make_statements, art494) :-
    person_status(PersonId, accused),
    person_event(PersonId, not_appear_hearing),
    proceeding_matter(PersonId, preliminary_hearing).

auxiliary_right_scope(art489_2, [art489_1]).

auxiliary_right(art489_2, PersonId, new_time_limit, art438_and_444).

% Article 530(2) code of criminal procedure
% The court shall deliver a judgment of acquittal also in case of insufficient, contradictory or lacking proof that the criminal 
% act occurred, the accused committed it, the act is deemed an offence by law, the offence was committed by a person with mental 
% capacity (...).

%% has_right(_art533_1, PersonId, _right_to_be_presumed_innocent, _beyond_reasonable_doubt)
%
% Article 533(1) code of criminal procedure
% 
% The court shall deliver a judgment of conviction if the accused is proven to be guilty of the 
% alleged offence beyond a reasonable doubt.
has_right(art533_1, PersonId, right_to_be_presumed_innocent, beyond_reasonable_doubt) :-
    person_status(PersonId, accused).

%% has_right(_art629bis_1, PersonId, _remedy, _rescission_judgement)
%
% Article 629 bis (1) code of criminal procedure
% 
% 1. The accused who has been absent for the entire duration of proceedings and has been convicted or ordered a security measure 
% with a final judgment, can obtain the rescission of the final judgment if he can prove that his absence was due to his inculpable 
% unawareness of the proceedings.
has_right(art629bis_1, PersonId, remedy, rescission_judgement) :-
    person_circumstances(PersonId, inculpable_absence).

%2. The request shall be submitted to the Court of Appeal in whose district the decision has been taken, under penalty of 
% inadmissibility. Submission shall take place within thirty days of acknowledgement by the accused of the proceedings and 
% shall be made either in person or through a lawyer holding a special power of attorney authenticated as per Article 583, paragraph 3.

% 3. The Court of Appeal shall decide in accordance with Article 127 and, should it accept the request, it shall rescind the 
% judgment and order that the case file be forwarded to the first instance court. The provision of Article 489, paragraph 2, shall apply.

% 4. Articles 635 and 640 shall apply. 


%%%% Implementing provisions, Criminal Procedure code %%%%

% Article 147 (1) code of criminal procedure
% for the right to report, the judge with an order, if the parties allow, may authorize in whole or in part the photographic, 
% phonographic or audiovisual recording or the radio or television broadcast of the trial, provided that there is no prejudice 
% to the peaceful and regular conduct of the hearing and the decision.

% Article 220 code of criminal procedure
% When during the no-criminal nvestigation provided for by laws or decrees the very first traces of crime emerge, the acts necessary 
% to ensure the sources of evidence and collect whatever else may be needed for the application of the criminal law are carried out 
% with the observance of the provisions of the code.

