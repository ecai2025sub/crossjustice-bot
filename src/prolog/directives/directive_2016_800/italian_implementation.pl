:- module(directive_2016_800_it, [has_right/5, auxiliary_right/5, auxiliary_right_checked/5, right_property/5, right_property_checked/5, explain/2]).

:- include('./../../utils.pl').

has_right(Right, it, Article, PersonId, Matter) :-
    person_status(PersonId, child),
    has_right(Article, PersonId, Right, Matter).

person_status(PersonId, child):-
    person_age(PersonId, X),
    X < 18.

%Italian Implementation 16/800

%% has_jurisdiction(_article3_1, PersonId, _juvenile_court, _dpr448_1988)
%
% Article 3(1) criminal procedure code
%
% The Juvenile Court shall have jurisdiction over offences committed by children under the age of eighteen.
% italian_implementation_applies(article3_1, PersonId)
has_jurisdiction(article3_1, PersonId, juvenile_court, dpr448_1988):-
    person_status(PersonId, child).

%% person_status(PersonId, _child)
%
% Article 3(2) criminal procedure code
%
% The Juvenile Court and the Juvenile Sentence Supervision Judge shall exercise the powers of the Juvenile Sentence 
% Supervision in respect of those who committed the offence when they were under the age of eighteen. 
% The jurisdiction shall cease when the child reaches the age of 25.
person_status(PersonId, child):-
    person_age(PersonId, X, act_committed),
    (   X < 18
    ;   X < 25
    ).

%% person_status(PersonId, _child)
%
% Article 67 criminal procedure code
%
% At any stage and instance of proceedings, if there are reasons to believe that the accused is a child, the judicial authority 
% shall forward the case file to the Public Prosecutor attached to the Juvenile Court.
person_status(PersonId, child):-
    proceeding_status(PersonId, started),
    proceeding_matter(PersonId, reasons_for_accused_to_be_child).

%Article 63 criminal procedure code
%1. If a person who is not accused or suspected makes statements before the judicial authority or the police that raise suspicion 
%of guilt against him, the proceeding authority shall interrupt the examination, warn him that, following such statements, 
%investigations may be carried out on him, and advise him to appoint a lawyer. 
%Such statements shall not be used against the person who has made them.
%2. If the person should have been heard as an accused or a suspect from the beginning, his statements shall not be used.
person_status(PersonId, suspect):-
%    proceeding_matter(PersonId, questioning),
    person_status(PersonId, raise_suspicion).

%Article 6(1,1bis,2,3) criminal procedure code
%1.The quaestor may order a ban on the places where specifically designater sporting events are hels, as well as to those, 
%specifally indicated, interested in the stopover, in the transit or transport of those who participate or assist in the manifestations 
%themselves.
%1bis. The prohibition referred to in paragraph 1 may also be imposed to persons under the age of eighteen who have completed the 
%14 years of age. The measure is notified to the holder of parental responsibility.

%Article 1(1)(1) criminal procedure code
%In the proceedings against minors, the provisions of this decree and, as far as not provided for by them, 
%those of the criminal procedure code shall be observed.

%% person_status(PersonId, _holder_of_parental_responsibility)
%
% Article 316(1)(1)civil code
%
% Both parents have parental responsibility which is exercised by mutual agreement taking into account the abilities, 
% natural inclinations and aspirations of the child.
person_status(PersonId, holder_of_parental_responsibility):-
    person_status(PersonId, parent).

%Article 320(1)(1) civil code
%The parents jointly, or the one of them who excersice exclusive parental responsibility, shall represent the children 
%born and unborn, up to the age of majority or emancipation, in all civil acts and shall administer their property.
%Article 315 bis(1) civil code
%the child has the right to be maintained, educated, instructed and morally assisted by her/his parents, 
%with respect for her/his abilities, natural inclinations and aspirations.

%% person_status(PersonId, _child)
%
% Article 8 Decree no 448 of the President of the Republic of 22 settembre 1988
%
% 1. When the child's age is uncertain, the judge shall have an expert opinion, even on his own motion.
% 2. Where, even after the expert's report, there is still doubt about the child's age, it shall be presumed that the child has not 
% reached the age of majority.
person_status(PersonId, child):-
    expert_decision(PersonId, person_is_child),
    \+ person_age(PersonId, _).

person_status(PersonId, child):-
    expert_decision(PersonId, no_decision),
    \+ person_age(PersonId, _).

%3. The provisions of paragraphs 1 and 2 shall also apply where there is reason to believe that the accused is under the age of fourteen.
%person_age(PersonId, cannot_be_ascertained):-
%    person_age(PersonId, cannot_be_more_14).

%% has_right(_art369_1, PersonId, _right_to_information, _notice_of_investigation)
%
% Article 369(1) criminal procedure code
%
% Only when the Public Prosecutor must carry out an activity in which the lawyer has the right to be present, shall he/she send a 
% notice of investigation to the suspect and the victim by mail, in a sealed registered envelope with return receipt. 
% The notice of investigation shall contain the legal provisions which have allegedly been violated as well as the date and place in 
% which the criminal act was committed along with a request to exercise the right of appointing a retained lawyer.
has_right(art369_1, PersonId, right_to_information, notice_of_investigation):-
    person_status(PersonId, suspect),
    proceeding_matter(PersonId, lawyer_presence_required).

