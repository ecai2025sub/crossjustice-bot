:- module(directive_2016_1919_it, [has_right/5, auxiliary_right/5, auxiliary_right_checked/5, right_property/5, right_property_checked/5, explain/2]).

:- include('./../../utils.pl').

has_right(Right, it, Article, PersonId, Matter) :-
    has_right(Article, PersonId, Right, Matter).

%%%% Italian Constitution %%%%

%% has_right(_art24_3, PersonId, _right_to_defence, _means_for_legal_action)
%
% Article 24(3) italian constitution
%
% The indigent are assured, by appropriate measures, the means for legal action and defence in all levels of jurisdiction.
has_right(art24_3, PersonId, right_to_defence, means_for_legal_action) :-
    person_status(PersonId, indigent).

%%%% Criminal Procedure Code %%%%
% Article 61 - Fully implemented
% 1. The rights and safeguards of the accused person extend to the suspected person;

%% right_property(_art96, PersonId, _appoint_lawyer, _maximum_two)
%
% Article 96 Criminal Procedure Code
%
% 1. The accused shall have the right to appoint no more than two defence counsel.
% 2. The appointment shall be made by means of a declaration made to the prosecuting authority or delivered to it by the lawyer or sent by registered mail.
% 3. The appointment of the defence counsel of the person arrested or remanded in custody, as long as he/she has not done so, may be made by a close 
% relative, in the manner provided for in paragraph 2.
right_property_scope(art96, [art74_1, art1_2]).

right_property(art96, PersonId, appoint_lawyer, maximum_two).

%%%% Presidential Decree no 115/2002 %%%%
% Article 1 - Fully implemented
% The rules of this text shall govern (...) legal aid.

%% has_right(_art75_2bis, PersonId, _right_to_legal_aid, _arrest)
%
% Article 75(1; 2bis) Presidential Decree no 115/2002
%
% 1. legal aid is valid for every stage of the process and for all possible procedures, derived and accidental, however connected
% 2-bis. The legal aid discipline also applies to passive delivery procedures, as per law 22 April 2005, no. 69, from the moment of arrest carried 
% out in accordance with the European arrest warrant until delivery or until the the non-delivery decision becomes final.
has_right(art75_2bis, PersonId, right_to_legal_aid, arrest) :-
    proceeding_type(PersonId, passive_delivery).

%% has_right(_art74_1, PersonId, _right_to_legal_aid, _trial)
%
% Article 74(1) Presidential Decree no 115/2002
%
% 1. Legal aid is guaranteed in the criminal trial for the defense of the non-wealthy, suspected, accused, convicted, offended person, injured person 
% who intends to become a civil party, civilly liable or civilly obliged for the pecuniary penalty.
has_right(art74_1, PersonId, right_to_legal_aid, trial) :-
    proceeding_type(PersonId, criminal),
    (   person_status(PersonId, non_wealthy)
    ;   person_status(PersonId, suspect)
    ;   person_status(PersonId, accused)
    ;   person_status(PersonId, convicted)
    ;   person_status(PersonId, offended)
    ;   person_status(PersonId, injured)
    ),
    art76Applies(PersonId),
    \+ exception(has_right(art74_1, PersonId, right_to_legal_aid, trial), _).

% 2. Legal aid is also guaranteed in the civil, administrative, accounting, tax and voluntary jurisdiction affairs, for the defense of the 
% poor citizen when his reasons are not manifestly unfounded.

%% art76Applies(PersonId)
%
% Article 76 Presidential Decree no 115/2002
%
% Conditions for admission to legal aid
% 1. Anyone who has a taxable income, resulting from the last tax return, not exceeding 11,746.68 euros, may be admitted to legal aid.
art76Applies(PersonId) :-
    person_taxable_income(PersonId, X),
    X < 11746.68.

%% right_property(_art80_1, PersonId, _appoint_lawyer, _list)
%
% Article 80(1) Presidential Decree no 115/2002
%
% A person granted legal aid may appoint a lawyer from the list of legal aid lawyers maintained by the Bar Councils in the district of the 
% Court of Appeal where the court having jurisdiction as to the substance of the matter or the court before which the case is pending, is sitting.
right_property_scope(art80_1, [art74_1, art1_2]).

right_property(art80_1, PersonId, appoint_lawyer, list).

