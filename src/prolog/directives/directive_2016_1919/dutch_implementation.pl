:- module(directive_2016_1919_nl, [has_right/5, auxiliary_right/5, auxiliary_right_checked/5, right_property/5, right_property_checked/5, explain/2]).

:- include('./../../utils.pl').

has_right(Right, nl, Article, PersonId, Matter) :-
    has_right(Article, PersonId, Right, Matter).

%%%% Legal Aid Act %%%%

%% has_right(_art12_1, PersonId, _right_to_legal_aid, _trial)
%
% Article 12(1) legal aid act
%
% Legal aid shall only be granted in respect of legal interests laying in the Dutch legal sphere, to natural or legal persons whose financial 
% capacity does not exceed the amounts set out in Article 34.
has_right(art12_1, PersonId, right_to_legal_aid, trial) :-
    (   person_nature(PersonId, natural)
    ;   person_nature(PersonId, legal)
    ),
    art34Applies(PersonId),
    \+ exception(has_right(art12_1, PersonId, right_to_legal_aid, trial), _).

%% exception(_has_right(_art12_1, PersonId, _right_to_legal_aid, _trial), _art12_2Applies(PersonId))
%
% Article 12(2)(a-c) legal aid act
%
% Legal aid shall not be granted if:
% a. the request for legal aid is evidently devoid of any foundation;
% b. the costs related to the legal aid to be granted are not reasonably proportionate to the significance of the case;
% c. the request for legal aid relates to a criminal case and it is likely, given the norm to have been violated, that a small fine relative the 
% income will be imposed;
% (d) the request for legal aid is made by a legal entity established for the purpose of conducting legal proceedings;
% (e) the legal interest to which the request pertains is self-employment, unless (1) continuance of the profession or company insofar as not in the 
% form of a legal entity is dependent on the outcome of the requested legal aid, or (2) the profession or company has been shut down for at least one year,
% the applicant is or has been involved in first instance proceedings as a respondent or defendant, and the cost of legal assistance cannot be remunerated 
% any other way;
% (f) the legal interest is that of bringing the matter before an international body entrusted by treaty with the administration of justice or a comparable 
% international body and the body itself provides for the entitlement of remuneration of legal assistance;
% (g) the protection of the interest involved can reasonably be left to the applicant, if need be with the assistance of another person or institution 
% whose duties do not fall within the scope of this statute.
exception(has_right(art12_1, PersonId, right_to_legal_aid, trial), art12_2Applies(PersonId)) :-
    proceeding_event(PersonId, legal_aid_request_devoid_fundation);
    proceeding_event(PersonId, costs_not_proportionate);
    proceeding_event(PersonId, small_fine_imposed).

%% exception(_has_right(_art12_1, PersonId, _right_to_legal_aid, _trial), _art28Applies(PersonId))
%
% Article 28 legal aid act
%
% The governing body [of the Legal Aid Board] may deny the assignment if the request:
% (a) is submitted after the legal aid has in fact already been provided;
% (b) concerns a legal interest in respect of which the applicant may claim legal aid on the grounds of an assignment previously issued;
% (c) concerns a legal problem that according to the governing body can be easily settled;
% (d) concerns a legal problem that can be settled by the facility provided for in article 7(2), or of the facility provided for in article 8(2), 
% insofar as they are charged with the provision of legal assistance.
% Further rules regarding the provisions of the first paragraph may be set by the Legislative Decree provided for in article 12(3).
% The first paragraph, subparagraphs a and c, shall not apply, where it concerns an assignment in a case in which the legal assistance provided consists 
% of the provision of simple legal advice. The governing body may nevertheless deny a request for assignment, if the request has not been submitted within 
% four weeks of the advice being given.
exception(has_right(art12_1, PersonId, right_to_legal_aid, trial), art28Applies(PersonId)) :-
    proceeding_event(PersonId, legal_aid_provided);
    proceeding_event(PersonId, can_claim_aid_for_previous_assignment);
    proceeding_event(PersonId, problem_easily_settled);
    proceeding_event(PersonId, simple_legal_advice).

