:- module(directive_2016_343_nl, [has_right/5, auxiliary_right/5, auxiliary_right_checked/5, right_property/5, right_property_checked/5, explain/2]).

:- include('./../../utils.pl').

% Importable functor
has_right(Right, nl, Article, PersonId, Matter) :-
	has_right(Article, PersonId, Right, Matter).

%%%% Lexical Consistency %%%%

% As a further preliminary remark, note that the term 'suspect' in this table may refer to the suspect or the accused, or both, 
% depending on the context. This corresponds to the Dutch legal terminology, in which persons suspected of a crime are called 
% 'suspects', both before and after indictment.

%%%% (Dutch) Code of Criminal Procedure %%%%

%% has_right(_art29_1, PersonId, _right_to_not_incriminate_themselves, _questioning)
%
% Article 29(1) code of criminal procedure
% 
% In all cases where a person is being questioned as a suspect or defendant, the judge or officer, who is conducting the questioning, 
% shall refrain from any act aimed at obtaining a statement which cannot be said to have been freely given.
has_right(art29_1, PersonId, right_to_not_incriminate_themselves, questioning) :-
    proceeding_matter(PersonId, questioning).

%% has_right(_art29_2, PersonId, _right_to_remain_silent, _proceeding)
%
% Article 29(2) code of criminal procedure
% 
% The suspect or the defendant shall not be obliged to answer any questions. Before the suspect or the defendant is questioned, 
% he shall be informed that he is not obliged to answer any questions
has_right(art29_2, PersonId, right_to_remain_silent, proceeding) :-
    proceeding_matter(PersonId, questioning).

%% right_property(_art36b, PersonId, _notification, _personNotificationNL)
%
% Article 36b code of criminal procedure
%
% 1 The notification of judicial communications shall be given to natural persons, as provided for in this Code and the
% Criminal Code, by:
% a. service;
% b. transmission;
% c. oral communication.
% Service of a judicial communication shall be effected by presentation or via an electronic transmission, in the manner provided
% for by the law. If service by electronic transmission is not possible or is not possible within a reasonable period of time,
% service shall be effected by presentation.
% Transmission shall be effected by delivery of an ordinary or registered letter by a postal transport company as referred to in
% the Postal Act 2009 or by a service or other institution of transport designated for this purpose by or pursuant to a
% legislative decree, or by electronic transfer, in a manner determined by or pursuant to a legislative decree.
% An oral communication shall be recorded in an official report or otherwise in writing as soon as possible.
right_property_scope(art36b, [art258]).

right_property(art36b, PersonId, notification, A) :-
    person_notification(PersonId, A),
    member(A, [service, transmission, oral_communication, electronic_transmission, postal_delivery]).

right_property(art36b, PersonId, notification, personNotificationNL) :-
    person_notification(PersonId, personNotificationNL).

%% right_property(_art36e, PersonId, _notification, _personNotificationNL)
%
% Article 36e(1)
%
% The judicial notification referred to in article 36b, paragraph 2, shall be issued:
% a. to the person whose freedom has been deprived in law in the Netherlands in connection with the criminal proceedings to which the judicial notification to be 
% issued relates, and to the person whose freedom has been deprived in law in the Netherlands in other cases determined by or pursuant to an order in council: in person;
% b. to all others: in person or if service in person is not prescribed and the notification is offered in the Netherlands:
% 1°. to the address at which the addressee is registered as resident in the key register of persons, or,
% 2°. if the addressee is not registered as a resident in the key register of persons, at the place of residence or domicile of the addressee.
% Article 36e(2)
% If in the case referred to in the first paragraph, part b,
% a. the addressee is not found, the document shall be delivered to the person at that address who agrees to forward it without delay to the addressee;
% b. it has not been possible to deliver the document, the judicial notification shall be delivered to the Public Prosecutor's Office. If it subsequently 
% transpires that on the day of the offer and at least five days thereafter the addressee was registered as resident in the key register of persons at the address 
% indicated in the notification, a copy of the judicial notification shall then be sent without delay to that address, as well as to the address in the Netherlands 
% indicated by the defendant to which communications concerning the criminal proceedings may be sent. In the cases referred to in this section, a record of delivery 
% as referred to in Article 36h shall be drawn up. The record shall note the delivery to the Public Prosecutor's Office and, if there is one, the despatch of the document.
right_property_scope(art36e, [art258]).