has_right(art369_1, PersonId, right_to_access_lawyer, notice_of_investigation):-
    person_status(PersonId, suspect),
    proceeding_matter(PersonId, lawyer_presence_required).

%According to comments, the right to access lawyer comes from the same articles as the right to information

%% has_right(_art369_bis, PersonId, _right_to_information, _access_lawyer)
%
% Article 369-bis criminal procedure code
%
% 1. During the first activity in which the lawyer has the right to be present and, in any case, prior to sending the summons 
% to appear for questioning according to the conjunction of Articles 375, paragraph 3, and 416, or no later than the service of 
% the notice on the conclusion of preliminary investigations according to Article 415-bis, the Public Prosecutor, under penalty 
% of nullity of subsequent acts, shall serve on the suspected person the notification on the designation of a court-appointed lawyer.
% 2. The notification referred to in paragraph 1 shall contain:
% a) the information that technical defence in criminal proceedings is mandatory, along with the specification of the rights 
% assigned by law to the suspected person;
% b) the name of the court-appointed lawyer, his/her address and his/her telephone number;
% c) the specification of the right to appoint a retained lawyer, along with the notice that, if the suspect does not have a 
% retained lawyer, he/she shall be assisted by the court-appointed lawyer;
% d) the specification of the obligation to remunerate the court-appointed lawyer, unless the conditions for accessing the benefit 
% referred to in letter e) are met, along with the warning that, in case the lawyer is not paid, mandatory enforcement shall be imposed;
% e) the specification of the conditions for accessing legal aid at the expense of the State.
has_right(art369_bis, PersonId, right_to_information, access_lawyer):-
    person_status(PersonId, suspect),
    proceeding_matter(PersonId, lawyer_presence_required).

has_right(art369_bis_e, PersonId, right_to_information, free_legal_aid):-
    person_status(PersonId, suspect),
    proceeding_matter(PersonId, lawyer_presence_required).

has_right(art369bis_b_c, PersonId, right_to_access_lawyer, notice_of_designation):-
    person_status(PersonId, suspect),
    proceeding_matter(PersonId, lawyer_presence_required).

%According to comments, the right to access lawyer comes from the same articles as the right to information
%add right_to_free_legal_aid?

%% has_right(_art293_1, PersonId, _right_to_information, _access_lawyer)
%
% Article 293 criminal procedure code
%
% Without prejudice to Article 156, the official or officer in charge of enforcing the order of precautionary detention 
% shall provide the accused person with a copy of the decision along with a clear and precise written notice. 
% If the accused does not know the Italian language, the notice shall be translated into a language he/she understands. 
% The notice shall contain the following information:
% a) his/her right to appoint a retained lawyer and to access legal aid at the expense of the State according to the provisions of the law;
% g) his/her right to access emergency medical assistance;
% h) his/her right to be brought before the judicial authority within five days of enforcement of precautionary detention in prison 
% or within ten days if a different precautionary measure is applied;
% i) his/her right to appear before a court for questioning, to appeal the order directing the precautionary measure and to request 
% its substitution or revocation.
% 1-bis. If the written notice referred to in paragraph 1 is not promptly available in a language that the accused understands, 
% the information is provided orally, without prejudice to the obligation to provide the accused with the aforementioned written notice 
% without delay
has_right(art293_1_a, PersonId, right_to_information, access_lawyer):-
    person_status(PersonId, accused),
    proceeding_matter(PersonId, precautionary_detention).

has_right(art293_1_a, PersonId, right_to_information, legal_aid):-
    person_status(PersonId, accused),
    proceeding_matter(PersonId, precautionary_detention).

has_right(art293_1_g, PersonId, right_to_information, medical_assistance):-
    person_status(PersonId, accused),
    proceeding_matter(PersonId, precautionary_detention).

has_right(art293_1_h_i, PersonId, right_to_information, limitation_to_deprivation_of_liberty_and_use_of_alternative_measures):-
    person_status(PersonId, accused),
    proceeding_matter(PersonId, precautionary_detention).

has_right(art293_1_bis, PersonId, right_to_information, written):-
    (   has_right(art293_1_a, PersonId, right_to_information, access_lawyer)
    ;   has_right(art293_1_a, PersonId, right_to_information, legal_aid)
    ;   has_right(art293_1_g, PersonId, right_to_information, medical_assistance)
    ;   has_right(art293_1_h_i, PersonId, right_to_information, limitation_to_deprivation_of_liberty_and_use_of_alternative_measures)
    ),
    person_understands(PersonId, Language),
    proceeding_language(PersonId, Language).

has_right(art293_1_bis, PersonId, right_to_information, orally):-
    (   has_right(art293_1_a, PersonId, right_to_information, access_lawyer)
    ;   has_right(art293_1_a, PersonId, right_to_information, legal_aid)
    ;   has_right(art293_1_g, PersonId, right_to_information, medical_assistance)
    ;   has_right(art293_1_h_i, PersonId, right_to_information, limitation_to_deprivation_of_liberty_and_use_of_alternative_measures)
    ),
    \+ has_right(art291_1_bis, PersonId, right_to_information, written).

