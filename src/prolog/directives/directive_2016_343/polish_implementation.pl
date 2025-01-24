:- module(directive_2016_343_pl, [has_right/5, auxiliary_right/5, auxiliary_right_checked/5, right_property/5, right_property_checked/5, explain/2]).

:- include('./../../utils.pl').

% Importable functor
has_right(Right, pl, Article, PersonId, Matter) :-
	has_right(Article, PersonId, Right, Matter).

% TODO - In the transp tables arts 353 and 354 are missing?

%%%% Law of 6 June 1997 - Code of Criminal Procedure %%%%

%% Article 2(1-2) - Partially implemented
% § 1. The provisions of this Code are to ensure that in the course of criminal proceedings:
% 1) the offender is identified and called to criminal responsibility, and that such responsibility is not imposed on an innocent person.
%% § 2. The decisions can be based exclusively on actual established facts.

%% auxiliary_right(_art4, PersonId, _obligation, _presumption_innocence)
%
% Article 4 code of criminal procedure
% 
% Authorities conducting criminal proceedings are obliged to examine and take into consideration the circumstances both for 
% and against the accused.
auxiliary_right_scope(art4, [art5_1, art5_2]).

auxiliary_right(art4, PersonId, obligation, presumption_innocence) :-
    proceeding_type(PersonId, criminal).

%% has_right(_art5, PersonId, _right_to_be_presumed_innocent, _proceedings)
%
% Article 5(1 and 2) code of criminal procedure
% 
% The accused is presumed to be innocent until his guilt is proven and affirmed by the final judgment of the court.
% Irresolvable doubts are resolved exclusively in favour of the accused.
has_right(art5_1, PersonId, right_to_be_presumed_innocent, proceedings) :- 
    person_status(PersonId, accused),
    \+ proceeding_status(PersonId, concluded).

has_right(art5_2, PersonId, right_to_be_presumed_innocent, proceedings) :- 
    person_status(PersonId, accused),
    proceeding_matter(PersonId, irresolvable_doubts).

% Article 10(1) - Partially implemented
% § 1. With respect to an offence prosecuted ex officio, the authority responsible for the prosecution of offences is obliged 
% to institute and conduct preparatory proceedings, and the public prosecutor is moreover obliged to bring and support charges.

% Article 16(1) code of criminal procedure
% § 1. If the authority in charge of the proceedings is obliged to instruct the parties to the proceedings of their duties and rights, 
% the lack of such an instruction or an incorrect instruction may not result in any adverse consequences either to the participant 
% or any other person concerned with the proceedings.

% Article 41(1) code of criminal procedure
% § 1. A judge is disqualified, where such circumstances arise that might give rise to justified doubts as to 
% his impartiality in the case.
% § 2. A motion for disqualification of a judge filed pursuant to § 1 after the beginning of the trial shall not be examined, 
% unless the reason for disqualification arose or became known to a party only after the beginning of the trial.

% Article 46(2) - Partially implemented
% § 2. If preparatory proceedings were concluded in the form of an inquiry, the public prosecutor’s failure to appear at the trial 
% does not stop the proceeding. The presiding judge or the court may decide that the participation of the public prosecutor in the 
% trial is obligatory.

% Article 71(3) code of criminal procedure
% § 3. If the term “accused” is used in this Code with a general meaning, relevant provisions apply also to the suspect.

%% has_right(_art74_1, PersonId, _right_to_not_incriminate_themselves, _proceedings)
%
% Article 74 code of criminal procedure
%
% 1. The accused does not have to prove his innocence, or provide evidence against himself.
% 2. The accused is however obliged to submit to:
% 1) an external examination of the body and other tests not infringing his bodily integrity, in particular fingerprints and 
% photographs of the accused may be taken to present the accused to other persons for the purposes of identification,
% 2) psychological and psychiatric tests and bodily examinations involving treatment, with the exception of surgical procedures, 
% provided that they are carried out by an authorised health service employee in accordance with medical principles and without 
% risk to the health of the accused and that such examinations are necessary; in particular, if the above conditions are fulfilled, 
% the accused subjects himself to the collection of blood, hair and bodily secretions, subject to point 3,
% 3) collection by a Police official of a buccal mucosa smear, if it is indispensable and does not pose a threat to the heath of the 
% accused or other people.
has_right(art74_1, PersonId, right_to_not_incriminate_themselves, proceedings) :-
    person_status(PersonId, accused),
    \+ exception(has_right(art74_1, PersonId, right_to_not_incriminate_themselves, proceedings), _).