right_property(art36b, PersonId, notification, A) :-
    person_notification(PersonId, A),
    member(A, [service, transmission, oral_communication, electronic_transmission, postal_delivery]).

right_property(art36e, PersonId, notification, personNotificationNL) :-
    right_property(art36b, PersonId, notification, personNotificationNL).

%% right_property(_art62_1, PersonId, _presentation, _not_restrictions)
%
% Article 62(1) code of criminal procedure
% 
% The suspect taken into police custody shall not be subjected to any restrictions other than those that are absolutely necessary in 
% the interest of the investigation and in the interest of order.
right_property_scope(art62_1, [art271_2, art338_1]).

right_property(art62_1, PersonId, presentation, not_restrictions) :-
    \+ proceeding_circumstance(PersonId, necessary_investigation).

% Article 76 code of criminal procedure
% In the case of pre-trial detention, Article 62 and 62a shall apply mutatis mutandis.

% Article 151b(1) code of criminal procedure
% The public prosecutor may order in the interest of the investigation for the purpose of DNA testing as referred to in 
% section 151a(1) that cellular material be taken from the suspect of a serious offence as defined in section 67(1), against whom 
% there are serious suspicions, if he refuses to give his written consent. Section 151a(2) and (4) to (10) inclusive shall apply 
% mutatis mutandis

% TODO - Fix as exception?

%% has_right(_art173, PersonId, _right_to_not_incriminate_themselves, _statements)
%
% Article 173 code of criminal procedure
% 
% No questions shall be posed [by an investigating judge] which are aimed at obtaining a statement which cannot be said to have 
% been freely given.
has_right(art173, PersonId, right_to_not_incriminate_themselves, statements) :-
    person_event(PersonId, make_statements).

% Article 195d(1) code of criminal procedure
% The investigating judge may, ex officio or on application of the public prosecutor, order in the interest of the investigation 
% for the purpose of DNA testing as referred to in section 195a(1) that cellular material be taken from the suspect of a serious 
% offence as defined in section 67(1), against whom there are serious suspicions, if he refuses to give his written consent. 
% Sections 195a(2) to (5) inclusive,195b and 195c shall apply mutatis mutandis

%% has_right(_art219, PersonId, _right_to_remain_silent, _proceeding)
%
% Article 219 code of criminal procedure
% 
% The witness may assert privilege and refuse to answer a question posed to him, if by answering such question he would expose himself 
% or one of his relatives by consanguinity or affinity in the direct line or in the collateral line in the second or third degree, 
% his spouse or former spouse or civil registered partner or former civil registered partner to the risk of criminal prosecution
has_right(art219, PersonId, right_to_remain_silent, proceeding) :-
    person_status(PersonId, witness).

% Article 257a(1) code of criminal procedure
% The public prosecutor may, if he establishes that a minor offence or a serious offence which carries a statutory term of 
% imprisonment not exceeding six years, has been committed, issue a punishment order.

% Article 258(1) code of criminal procedure
% The case shall be brought before the court by means of a summons served on behalf of the public prosecutor on the suspect; 
% the start of the criminal proceedings is thus initiated.

%% has_right(_art258, PersonId, _right_to_be_present, _trial)
%
% Article 258 code of criminal procedure
%
% The case shall be brought before the court by means of a summons served on behalf of the public prosecutor on the suspect; 
% the start of the criminal proceedings is thus initiated.
% The presiding judge of the District Court shall determine, on application and recommendation of the public prosecutor, the date 
% and time of the court session. In the determination of the date and time of the court session or later, he may order that the suspect 
% appear in person; to that end he may also order that he be forcibly brought to court. The presiding judge may also order that a witness 
% who, based on facts and circumstances, is not thought likely to comply with the summons to appear at the court session, be forcibly 
% brought to court. In addition, the presiding judge of the District Court may order the public prosecutor to conduct further investigations 
% or have others conduct further investigations, and to add data carriers and documents to the case documents or to submit convicting 
% pieces of evidence.
has_right(art258, PersonId, right_to_be_present, trial) :-
    person_status(PersonId, suspect);
    person_status(PersonId, accused).