%% has_right(_article386_1, PersonId, _right_to_information, _access_lawyer)
%
% Article 386 criminal procedure code
%
% The police officials and officers who have arrested or placed under temporary detention ("fermo") the perpetrator or to whom the 
% arrested person has been surrendered, shall immediately inform the Public Prosecutor of the place where the perpetrator has been 
% arrested or placed under temporary detention.
% They shall provide the arrested or temporarily detained person ("fermato") with a written notice, drafted clearly and precisely. 
% If the arrested or temporarily detained person does not know the Italian language, the notice shall be translated into a language he 
% understands. The notice shall contain the following information:
% a) his/her right to appoint a retained lawyer and to access legal aid at the expense of the State according to the provisions of the law;
% g) his/her right to access emergency medical assistance;
% h) his/her right to be brought before the judicial authority for the confirmation of the arrest or temporary detention within ninety-eight 
% hours of the arrest or start of temporary detention;
% i) his/her right to appear before a court for questioning, to appeal the order directing the precautionary measure and to request 
% its substitution or revocation.
% 1-bis. If the written notice referred to in paragraph 1 is not promptly available in a language that the arrested or temporarily 
% detained person understands, the information is provided orally, without prejudice to the obligation to provide the arrested or 
% temporarily detained person with the aforementioned written notice without delay.
has_right(article386_1_a, PersonId, right_to_information, access_lawyer):-
    (   person_status(PersonId, arrested)
    ;   person_status(PersonId, detained)
    ).

has_right(article386_1_a, PersonId, right_to_information, legal_aid):-
    (   person_status(PersonId, arrested)
    ;   person_status(PersonId, detained)
    ).

has_right(article386_1_g, PersonId, right_to_information, medical_assistance):-
    (   person_status(PersonId, arrested)
    ;   person_status(PersonId, detained)
    ).

has_right(article386_1_h_i, PersonId, right_to_information, limitation_to_deprivation_of_liberty_and_use_of_alternative_measures):-
    (   person_status(PersonId, arrested)
    ;   person_status(PersonId, detained)
    ).

has_right(article386_1_bis, PersonId, right_to_information, written):-
    (   has_right(article386_1_a, PersonId, right_to_information, access_lawyer)
    ;   has_right(article386_1_a, PersonId, right_to_information, legal_aid)
    ;   has_right(article386_1_g, PersonId, right_to_information, medical_assistance)
    ;   has_right(article386_1_h_i, PersonId, right_to_information, limitation_to_deprivation_of_liberty_and_use_of_alternative_measures)
    ),
    person_understands(PersonId, Language),
    proceeding_language(PersonId, Language).

has_right(article386_1_bis, PersonId, right_to_information, orally):-
    (   has_right(article386_1_a, PersonId, right_to_information, access_lawyer)
    ;   has_right(article386_1_a, PersonId, right_to_information, legal_aid)
    ;   has_right(article386_1_g, PersonId, right_to_information, medical_assistance)
    ;   has_right(article386_1_h_i, PersonId, right_to_information, limitation_to_deprivation_of_liberty_and_use_of_alternative_measures)
    ),
    \+ has_right(article291_1_bis, PersonId, right_to_information, written).

% Article outside law
person_status(PersonId, arrested):-
    person_status(PersonId, requested).

%% has_right(_article7, PersonId, _right_to_be_informed, _holder_of_parental_responsibility)
%
% Article 7 Decree no 448 of the President of the Republic of 22 settembre 1988
%
% Notice of investigation and decree for committal to court hearings shall be served, under penalty of nullity, also to the holder 
% of parental responsibility.
has_right(article7, PersonId, right_to_be_informed, holder_of_parental_responsibility):-
    (   person_document(PersonId, notice_of_investigation)
    ;   person_document(PersonId, decree_committal_court_hearing)
    ),
    proceeding_status(PersonId, started).

%% has_right(_article18_1, PersonId, _right_to_be_informed, _holder_of_parental_responsibility)
%
% Article 18(1) Decree no 448 of the President of the Republic of 22 settembre 1988
%
% The criminal police officials and officers who have arrested or placed under temporary custody shall immediately give notice to 
% the Public Prosecutor, the holder the parental responsibility and the legal guardian (if any); they promptly inform the juvenile 
% services of the Ministry of Justice.
has_right(article18_1, PersonId, right_to_be_informed, holder_of_parental_responsibility):-
    (   person_status(PersonId, arrested)
    ;   person_status(PersonId, temporary_custody)
    ).

%%When the parents of the child are not suitable for holding the parental responsibility, the protection and welfare of the child 
%is provided by a person appointed by the judicial authority (see Article 330 and 343 of the Italian Civil Code) who formally become 
%the holder of parental responsibility.
%TODO - Should we then map those arts?

%% right_property(_article96_2, PersonId, _access_lawyer, _appoint_lawyer)
%
% Article 96(1-3) criminal procedure code
%
% The accused person is entlitled to appoint no more than two retained lawyers.
% The retained lawyer shall be appointed by a statement either given to the proceeding authority by the accused or her/his lawyer or 
% forwarded by registred letter.
right_property_scope(art96_2, [art97_1]).

right_property(article96_2, PersonId, access_lawyer, appoint_lawyer):-
    person_status(PersonId, accused),
    person_document(PersonId, statement, appoint_lawyer).

%If the person who is temporarily detained, arrest or held under precautionary detention does not appoint a retained lawyer, the latter 
%may be appointed by his next of kin according to paragraph 2.

%% has_right(_article97_1, PersonId, _right_to_access_lawyer, _trial_defence)
%
% Article 97(1-4) criminal procedure code
%
% The accused person who has not appointed or no longer has a retained lawyer shall be assisted by a court-appointed lawyer.
has_right(article97_1, PersonId, right_to_access_lawyer, trial_defence):-
    person_status(PersonId, accused).