exception(has_right(art74_1, PersonId, right_to_not_incriminate_themselves, proceedings), art74_2_1) :-
    proceeding_matter(PersonId, external_examination_body).

exception(has_right(art74_1, PersonId, right_to_not_incriminate_themselves, proceedings), art74_2_2) :-
    (   proceeding_matter(PersonId, psychological_tests)
    ;   proceeding_matter(PersonId, psychiatric_tests)
    ;   proceeding_matter(PersonId, bodily_treatment)
    ).

exception(has_right(art74_1, PersonId, right_to_not_incriminate_themselves, proceedings), art74_2_3) :-
    proceeding_matter(PersonId, collection_mucosa_smear).

% § 3. A suspected person may be subject to the tests and procedures referred to in § 2 point 1, and also, respecting the requirements 
% set forth in § 2 points 2 or 3, have blood samples, hair, a buccal mucosa smear, and other bodily secretions collected.
% 
% § 3a. The accused and the suspected person are summoned to submit to the obligations arising from § 2 and 3. If they refuse to 
% submit to these obligations, the accused and the suspected person may be arrested and brought forcibly, as well as physical 
% force and technical measures serving the purpose of restraining them may be applied to the extent necessary for the performance 
% of a given procedure.

% Article 170(1)(1) code of criminal procedure
% § 1. An evidentiary motion is dismissed, if:
% 1)  examination of evidence is inadmissible (…).

% Article 171(5 and 7) code of criminal procedure
%§ 5. It is prohibited to:
%1) influence the statements of the testifying person by means of force or illicit threat,
%2) use hypnosis, chemical substances or technical means in order to influence psychical processes in the body of the testifying 
% person or allow control of the unconscious reactions of the body in connection with the examination.
%§ 7. Explanations, testimonies and statements made in circumstances precluding freedom of speech or obtained against the 
% prohibitions mentioned in § 5, may not constitute evidence

%% has_right(_art175_1, PersonId, _right_to_provide_explanations, _)
%
% Article 175(1 and 2) code of criminal procedure
%
% 1. The accused has the right of providing explanations. However, without giving reasons, he may refuse to answer certain 
% questions or refuse to give explanations. The accused should be advised of this right.
% 2. The accused attending evidentiary procedures may provide explanations with respect to every piece of evidence.
has_right(art175_1, PersonId, right_to_provide_explanations, proceedings) :- 
    person_status(PersonId, accused).

has_right(art175_1, PersonId, right_to_refuse_answering, proceedings) :- 
    person_status(PersonId, accused).

has_right(art175_2, PersonId, right_to_provide_explanations, evidence) :- 
    person_status(PersonId, accused),
    proceeding_matter(PersonId, evidentiary_procedure).

% Article 176(1, 2, 3 and 4) - Partially implemented
% § 1. In preparatory proceedings during the examination the accused should, at his request or at the request of his defence counsel, 
% be granted the possibility of giving explanations in writing. In such cases, the person conducting the examination undertakes 
% measures to prevent communication between the accused with another person while writing the explanations.
% 
% § 2. The person conducting the examination may, for important reasons, deny to the accused party consent to give explanations 
% in writing.
% 
% § 3. (repealed)
% 
% § 4. Written explanations of the accused, signed by him and mentioning the date, on which there were given, are 
% attached to the record.