% TODO - Add obligation upon defendant?

% Article 265(1) code of criminal procedure
% A period of at least ten days must have expired between the day on which the summons is served on the suspect and the day of the 
% court session. In the event that the investigating judge has issued orders for the maintenance of public order in accordance with 
% Part Seven of Book Four, a period of at least four days must have expired. 

% Article 265(2) code of criminal procedure
% If the summons is served in the manner provided for in article 36d(3) [by a police officer or another official designated by 
% ministerial decree for this purpose], the suspect may have included in the record of delivery a statement in which he consents to a 
% reduction of this time limit; he must sign the statement; if he is unable to sign, the cause of the inability shall be stated 
% in the record.

%% auxiliary_right(_art265_3, PersonId, _postponement, _hearing_adjournment)
%
% Article 265(3) code of criminal procedure
% 
% If the one or the other is omitted, the District Court shall adjourn the hearing, unless the suspect has appeared. 
% In the latter case and if the suspect applies for a postponement in the interest of his defence, then the District Court shall 
% adjourn the hearing for a definite period, unless it considers in a reasoned decision that, in all reasonableness, continuation 
% of the hearing cannot prejudice the suspect in his defence.
auxiliary_right_scope(art265_3, [art258]).

auxiliary_right(art265_3, PersonId, postponement, hearing_adjournment) :-
    proceeding_matter(PersonId, hearing),
    person_event(PersonId, not_appear_hearing).

%% has_right(_art271_1, PersonId, _right_to_not_incriminate_themselves, _statements)
%
% Article 271(1) code of criminal procedure
% 
% The presiding judge shall be responsible for ensuring that questions which are aimed at obtaining a statement, which cannot be 
% said to have been freely given, shall not be posed
has_right(art271_1, PersonId, right_to_not_incriminate_themselves, statements) :-
    person_event(PersonId, make_statements).

%% has_right(_art271_2, PersonId, _right_to_be_presumed_innocent, _proceedings)
%
% Article 271(2) code of criminal procedure
% 
% Neither the presiding judge, nor any of the judges at the court session shall openly show any bias concerning the guilt or 
% innocence of the defendant.
has_right(art271_2, PersonId, right_to_be_presumed_innocent, proceedings) :-
    person_status(PersonId, accused).

%% has_right(_art273_2, PersonId, _right_to_remain_silent, _proceeding)
%
% Article 273(2) code of criminal procedure
% 
% The presiding judge shall advise the defendant to listen carefully to what is being said and shall inform him that he is not 
% obliged to answer any questions.
has_right(art273_2, PersonId, right_to_remain_silent, proceedings) :-
    person_status(PersonId, accused).

% Article 278(1) code of criminal procedure
% The District Court shall determine the validity of the delivery of the summons to the suspect who has failed to appear. 
% If it appears that said summons was not validly issued, it shall declare the summons null and void.

% Article 278(2) code of criminal procedure
% In the event that the District Court wishes the defendant to be present at the hearing of the case at the court session, it shall 
% order the suspect to appear in person; it may also order that he be brought forcibly for that purpose. In the case of article 260(6), 
% article 495a(2) and (3) shall apply mutatis mutandis.

%% auxiliary_right(_art278_3, PersonId, _postponement, _court_hearing)
%
% Article 278(3) code of criminal procedure
% 
% If the suspect has indicated that he wishes to conduct his defence in person and has applied for a postponement of the hearing 
% of his case, the District Court shall decide on the application for postponement. The District Court shall grant the application 
% for postponement or reject it, whereafter in the latter case the hearing shall be continued subject to article 280(1).
auxiliary_right_scope(art278_3, [art258]).