%In order to ensure the effectiveness of the court-appointed defence, the Board of the Bar Association of each Court of Appeal district, 
%through a dedicated centralised office, shall draw lists of lawyers who may be appointed by the court upon request of the judicial 
%authority or the police. The Boards of the Bar Association shall set the criteria for the appointment of lawyers on the basis of their 
%specific competencies, their proximity to the place of the proceedings and their availability.
%If the judge, the Public Prosecutor and the police must carry out an action requiring the assistance of a lawyer and the suspect or 
%the accused does not have a lawyer, thay shall inform the lawyer, whose name is notified by the office referred to in paragraph 2, 
%of this particular action.
%When the presence of the lawyer of the accused is required and the retained or court-appointed lawyer chosen according to paragraphs 
%2 and 3 have not been found or have not appeared or have left the defence, the judge shall appoint an immediately available substitute 
%lawyer to whom the provisions of Article 102 shall apply. Under the same circumstances, the Public Prosecutor and the police shall 
%request the office referred to in paragraph 2 to provide the name of another lawyer, except for urgent cases in which another lawyer 
%who is immediately available is appointed by a reasoned decision specifying the reasons for urgency. 
%During the trial only a lawyer in the list referred to in paragraph 2 may be appointed as a substitute lawyer.

%% has_right(_article104_1, PersonId, _right_to_access_lawyer, _)
%
% Article 104(1-2) criminal procedure code
%
% 1. The accused who is under precautionary detention has the right to consult with her/his lawyer as of the start of the enforcement 
% of such measure.
% 2. A person who is arrested in flagrante delicto or placed under temporary detention (fermo) under Article 384 has the right to 
% consult with her/his lawyer immediately after s/he is arrested or temporarily detained.
has_right(article104_1, PersonId, right_to_access_lawyer, precautionary_detention):-
    person_status(PersonId, detained),
    proceeding_matter(PersonId, precautionary_detention).

has_right(article104_2, PersonId, right_to_access_lawyer, arrest):-
    person_status(PersonId, arrested);
    (   person_status(PersonId, detained)   
    ,   proceeding_matter(PersonId, temporary_detention)
    ).

%% authority_check(_article104, PersonId, _right_to_access_lawyer, _derogation)
%
% Article 104(3-4) criminal procedure code
%
% 3. During preliminary investigations for crimes referred to in Article 51, paragraphs 3 -bis and 3 -quater, when there are specific 
% and exceptional reasons of caution, the court may, upon request of the Public Prosecutor, defer, by reasoned decree, the exercise of 
% the right to consult with a lawyer for a period of time not exceeding five days.
% 4. In case the accused person is arrested or placed under temporary detention (fermo), the power established in paragraph 3 shall be 
% exercised by the Public Prosecutor until the arrested or temporarily detained person is brought before the court.
authority_check(article104_3, PersonId, right_to_access_lawyer, derogation):-
    proceeding_matter(PersonId, preliminary_investigation),
    authority_decision(PersonId, exceptional_reasons_caution).

authority_check(article104_4, PersonId, right_to_access_lawyer, derogation):-
    (   person_status(PersonId, arrested)
    ;   person_status(PersonId, detained)
    ),
    \+ proceeding_matter(PersonId, summoned_court).

% TODO - Not more than 5 days?
% TODO - Does that mean that the previous article must apply as well? Do there have to be exceptional reasons?

%% has_right(article350, PersonId, right_to_access_lawyer, investigative_questioning)
%
% Article 350(1-4) criminal procedure code
%
% 1. Police officials shall collect, following the procedure provided for in Article 64, summary information useful for investigative 
% purposes from the suspect who has not been placed under arrest or temporary detention according to Article 384 and in the cases 
% referred to in Article 384-bis.
% 2. Prior to the investigative questioning, the police shall require the suspect to appoint a retained lawyer and, if s/he does not do so, 
% the police shall follow the provisions of Article 97, paragraph 3.
% 3. Investigative questioning shall be performed with the necessary assistance of the lawyer who shall be promptly informed by the police. 
% The lawyer must be present during investigative questioning.
% 4. If the lawyer has not been found or s/he did not appear, the police shall require the Public Prosecutor to take a decision according 
% to Article 97, paragraph 4.
has_right(article350, PersonId, right_to_access_lawyer, investigative_questioning):-
    person_status(PersonId, suspect),
    proceeding_matter(PersonId, questioning).

%% has_right(_art364, PersonId, _right_to_access_lawyer, _lawyer_presence)
%
% Article 364(1-4) criminal procedure code
%
% 1. If the Public Prosecutor must carry out a questioning, an inspection, an identity parade in which the suspect must participate, 
% the Public Prosecutor shall require the suspect to appear according to Article 375.
% 2. The suspected person who does not have a lawyer shall also be informed that s/he shall be assisted by a court-appointed lawyer, 
% but that s/he may also appoint a retained lawyer.
% 3. The court-appointed lawyer or the retained lawyer appointed by the suspect shall be informed, at least twenty-four hours in advance, 
% of the activities that are to be performed as specified in paragraph 1 and of the inspections which do not require the suspect's presence.
% 4. In any case, the lawyer has the right to be present during the activities referred to in paragraphs 1 and 3, without prejudice to 
% the provisions of Article 245.
has_right(art364, PersonId, right_to_access_lawyer, lawyer_presence):-
    person_status(PersonId, suspect),
    (   proceeding_matter(PersonId, questioning)
    ;   proceeding_matter(PersonId, inspection)
    ;   proceeding_matter(PersonId, identity_parade)
    ).