% Article 217(1, 2, 3, 4 and 5) code of criminal procedure
% § 1. Objects which may serve as evidence or which are subject to seizure in order to secure financial penalties, penal measures of 
% financial nature, forfeiture, compensatory measures or claims for compensation for damage, should be surrendered at the request of 
% the court, the public prosecutor, and in urgent cases, of the Police or other authorised agency.
% 
% § 2. A holder of an object subject to seizure is called upon to surrender it voluntarily.
% 
% § 3. In case of seizure, Article 288 applies accordingly. A transcript thereof need not be taken, if the object is attached to 
% the case files.
% 
% § 4. If the surrender is demanded by the Police or by other authorised agency acting on its own behalf, the person surrendering 
% the object may immediately request that the decision approving the seizure be drawn up by the court or the public prosecutor 
% and delivered. A person surrendering an object should be advised of that right. The decision should be served within fourteen 
% days of the seizure.
% 
% § 5. In the case of a refusal to surrender an object voluntarily, it may be seized by force. Articles 220 § 3 and 229 apply accordingly.

% Article 219(1 and 2) code of criminal procedure
% § 1. In order to detect, detain or forcibly arrest a suspected person, and also to find objects which might constitute evidence in a 
% case or which are subject to seizure in criminal proceedings, a search of premises or other places may be conducted, if there are 
% justified grounds for the belief that either a suspected person or specified objects are there.
% 
% § 2. In order to find the objects referred to in § 1, a search of persons, their clothing and personal effects may also be carried 
% out under the condition set forth in this provision.

% Article 244(2) code of criminal procedure
% § 2. The arrestee is immediately informed of the reasons for the arrest and of his rights, including the right to use the 
% assistance of an advocate or legal counsel and a gratuitous help of an interpreter, if the arrestee does not have a sufficient 
% command of Polish, to make statements and to refuse making statements, to obtain copy of an arrest report, to have access to 
% medical first aid, as well as of his rights indicated in Article 245, Article 246 § 1 and Article 612 § 2 and of the contents 
% of Article 248 § 1 and 2. The arrestee’s explanations should also be heard.

% TODO - useless for the purpose of this directive?

%% right_property(_art249_1, PersonId, _preventive_measure, _proceedings)
%
% Article 249(1) code of criminal procedure
%
% Preventive measures may be ordered in order to ensure the correct course of proceedings and, exceptionally, 
% in order to prevent the accused from committing a new serious offence. They may be ordered only if, according to the 
% evidence already collected, it is highly probable that that the accused committed the offence.
right_property_scope(art249_1, [art5_1, art5_2]).

right_property(art249_1, PersonId, preventive_measure, proceedings) :-
    person_circumstances(PersonId, probable_guilt).

% Article 313(1, 2, 3 and 4) - Partially implemented
% § 1. If information existing at the moment of initiating the investigation or collected during the investigation, sufficiently 
% justifies the suspicion that the offence was committed by a specific individual, the decision to bring charges is drawn up and 
% announced to the suspect. The suspect is interrogated, unless the announcement of the decision and the examination of the suspect 
% are not possible because he is in hiding or absent from the country.
% 
% § 2. The decision to bring charges indicates the suspect, an exact description of the offence with which he is charged and its 
% legal qualification.
%
% § 3. The suspect may, until such time that he is notified of the date to examine files gathered during the investigation, 
% demand that the grounds for the charges be explained to him verbally and the statement of reasons be drawn up in writing. 
% The suspect should be advised of these rights. The statement of reasons is served upon the suspect and the appointed defence 
% counsel within 14 days.
% 
% § 4. The statement of reasons should clarify in particular on what facts and evidence the charges are based.

% Article 335(1) - Partially implemented
% § 1. If the accused pleads guilty and in view of his explanations the circumstances of the offence and the guilt of the accused 
% do not raise doubts and the attitude of the accused indicates that purposes of the proceedings will be achieved, it is 
% permissible to refrain from further actions. If there is a need to evaluate the credibility of the explanations of the accused, 
% evidentiary procedures are conducted only to a necessary extent. However, in any case, within the limits necessary to secure 
% traces and evidence against loss, distortion or destruction, trial procedures should be conducted, including in particular an 
% inspection, if necessary with participation of an expert, a search or procedures referred to in Article 74 § 2 point 1 in relation 
% to a person suspected of an offence and other necessary procedures with respect to such a person, including the collection of 
% samples of blood, hair or other body fluids. The public prosecutor, instead of an indictment, files with the court a motion to 
% issue a sentence of conviction and imposition on the accused of a penalty or a penal measure agreed with him, applicable to a 
% summary offence, with which the accused is charged and taking into consideration legally protected interests of the aggrieved party. 
% The agreement may also include a determined decision concerning court costs.