auxiliary_right(art278_3, PersonId, postponement, court_hearing) :-
    person_request_submitted(PersonId, postponement),
    proceeding_matter(PersonId, court_hearing).

% Article 278(4) code of criminal procedure
% In the application of paragraph (2) or the granting of the application referred to in paragraph (3), the District Court shall order
% that the hearing be adjourned and that the defendant be summoned to appear come the date of resumption of the hearing.

%% auxiliary_right(_art279_1, PersonId, _right_to_be_absent, _trial_in_absentia)
%
% Article 279(1) code of criminal procedure
%
% The suspect, who has not appeared, may have himself defended at the court session by a lawyer who declares that he has been explicitly
% authorised for that purpose. The District Court shall consent thereto, without prejudice to the provisions of Article 278(2). 
% The trial of the case against the suspect who has authorised his lawyer to defend him shall be deemed to be proceedings in a 
% defended case.
%
% $
% the right to appear in person is considered to be waived if the suspect has authorized a counsel to stand at trial as a defense 
% lawyer: this authorization does not have to be given in writing, and the counsel has no obligation to submit documentation in that respect to the court. 
% If a counsel argues to have been explicitly authorized and is at the hearing to handle the suspect’s defense, the proceedings is regarded as a defended action under Dutch law
% $

auxiliary_right_scope(art279_1, [art258]).

auxiliary_right(art279_1, PersonId, right_to_be_absent, trial_in_absentia) :-
    person_event(PersonId, represented_by_lawyer).

% Article 283(1) code of criminal procedure
% In cases where it can be found without the case being heard that the summons is null and void, the District Court lacks jurisdiction 
% or there is a bar to the prosecution, the defendant may present and explain and clarify this defence immediately after the 
% questioning referred to in article 273.

% Article 283(6) code of criminal procedure
% The District Court may also, ex officio, pronounce the summons null and void, its lack of jurisdiction or a bar to the 
% prosecution without having heard the case, after it has heard the public prosecutor and the defendant.

% Article 348 code of criminal procedure
% The District Court shall investigate, on the basis of the indictment and the hearing at the court session, the validity of the 
% summons, its jurisdiction to try the offence as charged in the indictment and the right of the public prosecutor to institute 
% criminal proceedings and whether there are reasons to suspend the prosecution. 

%% has_right(_art338_1, PersonId, _right_to_be_presumed_innocent, _convinced_by_evidence)
%
% Article 338(1) code of criminal procedure
% 
% The court may find that there is evidence the suspect committed the offence as charged in the indictment only when the court through 
% the hearing has become convinced thereof from legal means of evidence.
has_right(art338_1, PersonId, right_to_be_presumed_innocent, convinced_by_evidence) :-
    person_status(PersonId, suspect).

%% has_right(_art352_1, PersonId, _right_to_be_presumed_innocent, _be_acquitted)
%
% Article 352(1) code of criminal procedure
% 
% If the District Court finds that it has not been proven that the defendant committed the offence for which he has been indicted, 
% then it shall acquit him.
has_right(art352_1, PersonId, right_to_be_presumed_innocent, be_acquitted) :-
    proceeding_matter(PersonId, not_proven).

% Article 355(1) code of criminal procedure
% If a judgment has been rendered in absentia, then after said judgment has become enforceable, the decision of the District Court 
% in regard of the convincing items of evidence may be enforced, after, if the judgment has not yet become final, the clerk to the 
% court has prepared an accurate description of those items and filed it at the court registry.

%% auxiliary_right(_art359a_1, PersonId, _remedy, _decision)
%
%  Article 359a(1) code of criminal procedure
% 
% (1) The District Court may, if it appears that procedural requirements were not complied with during the preliminary investigation 
% which can no longer be remedied and the law does not provide for the legal consequences thereof, determine that:
% a. the length of the sentence shall be reduced in proportion to the gravity of the non-compliance with procedural requirements, 
% if the harm or prejudice caused can be compensated in this manner; 
% b. the results obtained from the investigation, in which there  was a failure to comply with procedural requirements, may not be 
% used as evidence of the offence as charged in the indictment; 
% c. there is a bar to the prosecution, if as a result of the procedural error or omission there cannot be said to be a trial of 
% the case which meets the principles of due process.
auxiliary_right_scope(art359a_1, [art29_1, art29_2, art173, art219, art258, art271_1, art271_2, art273_2, art338_1]).