%% has_right(_article415bis_1, PersonId, _right_to_information, _conclusion_preliminary_investigation)
%
% Article 415-bis(1) criminal procedure code
%
% 1. Prior to the expiry of the time limit provided for in paragraph 2 of Article 405, also if extended, when the case must not be 
% discontinued under Articles 408 and 411, the Public Prosecutor shall serve the notice on the conclusion of preliminary investigations 
% on the suspect and her/his lawyer. When any of the offences referred to in Articles 572 and 612-bis of the Criminal Code are prosecuted, 
% the same notice shall be served on the victim's lawyer or, in her/his absence, the victim himself.
has_right(article415bis_1, PersonId, right_to_information, conclusion_preliminary_investigation):-
    person_status(PersonId, suspect).

%Article 416(1) criminal procedure code
%The request for commital to trial shall be filed by the Public Prosecutor with the Judge's Clerk's Office. It shall be considered 
%null if it is not preceded by the notice provided in Article 415-bis and the summons to appear for questioning according to Article 375, 
%paragraph 3, if the suspect has requested the questioning within the time limit referred to in Article 415-bis, paragraph 3.

%% has_right(_article103_5, PersonId, _right_to_access_lawyer, _private_communication)
%
% Article 103(5-6) criminal procedure code
%
% 5.Intercepting conversations and communications of lawyers, authorised private detectives responsible for the proceeding, 
% technical consultants and their assistants, is not allowed, nor are such interceptions allowed between them and the persons they are 
% assisting.
% 6.Seizure and any form of control of correspondance between the accused and her/his lawyer, if acknowledged by the prescribed 
% indications, are forbidden, except if the judicial authority has reasonable grounds to believe that it involves the corpus delicti.
has_right(article103_5, PersonId, right_to_access_lawyer, private_communication):-
    person_status(PersonId, accused),
    \+ authority_decision(PersonId, grounds_to_consider_communication_corpus_delicti).

%Article 357(2)(b) criminal procedure code
%Without prejudice to the provisions regarding specific activities, the police shall record the following acts:
%b) summary information provided and spontaneous statements made by the suspected person;
%%Article 373(1)(b) criminal procedure code
%1. Without prejudice to the provisions concerning specific documents, the following acts shall be recorded:
%b) questionings and line-ups involving the suspect;

%Article 392(1)(e) criminal procedure code
%1. During preliminary investigations, the Public Prosecutor and the suspect may request that the court proceed by means of special 
%evidentiary hearing to:
%e) the confrontation of persons who, in a different special evidentiary hearing or before the Public Prosecutor, have made contrasting 
%statements, if one of the circumstances provided for in letters a) and b) occurs;
%f) an expert report or a judicial simulation, if evidence concerns a person, an object or a place subject to unavoidable modification;

%% has_right(_article401, PersonId, _right_to_access_lawyer, _hearing)
%
% Article 401(1-2) criminal procedure code
%
% 1. Hearings take place in chambers with the necessary participation of the Public Prosecutor and the lawyer of the suspected person. 
% The lawyer of the victim is also entitled to participate.
% 2. If the lawyer of the suspected person does not appear, the court shall appoint a different lawyer under the provision of Article 
% 97, paragraph 4.
has_right(article401, PersonId, right_to_access_lawyer, hearing):-
    person_status(PersonId, suspect),
    proceeding_matter(PersonId, hearing).

%% has_right(_article364_5, PersonId, _right_to_access_lawyer, _derogation)
%
% Article 364(5-6) criminal procedure code
%
% 5. In cases of absolute urgency, if there are reasonable grounds to believe that the delay may compromise the search for or the 
% securing of the sources of evidence, the Public Prosecutor may carry out a questioning, inspection, informal identification or line-up 
% even prior to the set time limit, after informing the lawyer without delay and, in any case, promptly. The notice may be omitted if 
% the Public Prosecutor performs an inspection and there are reasonable grounds to believe that the traces or other material items of 
% the offence may be altered. The right of the lawyer to intervene shall be preserved in any case.
has_right(article364_5, PersonId, right_to_access_lawyer, derogation):-
    authority_decision(PersonId, absolute_urgency).

%TODO - Fix as an exception?
%6. When the Public Prosecutor acts according to the methods provided for in paragraph 5, s/he must specify, under penalty of nullity, 
%the grounds for the derogation and the methods of giving notice.

%% has_right(_article391_1, PersonId, _right_to_access_lawyer, _confirmation_hearing)
%
% Article 391(1-2) criminal procedure code
%
% 1. Confirmation hearings are held in closed session with the necessary participation of the lawyer of the arrested or temporarily 
% detained person (fermato).
has_right(article391_1, PersonId, right_to_access_lawyer, confirmation_hearing):-
    proceeding_matter(PersonId, confirmation_hearing),
    (   person_status(PersonId, arrested)
    ;   person_status(PersonId, detained)
    ).

%2. If the retained or court-appointed lawyer cannot be reached or has not appeared, the Preliminary Investigation Judge shall decide 
%on the designation of a substitute according to Article 97, paragraph 4. The Judge shall verify, also of her/his own motion, that the 
%arrested or temporarily detained person (fermato) has received the notice referred to in Article 386, paragraph 1, or has been informed 
%according to paragraph 1-bis of the same Article, and shall give or complete the written notice or the oral information, if necessary.