% Article 338(1 and 1a) code of criminal procedure
% § 1. If the indictment meets the formal requirements, the president of the court or the court referendary immediately orders that
% a copy be served upon the accused summoning him to submit evidentiary motions within seven days of the service of the indictment.
% § 1a. The accused is also instructed of the contents of Article 291 § 3, Article 338a, Article 338b, Article 341 § 1, 
% Article 349 § 8, Article 374, Article 376, Article 377 and Article 422 and the fact that depending on the results of the trial, 
% he may be charged with the costs of appointment of the defence counsel ex officio.

% Article 366(1) - Partially implemented
% § 1. The presiding judge presides over the trial and ensures its proper course, bearing in mind that all significant circumstances 
% of the case be clarified.

%% has_right(_art374_1, PersonId, _right_to_appear, _trial)
%
% Article 374(1, 1a and 2) code of criminal procedure
% 
% 1. The accused has the right to participate in the main trial. The presiding judge or the court may decide that the presence 
% of the accused at the main trial is mandatory.
% 1a. In the cases concerning summary offences, the presence of the accused is mandatory during the procedures referred to in 
% Article 385 and 386.
has_right(art374_1, PersonId, right_to_appear, trial) :-
    person_status(PersonId, accused),
    \+ exception(has_right(art374_1, PersonId, right_to_appear, trial), _).

has_right(art374_1, PersonId, right_to_appear, summary_offences) :-
    person_status(PersonId, accused),
    proceeding_matter(PersonId, summary_offences).

% § 2. The presiding judge may issue an order to prevent the accused from leaving the court before the conclusion of the hearing.

%% right_property(_art376_1, PersonId, _appear_trial, _mandatory)
%
% Article 376(1, 2 and 3) code of criminal procedure
% 
% 1. If the accused, whose presence at the trial is mandatory, has already provided explanations and left the courtroom without 
% the presiding judge’s permission, the hearing may proceed despite his absence. The court may order that the accused be arrested 
% and brought to trial by force, if his presence is found indispensable. The decision on the arrest and bringing the accused to 
% trial by force is subject to interlocutory appeal to another equivalent panel of the same court.
right_property_scope(art249_1, [art374_1, art390_1]).

right_property(art376_1, PersonId, appear_trial, mandatory) :-
    authority_decision(PersonId, appearance_mandatory).

% § 2. The provision of § 1 applies accordingly, if the accused who has already provided explanations, having been notified of the 
% date of a deferred or adjourned trial, fails to appear at that trial without justification.
% 
% § 3. If a co-accused, who has justified his absence, fails to appear at a deferred or adjourned hearing, the court may conduct the 
% hearing to the extent not directly concerning the absentee accused, if this does not limit his right to defend himself.

%% exception(_has_right(_art374_1, PersonId, _right_to_appear, _trial), _art377_1)
%
% Article 377(1, 2, 3 and 4) code of criminal procedure
%
% 1. If the accused, by his own fault, renders himself incapable of participating in a trial or hearing in which his participation 
% is mandatory, the court may decide that the proceedings be conducted in his absence, even if he has not yet provided explanations.
% § 2. Before the decision mentioned in § 1 is issued, the court considers a medical certificate from the physician who diagnosed 
% such an incapacity and examines him in the capacity of an expert. The condition of incapacity to participate in the trial may 
% also be diagnosed by a test not connected with a violation of bodily integrity, made with the use of an appropriate device.
% 
% § 3. If the accused, whose presence at the trial is mandatory, notified of the date of the trial, declares that he will not 
% participate in the trial, makes it impossible to bring him to the trial or notified personally of the trial fails to appear 
% without justification, the court may conduct the proceedings without his participation. The court may, however, decide the 
% accused be arrested and brought to trial by force. The decision on the arrest and bringing the accused to trial by force is 
% subject to interlocutory appeal to another equivalent panel of the same court.
exception(has_right(art374_1, PersonId, right_to_appear, trial), art377_1) :-
    person_event(PersonId, incapable_to_participate).