auxiliary_right(art359a_1, PersonId, remedy, decision) :-
    proceeding_matter(PersonId, violation_procedural_law).

% Article 359a(2-3) code of criminal procedure
% (2) In the application of paragraph 1, the District Court shall take into account the interest served by the violated rule, the 
% gravity of the procedural error or omission and the harm or prejudice caused as a result of said error or omission.
% (3) The judgment shall contain the decisions referred to in paragraph 1. Said decisions shall be reasoned

% Article 359(5) code of criminal procedure
% The judgment shall state, in particular, the reasons which determined the punishment or led to the measure.

% Article 359(6) code of criminal procedure
% In the imposition of a punishment or measure which entails deprivation of liberty, the judgment shall state, in particular, 
% the reasons which led to the choice of this type of punishment or to this type of measure. The judgment shall also indicate, 
% as much as possible, the circumstances taken into account in the determination of the length of the punishment

%% auxiliary_right(art364_1, PersonId, _remedy, _judgment)
%
% Article 364(1) code of criminal procedure
% 
% If the defendant is present on pronouncement of judgment, the presiding judge shall verbally inform him that a legal remedy may 
% be exercised against the judgment and of the time limit within which that legal remedy may be exercised.
auxiliary_right_scope(art364_1, [art29_1, art29_2, art173, art219, art258, art271_1, art271_2, art273_2, art338_1]).

auxiliary_right(art364_1, PersonId, remedy, judgment) :-
    proceeding_event(PersonId, present_judgement).

%% auxiliary_right(_art364_2, PersonId, _waive, _right_to_remedy) 
%
% Article 364(2) code of criminal procedure
% 
% The defendant, who is not present at the court session, may, after having learned of the judgment, authorise his defence counsel 
% to waive his right to exercise a legal remedy.
auxiliary_right_scope(art364_2, [art29_1, art29_2, art173, art219, art258, art271_1, art271_2, art273_2, art338_1]).

auxiliary_right(art364_2, PersonId, waive, right_to_remedy) :-
    \+    proceeding_event(PersonId, present_court_session).
 
%% right_property(_art366_1, PersonId, _notification, _judgement)
%
% Article 366 code of criminal procedure
%
% The public prosecutor shall serve the notification of the judgment, which contains the decision of the District Court under 
% section 349, 351 or 352(2) and was pronounced while the defendant was not present, on him as soon as possible. 
% 2. This notification shall not be given 
% a. to the defendant on whom the summons or on whom notice to appear at the court session at a later date, after adjournment of the 
% hearing for an indefinite period, was served in person, 
% b. to the defendant who was present at the court session or the court session at a later date, 
% c. if a circumstance has otherwise occurred from which it follows that the date of the court session or of the court session at a 
% later date was known to the defendant beforehand.
% The notification shall state the name of the judge who rendered the judgment, the date of the judgment, the designation of the 
% criminal offence, stating the place and time on which it was allegedly committed, and insofar as is stated in the judgment, 
% surnames and forenames, date and place of birth, and the place of residence or abode of the defendant.
%
% $
% The communication refers to grounds for challenging a
% District Court's judgement or a Court of Appeal's judgment (via an appeal or an appeal in
% cassation). A specific remedy in such cases is not provided. It should be observed that while
% ordinary remedies allow to challenge a decision in absentia, only an appeal against the decision of
% a District Court paves the way for a new judgement. The judgement ensuing an appeal in cassation
% only deals with questions of law.
% $

right_property_scope(art366_1, [art258]).

right_property(art366_1, PersonId, notification, judgement) :-
    proceeding_matter(PersonId, trial_in_absentia).