%% has_right(_article18_1, PersonId, _right_to_access_lawyer, _detainees_inmates)
%
% Article 18(1-2) law no 354 of 26 July 1975
%
% Detainees and inmates are allowed to have conversations and correspondence with relatives and other persons, as well as with the 
% guarantor of prisoners' rights, also for the purpose of carrying out legal acts.
has_right(article18_1, PersonId, right_to_access_lawyer, detainees_inmates):-
    person_status(PersonId, detained);
    person_status(PersonId, inmate).

%% has_right(_article9, PersonId, _right_to_assessment, _individual_assessment)
%
% Article 9 Decree no 448 of the President of the Republic of 22 settembre 1988
%
% The prosecutor and the judge shall gather information on the conditions and the personal, family, social and environmental resources 
% of the child in order to ascertain his or her imputability and the degree of responsability, assess the social relevance of the facts 
% and order the appropriate penal and civil measures.
has_right(article9, PersonId, right_to_assessment, individual_assessment):-
    person_status(PersonId, child).

%% has_right(_article16, PersonId, _right_to_assessment, _individual_assessment)
%
% Article 16 Decree no 448 of the President of the Republic of 22 settembre 1988
%
% 1. Police officers and officials may proceed to the arrest of the child caught in flagrante delicto of one of the offences for which, 
% pursuant to Article 23, pre-trial detention may be ordered.
% 3. When making use of the power provided for in paragraph 1, police officers and officials shall take into account the seriousness of 
% the offence as well as age and personality of the child. 
has_right(article16, PersonId, right_to_assessment, individual_assessment):-
    person_status(PersonId, arrested).

%% has_right(_article6, PersonId, _right_to_assessment, _juvenile_services)
%
% Article 6 Decree no 448 of the President of the Republic of 22 settembre 1988
%
% At any stage or instance of the proceedings, the judicial authority shall request the assistance of juvenile services of the Ministery 
% of Justice. It shall also request the assistance of the services established at local authorities.
has_right(article6, PersonId, right_to_assessment, juvenile_services):-
    proceeding_status(PersonId, started).

%% has_right(_article11, PersonId, _right_to_medical_examination, _obligation)
%
% Article 11(7,12) Decree no 448 of the President of the Republic of 22 settembre 1988
%
% 7. Upon entering the institution, detained or confined person shall undergo a general medical examination and receive full information 
% about their state of health from the doctor. The doctor shall immediately record in the medical record any information relating to signs 
% or indices which suggest that the person may have been subjected to violence or mistreatment and, without prejudice to the obligation to 
% provide a report, shall notify the director of the institution and the Sentence Supervision Judge. Detained or confined persons are also 
% entitled to receive full information about their state of health during their detention and at the time of release. 
% During their stay in the institution, health care is provided with periodic reviews, carried out at intervals in accordance with the 
% detainee's health needs, and is consistent with the principles of proactive approach, comprehensive intervention on the causes of harm 
% to health, unity of services and benefits, integration of social and health care and ensuring continuity of treatment.
% 12. Detained or confined persons may apply to be visited at their own expense by a doctor they trust. Authorisation for defendants and for 
% defendants after the judgement of the first instance shall be given by the prosecuting judge, for convicted prisoners and internees shall 
% be given by the director of the institution.
has_right(article11, PersonId, right_to_medical_examination, obligation):-
    person_status(PersonId, detained).

%% has_right(_article386_1_g, PersonId, _right_to_medical_examination, _obligation)
%
% Article 386(1)(g) - Partially implemented
%
% 1. The police officials and officers who have arrested or placed under temporary detention the perpetrator or to whom the arrested 
% person has been surrendered, shall immediately inform the Public Prosecutor of the place where the perpetrator has been arrested or 
% placed under temporary detention. They shall provide the arrested or temporarily detained person with a written notice, drafted clearly 
% and precisely. (…) The notice shall contain the following information:
% g) his right to access emergency medical assistance.
has_right(article386_1_g, PersonId, right_to_medical_examination, obligation):-
    person_status(PersonId, arrested);
    person_status(PersonId, detained).

%% has_right(_article70_3, PersonId, _right_to_submit_request, RequestMatter)
%
% Article 70(1,3) criminal procedure code
%
% 3. If the need for taking action emerges during preliminary investigations, the court shall require an expert report upon request 
% of a party as provided for the special evidentiary hearing. In the meantime, the time limits for preliminary investigations shall be 
% suspended and the Public Prosecutor shall carry out only those actions that do not require the conscious participation of the suspect.
has_right(article70_3, PersonId, right_to_submit_request, RequestMatter):-
    person_request_submitted(PersonId, RequestMatter),
    proceeding_matter(PersonId, preliminary_investigation).

%% has_right(_article11_7, PersonId, _right_to_medical_examination, _new_medical_exam)
%
% Article 11(7) Decree no 448 of the President of the Republic of 22 settembre 1988
%
% Detained and confined persons are also entitled to receive full information about their state of health during their detention and at 
% the time of release.
has_right(article11_7, PersonId, right_to_medical_examination, new_medical_exam):-
    person_status(PersonId, detained).