exception(has_right(art374_1, PersonId, right_to_appear, trial), art377_3) :-
    person_event(PersonId, waive_right).

% § 4. If the accused has not yet given explanations before the court, Article 396 § 2 may apply or the reading of his previous 
% explanations may be found sufficient. The accused may be interrogated by using the means referred to in Article 177 § 1a.

%% exception(_has_right(_art374_1, PersonId, _right_to_appear, _trial), _art378a_1)
%
% Article 378a code of criminal procedure
%
% 1. If an accused or defence lawyer failed to appear before the court, although they were informed about the term of the hearing, 
% the court, in a particularly justified case, may conduct evidentiary proceedings even if an accused and a defence lawyer duly 
% justified their absence, and in particular may examine witness even if an accused has not given a statements during a trial yet.
% § 2. In the case referred to in § 1, it will be necessary to summon or notify an accused or his defence lawyer on the next term of a 
% court hearing, if they do not know this term. An accused and a defence lawyer should be instructed in accordance to §7.
%
% § 3. If the court has conducted evidence in the absence of the accused or defender in the accident referred to in § 1, the accused 
% or the defender may on the next date of the hearing at least, of which he was duly notified with no procedural obstacles to his 
% appearance, submit a request for additional evidence carried out during his absence. The right to submit an application is not 
% entitled if it turns out that the absence of the accused or defence counsel at the date of the trial at which evidence proceedings 
% were conducted pursuant to § 1 was unjustified.
exception(has_right(art374_1, PersonId, right_to_appear, trial), art378a_1) :-
    proceeding_circumstances(PersonId, absence_justified),
    person_event(PersonId, not_appear_hearing).

auxiliary_right_scope(art378a_3, [art374_1, art390_1]).

auxiliary_right(art378a_3, PersonId, failure_to_appear, request_additional_evidence) :-
    person_event(PersonId, not_appear_hearing),
    \+ proceeding_circumstances(PersonId, absence_justified).

% § 4. In failure to submit the application within the time limit referred to in § 3, first sentence, the right to submit it expires 
% and in subsequent proceedings it is not permissible to raise a plea in breach of procedural guarantees, in particular the right 
% to defence, as a result of conducting this evidence in the absence of the accused or defenders.
% 
% § 5. In the application for supplementary taking of evidence, the accused or defense lawyer must demonstrate that the manner in 
% which evidence was taken during his absence violated procedural guarantees, in particular the right to defense.
% 
% § 6. If the request for supplementary taking of evidence is granted, the court shall take supplementary evidence only to the extent 
% that a breach of procedural guarantees, in particular the right to defense, has been demonstrated.
% 
% § 7. If the accused or defense lawyer shows up for the date of the trial referred to in § 3, first sentence, the chairman instructs 
% him about the possibility of submitting a request for supplementary taking of evidence taken during his absence, and about the 
% content of the provisions of § 4 and 5, and also enables him comment on this issue.

% Article 388 - Partially implemented
% Upon the consent of the attending parties, the court may conduct evidentiary proceedings only in part, if the explanations of 
% the accused pleading guilty do not raise doubts.

%% has_right(_art390_1, PersonId, _right_to_appear, _evidentiary_procedure) 
%
% Article 390(1, 2 and 3 ) code of criminal procedure
% 
% 1. The accused has the right to attend all evidentiary procedures.
% § 2. In exceptional circumstances, when there is a reason to fear that the presence of the accused might inhibit the 
% explanations of a co-accused or the testimonies of a witness or an expert, the presiding judge may order that the accused 
% should leave the courtroom for the duration of a given person’s examination. Article 375 § 2 applies accordingly.
has_right(art390_1, PersonId, right_to_appear, evidentiary_procedure) :-
    person_status(PersonId, accused),
    proceeding_matter(PersonId, evidentiary_procedure),
    \+ exception(has_right(art390_1, PersonId, right_to_appear, evidentiary_procedure), _).