%% auxiliary_right(_art404_3, PersonId, _remedy, _new_trial)
%
% Article 404(3) code of criminal procedure
%
% In derogation of paragraph (2), the defendant may file an appeal against a judgment rendered in absentia as referred to in 
% paragraph (2)(a) and (b), if the summons or notice to appear at the court session of the court of first instance or the notice 
% to appear at the court session at a later date was not given to or served on the defendant in person and no other circumstance 
% has occurred from which it follows that the date of the court session or of the court session at a later date was known to the 
% defendant beforehand. The preceding sentence shall not apply in the event that the summons or appearance notice was lawfully 
% served on the defendant in accordance with article 36g within six weeks after the defendant filed an objection [against the 
% punishment order] under the terms of article 257e.
auxiliary_right_scope(art404_3, [art258]).

auxiliary_right(art404_3, PersonId, remedy, new_trial) :-
    proceeding_matter(PersonId, trial_in_absentia).

% Article 414(1) code of criminal procedure
% The advocate general and the defendant may have witnesses and expert witnesses, who were questioned at the court session of the court 
% of first instance, summoned or called in writing as new witnesses and expert witnesses. They may also submit new documents or 
% convincing items of evidence. 

% Article 427(1) code of criminal procedure
% Appeal in cassation may be filed, against judgments concerning serious offences pronounced by the Courts of Appeal, by the Public 
% Prosecution Service attached to the court which rendered the judgment and by the defendant.

%% auxiliary_right(_art431_1, PersonId, _remedy, _judgement)
%
% Article 431(1) code of criminal procedure
%
%  Non-compliance with procedural requirements prescribed under penalty of nullity, shall be a ground for quashing the judgment or 
% appeal judgment, when said non-compliance was committed in the judgment or appeal judgment itself as well as in the course of 
% the proceedings.
auxiliary_right_scope(art431_1, [art29_1, art29_2, art173, art219, art258, art271_1, art271_2, art273_2, art338_1]).

auxiliary_right(art431_1, PersonId, remedy, judgement) :-
    proceeding_matter(PersonId, violation_procedural_law).

% Article 512 code of criminal procedure
% On application of the defendant or the Public Prosecution Service, any of the judges, who hear a case, may be recused on the 
% grounds of facts or circumstances which might prejudice judicial impartiality.

%%%% Civil Code %%%%
% Article 6:162(1) code of criminal procedure
% He who commits a wrongful act against another person which is imputable to him is obliged to compensate the damage suffered by 
% the other person as a result.

% Article 6:162(2) code of criminal procedure
% A violation of a right and an act or omission in violation of a legal duty or of what is customary in society according to 
% unwritten law shall be considered a wrongful act, subject to the presence of a justification.

% Article 6:162(3) code of criminal procedure
% A wrongful act may be attributed to the perpetrator if it is due to his fault or to a cause for which he is responsible by virtue 
% of the law or generally accepted practice.

%%%% Official instruction for the national police corps, the royal gendarmerie and other investigating officers %%%%

%% right_property(_art22_1, PersonId, _restrictions, _handcuff)
%
% Article 22(1-2-3) Official instruction for the national police corps, the royal gendarmerie and other investigating officers
% 
% An official may handcuff a person who has been deprived of his or her liberty for the purpose of transport.
right_property_scope(art22_1, [art271_2, art338_1]).

right_property(art22_1, PersonId, restrictions, handcuff) :-
    person_status(PersonId, deprived_of_liberty),
    art22_2Applies(PersonId).

%% The measure referred to in paragraph 1 may be taken only if reasonably required by the facts or circumstances in view of the 
% danger of escape or danger to the safety or life of the person deprived of his liberty as a matter of law, of the official or of 
% third parties.
art22_2Applies(PersonId) :-
    (   person_danger(PersonId, escape)
    ;   person_danger(PersonId, safety)
    ;   person_danger(PersonId, life)
    ).

%% The facts or circumstances referred to in paragraph 2 are limited to those having to do with:
% a. the person is deprived of her liberty as a matter of law, or
% b. the nature of the offence on the basis of which the deprivation of liberty was ordered, in connection with the manner and situation 
% in which the transport takes place