%% has_right(_article20_1, PersonId, _right_to_alternative_measure, _personal_activity)
%
% Article 20(1) Decree no 448 of the President of the Republic of 22 settembre 1988
%
% If, in relation to the provisions of article 19 paragraph 2, it is not necessary to resort to other precautionary measures, the judge, 
% having heard the holder of parental responsibility, may give the child specific prescriptions concerning study or work activities or 
% other activities useful for his or her education. Article 19 paragraph 3 shall apply.
has_right(article20_1, PersonId, right_to_alternative_measure, personal_activity):-
    person_status(PersonId, holder_of_parental_responsibility),
    proceeding_matter(PersonId, precautionary_measure).

%% has_right(_article21_1, PersonId, _right_to_alternative_measure, _stay_at_residence)
%
% Article 21(1,2) Decree no 448 of the President of the Republic of 22 settembre 1988
%
% 1. With the Juvenile house arrest, the judge prescribes the child to stay at the family home or other private place of residence. 
% By the same measure the judge may impose limits or prohibitions on the child's ability to communicate with persons other than those who 
% live with her/him or assist her/him.
has_right(article21_1, PersonId, right_to_alternative_measure, stay_at_residence):-
    proceeding_matter(PersonId, arrest),
    person_status(PersonId, house_arrest).

%2. The judge may, also by a separate order, allow the child to leave the home in relation to the needs of study or work activities or 
%other activities useful for her/his education.

%% has_right(_article1_2, PersonId, _right_of_detained, _right_to_restorative_justice)
%
% Article 1(2) Decree no 448 of the President of the Republic of 22 settembre 1988
%
% Execution of detention sentences and penal community measures must promote pathways to restorative justice and mediation with victims 
% of crime. It shall also aim at fostering the child's empowerment, education and full psycho-physical development, preparation for free 
% life, social inclusion and the prevention of further offences, including through the use of education, vocational training, education 
% for active and responsible citizenship, and socially useful, cultural, sporting and leisure activities.
has_right(article1_2, PersonId, right_of_detained, right_to_restorative_justice):-
    person_status(PersonId, detained).

%% has_right(_article18_1, PersonId, _right_of_detained, _right_to_education)
%
% Article 18(1) Decree no 448 of the President of the Republic of 22 settembre 1988
%
% Detained persons are allowed to attend courses of education, vocational education and training outside the institution, subject to 
% agreement with institutions, enterprises, cooperatives or associations, when external attendance is considered to facilitate the 
% educational path and contribute to the enhancement of individual potential and the acquisition of certified skills and social recovery.
has_right(article18_1, PersonId, right_of_detained, right_to_education):-
    person_status(PersonId, detained).

%% has_right(_article22_1, PersonId, _right_for_convicted, _familiar_relationships)
%
% Article 22(1) Decree no 448 of the President of the Republic of 22 settembre 1988
%
% Unless there are specific reasons also due to links with criminal circles, a judgment of conviction must be enforced in institutions 
% close to the residence or habitual abode of the detainee and her/his families, so as to maintain personal and socio-family relationships 
% that are educational and socially significant.
has_right(article22_1, PersonId, right_for_convicted, familiar_relationships):-
    person_status(PersonId, detained),
    \+ person_danger(PersonId, links_to_criminal_circles).

%% has_right(_article11_1, PersonId, _right_to_alternative_measure, _conviction)
%
% Article 11(1,2) Decree no 448 of the President of the Republic of 22 settembre 1988
%
% 1. When it is to be enforced against a person who does not reach the age of 25 years a judgement of conviction involving custodial 
% penalties regarding crime that she/he committed when she/he was a child, the public prosecutor shall issue an enforcement injunction 
% and at the same time a decree who suspend it if imprisonment does not exceed four years, also if the imprisonment is the remainder of 
% a more serious penalty, except for probation in special cases provided for in Article 94 of the President of the Republic’s Decree 
% 9 October 1990, No 309, and for whoever is under precautionary detention in prison or is detained for other reason when the judgment of 
% conviction becomes final.
has_right(article11_1, PersonId, right_to_alternative_measure, conviction):-
    person_status(PersonId, convicted).

%Article 14 Decree no 448 of the President of the Republic of 22 settembre 1988
%1. The stay in juvenile penal institutions shall take place in accordance with an educational project prepared within three months of 
%the beginning of the execution. The project, drawn up according to the principles of personalisation of prescriptions and flexibility of 
%execution after listening to the convicted person, takes into account her/his attitudes and personality characteristics. 
%The project contains indications on how to cultivate relationships with the outside world and implement group life and responsible 
%citizenship also respecting gender diversity and on the personalization of education, vocational training, as well as work, 
%social utility, cultural, sports and leisure activities useful for social recovery and prevention of the risk of committing further crimes.

%% has_right(_article58, PersonId, _right_of_detained, _freedom_of_religion)
%
% Article 58 Decree no 230 of the President of the Repubblic of 30 June 2000
%
% 1. Detained or confined persons have the right to participate in the rites of their religious confession as long as they are compatible 
% with the order and security of the institution and not contrary to the law, according to the provisions of this article.
has_right(article58, PersonId, right_of_detained, freedom_of_religion):-
    person_status(PersonId, detained).