exception(has_right(art390_1, PersonId, right_to_appear, evidentiary_procedure), art390_2) :-
    (   person_danger(PersonId, proper_conduct_proceedings)
    ;   person_danger(PersonId, inhibit_explanations_coaccused)
    ;   person_danger(PersonId, inhibit_testimonies)
    ).

% § 3. In the circumstances indicated in § 2 the presiding judge may also carry out the examination with the use of technical 
% devices allowing this procedure to take place remotely, with a simultaneous transmission of sound and vision. At the place 
% where explanations or testimonies are provided, the procedure is attended by a court referendary, assistant of a judge or a court clerk.

% TODO - Auxiliary/property for an exception?

% Article 396a(1, 2, 3 and 4) - Partially implemented
% § 1. If, during the course of the trial, material shortcomings of preparatory proceedings are revealed, the removal of which by 
% the court would render it impossible to issue a judgment within a reasonable period and which cannot be removed pursuant to 
% Article 396, the court may interrupt or adjourn the trial, setting a time limit, within which the public prosecutor should 
% produce such evidence, which would allow the above shortcomings to be removed.
% 
% § 2. In an effort to gather the evidence referred to in § 1, the public prosecutor may personally perform all necessary evidentiary 
% procedures, and the public prosecutor may order their performance to the Police.
% 
% § 3. If it is impossible to observe the prescribed time limit, the public prosecutor may request the court to extend it.
% 
% § 4. If, within the prescribed time limit, the public prosecutor fails to produce appropriate evidence, the court resolves all 
% doubts resulting from the lack of such evidence in favour of the accused.

%% auxiliary_right(_art438_2, PersonId, _remedy, _judgement)
%
% Article 438(2) code of criminal procedure
% 
% The judgment is reversed or changed if it is found that:
% 2) the provisions of procedural law were violated, if this might have affected the contents of the judgment.
auxiliary_right_scope(art438_2, [art5_1, art5_2, art74_1, art374_1, art390_1]).

auxiliary_right(art438_2, PersonId, remedy, judgement) :-
    proceeding_matter(PersonId, violation_procedural_law).

% Article 485 code of criminal procedure
% In cases prosecuted by private accusation, provisions concerning ordinary proceedings apply, with the observance of 
% the provisions of this Chapter.

% Article 487 code of criminal procedure
% An indictment may be limited to the indication of the accused person, the act of which he is accused and details of the 
% evidence on which the accusation is based.

%% auxiliary_right(_art540b_1, PersonId, _remedy, _new_trial)
%
% Article 540b(1 and 2) code of criminal procedure
% 
% 1. Judicial proceedings concluded with a final and binding court judgment may be reopened at the request of the accused, 
% submitted within a final time limit of one month of the day on which he learns of the judgment issued against him, if the 
% case is heard in the absence of the accused, who was not served a notification of the date of the hearing or trial, or such 
% a notification was not served on him personally and he is able to prove that he was not aware of the date and the possibility 
% of a judgment being delivered in his absence.
auxiliary_right_scope(art378a_3, [art5_1, art5_2, art74_1, art374_1, art390_1]).

auxiliary_right(art540b_1, PersonId, remedy, new_trial).

% § 2. The provisions of § 1 do not apply in cases referred to in Article 133 § 2, Article 136 § 1 and Article 139 § 1, and also 
% if the defence counsel has participated in the trial or hearing.

%%%% Criminal code %%%%

% Article 53(1, 2 and 3) - Partially implemented
% § 1. The court passes a sentence at its own discretion, within the limits prescribed by law, ensuring that the severity does not 
% exceed the degree of guilt, being aware of the degree of social consequences of the act, and taking into account the preventive and 
% educational objectives that the penalty is to achieve with regard to the offender, as well as the need to develop legal awareness 
% in society.
% 
% § 2. When passing sentence, the court will primarily take into account the motivation of the offender and the way he or she acted, 
% whether the offence was committed together with a minor, the type and degree of the breach of duties the offender is charged with, 
% the type and degree of any negative consequences of the offence, the features and personal conditions of the offender, his or her 
% lifestyle before committing the offence, and his or her conduct afterwards, and in particular any efforts to redress the damage or 
% to satisfy the public sense of justice in any way. The court will also take the behaviour of the aggrieved party into account.
% 
% § 3. When passing sentence, the court will also take into account the positive results of mediation between the aggrieved party and 
% the offender, or any settlement they may have reached in the proceedings before the prosecutor or the court.