%% art34Applies(PersonId)
%
% Article 34 legal aid act
%
% Legal aid as per the provisions of this statute shall be granted to those whose annual income is 21800 Euros [as of 1 January 2020: 27900 Euros] 
% or less if they are a single householder, or, if they share a household with one or more persons, does not exceed 31000 Euros 
% [as of 1 January 2020: 39400 Euros].
art34Applies(PersonId) :-
    person_event(PersonId, single_householder),
    person_income(PersonId, X),
    X < 27900.

art34Applies(PersonId) :-
    person_event(PersonId, share_householder),
    person_income(PersonId, X),
    X < 39400.

% In derogation of the provisions of paragraph 1 legal aid shall not be granted, where the litigant's assets exceed their tax-free allowance.
% Save in case of mutually contradictory interests, in determining the litigant's income and assets, consideration shall also be given to the income and 
% assets of: (a) the spouse of registered partner of the litigant, unless at the time of the request they are permanently separated; 
% (b) the person of the opposite or same sex with whom the litigant shares a household on a long-term basis, unless at the time of the request there exists 
% between this person and the litigant a blood relationship of the first or second degree.
% The income limits as per the first paragraph shall be adjusted each year as of 1 January according to the percentage with which the salary index as 
% of 31 October of the previous year deviates from the corresponding index as of 31 October of the year before that, on the understanding that this 
% shall be rounded off to the nearest multiple of 100 Euros. Each year our Minister shall publish the indexed amounts in the Government Gazette [Staatscourant]. 
% What the salary index, as per the first sentence, comprises, shall be set out in a Legislative Decree.
% TODO ? Other income-related articles?

%% has_right(_art43, PersonId, _right_to_legal_assistance, _free_of_charge)
%
% Article 43 legal aid act
%
% In the cases in which, pursuant to a statutory provision of the Criminal Code or the Code of Criminal Procedure, a suspect, a convicted person or a 
% former suspect has been assigned counsel by the governing body [of the Legal Aid Board], or has been assigned counsel on the instructions of the judge, 
% the legal assistance shall be free of charge, notwithstanding the third paragraph. The first sentence is not applicable to the assistance provided by 
% assigned counsel during questioning as per Article 28d of the Code of Criminal Procedure of a person suspected of a criminal offence in respect of 
% which pre-trial detention is not permitted.
has_right(art43, PersonId, right_to_legal_assistance, free_of_charge) :-
    (   person_status(PersonId, suspect)
    ;   person_status(PersonId, convicted)
    ),
    authority_decision(PersonId, assign_legal_aid),
    \+ proceeding_matter(PersonId, pre_trial_detention_not_allowed).

%%%%% (Dutch) Code of Criminal Procedure %%%%%

%% has_right(_art28, PersonId, _right_to_access_lawyer, _trial)
%
% Article 28 code of criminal procedure
%
% The suspect or accused shall have the right to be assisted by defence counsel in accordance with the provisions of this Code.
% Legal assistance shall be provided to the suspect or accused in accordance with the manner provided by law, by an assigned defence 
% counsel or defence counsel of his choice.
% In special cases and upon reasoned request by the suspect or accused, more than one defence counsel may be assigned.
% On each occasion that he requests to speak to his defence counsel, the suspect or accused shall be given the opportunity to do so 
% as much as possible.
has_right(art28, PersonId, right_to_access_lawyer, trial):-
    person_status(PersonId, suspect);
    person_status(PersonId, accused).