%% has_right(_article2_2, PersonId, _right_of_convicted, _personal_development)
%
% Article 2(2,5,7) Legislative Decree no 121 of 2 October 2018
%
% 2. Community penal measures are provided for when they are suitable to foster development, a fruitful educational and recovery path, 
% provided that there is no danger of the convicted person evading execution or committing other offences. All measures must include an 
% educational intervention programme.
% 5. In the choice of measures, account shall be taken of the need to ensure rapid social integration with the least sacrifice of personal 
% freedom.
% 7. The execution of community penal measures shall take place mainly in the context of the juvenile's life and in respect of positive 
% socio-family relations, unless there are grounds to the contrary and, in any case, provided that there are no indications of links 
% with organised crime.
has_right(article2_2, PersonId, right_of_convicted, personal_development):-
    person_status(PersonId, convicted),
    proceeding_matter(PersonId, no_danger_of_another_offence).

%% has_right(_article19, PersonId, _right_to_interview, PersonId2)
%
% Article 19 Decree no 448 of the President of the Republic of 22 settembre 1988
%
% 1. Detained person shall be entitled to eight interviews per month, of which at least one to be carried out on a public holiday or 
% pre-holiday, with relatives and with people with whom there is a significant emotional connection.
has_right(article19, PersonId, right_to_interview, PersonId2):-
    person_status(PersonId, detained),
    person_status(PersonId2, significant_emotional_connection).

%% has_right(_article12, PersonId, _right_to_phsychological_assistance, _presence_of_parent)
%
% Article 12 Decree no 448 of the President of the Republic of 22 settembre 1988
%
% 1. At any stage and instance of the proceedings, affective and psychological assistance to the accused child shall be ensured by 
% the presence of the parents or other suitable person indicated by the child and admitted by the prosecuting judicial authority.
% 2. In any case, the child shall be insured with the assistance of the services referred to in Article 6.
% 3. The Public Prosecutor and the Judge may carry out acts for which the child is required to participate without the presence of the 
% persons indicated in paragraphs 1 and 2, in the child's interest or when there are mandatory procedural requirements.
has_right(article12, PersonId, right_to_phsychological_assistance, presence_of_parent):-
    proceeding_status(PersonId, started),
    person_status(PersonId, accused),
    (   \+ proceeding_event(PersonId, child_interest)
    ;   \+ proceeding_matter(PersonId, mandatory_procedural_requirements)
    ).

%% has_right(_article13, PersonId, _right_to_privacy, _child_identification)
%
% Article 13 Decree no 448 of the President of the Republic of 22 settembre 1988
%
% The publication and the dissemination, by any means, of information and images that may lead to identification of any child involved 
% in the proceedings is forbidden.
% The provision of paragraph 1 does not apply if after the start of the trial the hearings are held with the presence of the public.
has_right(article13, PersonId, right_to_privacy, child_identification):-
    person_status(PersonId, child),
    \+ proceeding_matter(PersonId, hearing_public_present).

%% has_right(_article20, PersonId, _right_to_privacy, _accompanying_transferring)
%
% Article 20 Legislative Decree no 272 of 28 July 1989
%
% In the execution of the arrest and temporary detention (fermo), while accompanying and transfering the child, the appropriate precautions 
% shall be taken to protect him/her by the curiosity of the public and all sorts of publicity, as well as to reduce, as much as possible, 
% the physical and psychological suffering. It is forbidden to use instruments of physical coercion, unless there is a serious need for 
% security.
has_right(article20, PersonId, right_to_privacy, accompanying_transferring):-
    (   person_status(PersonId, arrested)
    ;   person_status(PersonId, detained)
    ).

%% has_right(_article33, PersonId, _right_to_privacy, _absence_of_public)
%
% Article 33(1-2) Decree no 448 of the President of the Republic of 22 settembre 1988
%
% Trial hearings before the Juvenile Court are held in the absence of the public.
% The accused child who is at least sixteen years old may ask that the hearing is held with the presence of the public. After assessing 
% the validity of the reasons put forward and the appropriateness of the choice of holding a public hearing, the Court shall decide
% in the exclusive interest of the child.
has_right(article33, PersonId, right_to_privacy, absence_of_public):-
    proceeding_status(PersonId, started),
    person_age(PersonId, X),
    X > 16,
    person_request_submitted(PersonId, public_hearing).

%% has_right(_article629_bis, PersonId, _right_to_rescind_judgement, _inculpable_absence)
%
% Article 629-bis criminal procedure code
%
% 1. The accused who has been absent for the entire duration of proceedings and has been convicted or ordered a security measure 
% with a final judgment, can obtain the rescission of the final judgment if he can prove that his absence was due to his inculpable 
% unawareness of the proceedings.
has_right(article629_bis, PersonId, right_to_rescind_judgement, inculpable_absence):-
    proceeding_status(PersonId, concluded),
    (   person_status(PersonId, convicted)
    ;   person_status(PersonId, security_measure)
    ),
    person_circumstances(PersonId, inculpable_absence).

%% has_right(_article118, PersonId, _right_to_repeat_sum, _legal_aid)
%
% Article 118 criminal procedure code
%
% The office defender's fees and expenses are liquidate by the magistrate (...);
% at the same time as communicating the payment decree, the office requires the family members of the minor to submit within one month 
% the documentation required by Article 79 (proof of income requirements) (...);
% The State has the right to repeat the sums advanced in against minors and their families, if the judge, with decree shall ensure that 
% the income limits set for admission to legal aid in criminal proceedings (...).
has_right(article118, PersonId, right_to_repeat_sum, legal_aid):-
    person_status(PersonId, child),
    authority_decision(PersonId, decree_to_repeat).