% Article 81 Presidential Decree no 115/2002
% 1. The list of lawyers that may be appointed for legal aid shall be made up of lawyers who apply for it and who meet the requirements
% laid down in paragraph 2.
% 2. Inclusion on the list shall be decided by the Bar Council, which shall assess whether the following requirements and conditions are met:
% (a) aptitude and specific professional experience, distinguishing between civil, criminal, administrative, accounting, tax and voluntary 
% jurisdiction proceedings;
% b) absence of disciplinary sanctions of more than a warning imposed in the five years preceding the application;
% (c) registration in the Bar for at least two years.
% 3. A lawyer who has been subjected to a disciplinary sanction of more than a warning shall be automatically removed from the list.
% 4. The list is renewed by 31 January of each year, is public, and is kept in all the judicial offices located in the territory of each province.

%% exception(_has_right(_art74_1, PersonId, _right_to_legal_aid, _trial), _art91(PersonId))
%
% Article 91(1, lett a) Presidential Decree no 115/2002
%
% Admission to legal aid is excluded: a) for the sentenced person with final judgment of crimes committed in violation of the rules for the 
% repression of tax and income tax evasion added (...);
exception(has_right(art74_1, PersonId, right_to_legal_aid, trial), art91(PersonId)) :-
    person_event(PersonId, convicted_tax_evasion).

% Article 96 Presidential Decree no 115/2002
% Decision on the application for admission to legal aid
% 1. In the ten days following that in which the application for admission ((...)) Was presented or received, the magistrate before whom the trial hangs (...) 
% having verified the admissibility of the application, admits the interested party to legal aid if, like the substitute declaration provided for by 
% article 79, paragraph 1, letter c), the income conditions are met which the admission to the benefit it is subordinate.

%% auxiliary_right(_art99, PersonId, _remedy, _application_rejection)
%
% Article 99 Presidential Decree no 115/2002
%
% 1. The interested party may appeal against the decision by which the competent magistrate rejects the application for admission, within twenty days 
% of being informed in accordance with Article 97, before the President of the Court or the President of the Court of Appeal to which the magistrate 
% who issued the rejection decree belongs.
auxiliary_right_scope(art99, [art74_1, art1_2]).

auxiliary_right(art99, PersonId, remedy, application_rejection).

% 2. The appeal shall be served on the financial office which is a party to the relevant proceedings.
% 3. The procedure shall be the special procedure established to debate for lawyers' fees and the court shall proceed as a single judge.
% 4. The order deciding on the appeal shall be notified within ten days, by the office of the prosecuting magistrate, to the person concerned and to 
% the financial office, which, within the following twenty days, may lodge an appeal for cassation on the grounds of violation of the law. 
% The appeal shall not suspend the execution of the measure.

%% auxiliary_right(_art101_1, PersonId, _appoint_lawyer, _private_investigator)
%
% Article 101(1) Presidential Decree no 115/2002
%
% 1. The lawyer of the person admitted to legal aid may appoint, for the purpose of carrying out defence investigations, a deputy or an authorised private 
% investigator residing in the district of the court of appeal where the court with jurisdiction over the matter in question is located.
% 2. The deputy defence counsel and the private investigator referred to in paragraph 1 may also be chosen outside the district of the court of appeal 
% referred to in the same paragraph 1, but in this case the travel expenses and allowances provided for in the professional tariffs shall not be due.
auxiliary_right_scope(art101_1, [art74_1, art1_2]).

auxiliary_right(art101_1, PersonId, appoint_lawyer, private_investigator).

%%%% Legislative Decree no 24 of 2019 %%%%

%% has_right(_art1_2, PersonId, _right_to_legal_aid, _arrest)
%
% Article 1(2) Legislative Decree no 24 of 2019
%
% The legal aid discipline also applies to passive delivery procedures, as per law 22 April 2005, no. 69, from the moment of arrest carried 
% out in accordance with the European arrest warrant until delivery or until the moment in which the decision on the non-surrender becomes definitive, 
% as well as in the active delivery procedures, referred to in the aforementioned law n. 69 of 2005, in favor of the wanted person subject to a 
% European arrest warrant execution procedure for the purpose of the prosecution and who has exercised the right to appoint a defender on the 
% national territory to assist the defender in the Executing Member State.
has_right(art1_2, PersonId, right_to_legal_aid, arrest) :-
    proceeding_type(PersonId, passive_delivery);
    proceeding_type(PersonId, active_delivery).

% TODO - need to transpose specific rights for children?