% Article 212(1, 2, 3 and 4) code of criminal procedure
% § 1. Anyone who slanders another person, a group of people, a business entity or an organisational unit without the status 
% of a business entity, about conduct, or characteristics that may discredit them in the face of public opinion, or result in a 
% loss of confidence necessary to perform in a given position, occupation or type of activity is liable to a fine, 
% the restriction of liberty.
% 
% § 2. If the offender commits the act specified in § 1 through the mass media, he or she is liable to a fine, the restriction 
% of liberty or imprisonment for up to 1 year.
% 
% § 3. When sentencing for an offence specified in §§1 or 2, the court may award exemplary damages to the aggrieved party or the 
% Polish Red Cross, or to another social cause designated by the aggrieved party.
% 
% § 4. The prosecution of the offence specified in §§ 1 or 2 takes place at a private motion.

% Article 216(1, 2, 3, 4 and 5) code of criminal procedure
% § 1. Anyone who insults another person in his or her presence, or publicly in his or her absence, or with the intention that 
% the insult will reach such the person, is liable to a fine or the restriction of liberty.
% 
% § 2. Anyone who insults another person using the mass media is liable to a fine, the restriction of liberty or imprisonment for 
% up to one year.
% 
% § 3. If the insult was caused by the provocative conduct of the aggrieved party, or if the aggrieved party responded with a 
% breach of the personal inviolability or with a reciprocal insult, the court may waive the imposition of a penalty.
% 
% § 4. In the event of a conviction for the offence specified in § 2, the court may decide to set compensatory damages to the 
% aggrieved party, the Polish Red Cross or towards another social cause indicated by the aggrieved party.
% 
% § 5. Prosecution takes place at a private motion.

%%%% Civil code %%%%

% Article 23 code of criminal procedure
% The personal interests of a human being, in particular health, freedom, dignity, freedom of conscience, surname or 
% pseudonym, image, secrecy of correspondence, inviolability of home, and scientific, artistic, inventor's and rationalizing 
% activity, shall be protected by civil law independent of protection envisaged in other provisions.

% Article 24(1, 2 and 3) code of criminal procedure
% § 1. The person whose personal interests are threatened by another person's activity may demand the omission of that action 
% unless it is not illegal. In case of an infringement he may demand that the person who committed the infringement perform 
% acts necessary to remove its effects and in particular to make a statement of an appropriate contents and in an appropriate form. 
% On the terms provided for in this Code he may also demand pecuniary compensation or an appropriate sum of money paid to a 
% specified public purpose.

% § 2. If, as a result of an infringement of a personal interest, a damage to property has occurred, the injured person may demand 
% that it be redressed in accordance with general principles.

% § 3. The above provisions shall not prevail over the rights envisaged by other provisions, in particular by the copyright law 
% and the law on inventions.

%%%% Law of the Prosecutor Office %%%%

% Article 12(1, 2, 3 and 4) - Partially implemented
% Article 12 of the Law of the Prosecutor Office
% § 1. The Prosecutor General, the National Prosecutor or other prosecutors authorized by them may provide public authorities, 
% and in particularly justified cases also to other persons, information on the activities of the prosecutor's office, including 
% information on specific cases, if such information may be relevant for national security or its proper functioning.
% 
% § 2. The Prosecutor General and the heads of organizational units of the prosecutor's office may provide the media personally, 
% or authorize another prosecutor for this purpose, information from pending preparatory proceedings or regarding the activities 
% of the prosecutor's office, excluding classified information, bearing in mind the important public interest.
% 
% § 3. In the cases referred to in § 1 and 2, it is not required to obtain the consent of the person conducting 
% the preparatory proceedings.
% 
% § 4. Liability for all claims arising in connection with the activities referred to in § 1 and 2 shall be borne by 
% the State Treasury. The responsibility of the Treasury also includes the obligation to submit a statement with 
% appropriate content and in an appropriate form, as well as the obligation to pay the sum for a given social purpose.