%% has_right(_art28b, PersonId, _right_to_access_lawyer, _trial)
%
% Article 28b code of criminal procedure
%
% 1. If a vulnerable suspect or accused person or person suspected or accused of a crime punishable by twelve years' imprisonment 
% or more has been arrested, the assistant public prosecutor to have ordered their detention for investigation at the arraignment 
% shall notify the governing body of the Legal Aid Board of the arrest immediately, in order that the governing board assign a lawyer. 
% This notification need not take place if the suspect or accused person has chosen a lawyer and this lawyer or their replacement 
% is available promptly.
% 2. If a person suspected or accused of a crime in respect of which pre-trial detention is permitted to have been arrested has, 
% in reply to a question put to him, requested legal assistance, the assistant public prosecutor to have ordered his detention 
% for investigation at the arraignment shall inform the governing body of the Legal Aid Board of the arrest immediately, in order 
% that the governing board assign a lawyer. The second sentence of the first paragraph shall apply mutatis mutandis.
% 3. If a person suspected or accused of a crime in respect of which pre-trial detention is not permitted to have been arrested has, 
% in reply to a question put to him, requested legal assistance, he shall be given the opportunity to contact a lawyer of his own choice.
% 4. If the assigned lawyer is not available within two hours of the notification referred to in the first, second or third paragraph 
% being given, and if the chosen lawyer is not available within two hours of the contact with the suspect or accused pursuant to 
% the first, second and third paragraph, the assistant public prosecutor may, if the suspect or accused waives his right to legal 
% assistance in connection with the questioning, decide to commence the questioning of the suspect or accused.

has_right(art28b_1, PersonId, right_to_access_lawyer, trial):-
    (   person_status(PersonId, arrested)
    ;   person_status(PersonId, detained)
    ),
    person_status(PersonId, vulnerable),
    proceeding_matter(PersonId, imprisonment_over_twelve_years),
    \+ exception(has_right(art28b_1, PersonId, right_to_access_lawyer, trial), _).

has_right(art28b_2, PersonId, right_to_access_lawyer, trial):-
    person_status(PersonId, arrested),
    proceeding_matter(PersonId, pre_trial_detention),
    \+ exception(has_right(art28b_2, PersonId, right_to_access_lawyer, trial), _).

has_right(art28b_3, PersonId, right_to_access_lawyer, trial):-
    person_status(PersonId, arrested),
    \+ proceeding_matter(PersonId, pre_trial_detention),
    \+ exception(has_right(art28b_3, PersonId, right_to_access_lawyer, trial), _).

exception(has_right(_, PersonId, right_to_access_lawyer, trial), art28b_4) :-
    proceeding_matter(PersonId, questioning),
    person_request_submitted(PersonId, waive_right).

%%%% Surrender of Persons Act %%%%

%% has_right(_art43, PersonId, _right_to_access_lawyer, _trial)
%
% Article 43a surrender of persons act
%
% In the proceedings for surrender of a person by the Netherlands, the requested person has the right to be assisted by a lawyer.
% Articles 28, 28a, 28c(2), 29a(1), 37, 38, 43 to 45 and 124 of the Code of Criminal Procedure shall apply mutatis mutandis.
% If a requested person is arrested pursuant to this statute, the assistant public prosecutor shall notify the governing body of the Legal Aid Board thereof, 
% in order that the governing body appoints a lawyer. Articles 28b(1), second sentence, and 39 of the Code of Criminal Procedure shall apply mutatis mutandis.
% If a person deprived of their liberty pursuant to the Surrender of Persons of Act – other than pursuant to a European arrest warrant or a Dutch warrant 
% of arrest or provisional arrest, or an order to be taken into police custody or for such custody to be extended – does not have a lawyer, the governing 
% body of the Legal Aid Board shall, upon notification of the deprivation of liberty by the Public Prosecution Service, appoint a lawyer.
has_right(art43a, PersonId, right_to_access_lawyer, trial):-
    person_status(PersonId, requested),
    proceeding_matter(PersonId, surrender).

right_property_scope(art43a_2, [art43a_1]).

right_property(art43a_2, PersonId, notice, legal_Aid_Board).

has_right(art43a_5, PersonId, right_to_access_lawyer, ex_officio) :-
    person_status(PersonId, deprived_of_liberty).
