:- module(directive_2016_1919_pl, [has_right/5, auxiliary_right/5, auxiliary_right_checked/5, right_property/5, right_property_checked/5, explain/2]).

:- include('./../../utils.pl').

has_right(Right, pl, Article, PersonId, Matter) :-
    has_right(Article, PersonId, Right, Matter).

%%% Law of 6 June 1997 - Code of Criminal Procedure %%%

%% has_right(_art78_1, PersonId, _right_to_legal_aid, _appoint_ex_officio)
%
% Article 78(1-1a) code of criminal procedure
%
% 1. An accused, who does not have a defence counsel of his own choice, may request the appointment of a defence counsel ex officio, 
% if he can duly prove that he is unable to bear the costs of defence without prejudice to the necessary maintenance of himself, or his family.
has_right(art78_1, PersonId, right_to_legal_aid, appoint_ex_officio) :-
    person_status(PersonId, cannot_bear_costs),
    person_request_submitted(PersonId, appoint_lawyer).

% 1a. The provision of § 1a applies accordingly to the appointment of the defence counsel for the purpose of conducting specific procedural action.

%% right_property(_art81a_1, PersonId, _appoint_lawyer, _list)
%
% Article 81a(1-4) code of criminal procedure
%
% 1 CCP Defence counsel ex officio is appointed from the list of defence counsels.
right_property_scope(art81a_1, [art78_1]).

right_property(art81a_1, PersonId, appoint_lawyer, list).

% 2. The request for the appointment of a defence counsel ex officio is heard immediately by the president of the court, the court or the court referendary.
% 3. If, in view of the circumstances, the defence should be undertaken immediately, the president of the court, the court or the court referendary 
%immediately notifies the accused and the defence counsel in a manner specified in Article 137, of the appointment of the defence counsel ex officio.
% 4. The Minister of Justice shall define by way of a regulation:
% 1) the modalities of guarantying to the accused the assistance of the defence counsel ex officio, including the modality of forming the list of 
% defence counsels providing legal assistance ex officio and of their appointment,
% 2) the manner in which the request for the appointment of the defence counsel should be filed with the court and the detailed manner in which such 
% motion should be heard, bearing in mind the necessity of insuring a correct course of proceedings, as well a correct realisation of the right to defence.

%% auxiliary_right(_art81_1a, PersonId, _remedy, _appoint_lawyer)
%
% Article 81(1a) code of criminal procedure
%
% The decision of the president of the court denying the appointment of the defence counsel is subject to interlocutory appeal to the court competent 
% to hear the case. The court’s decision denying the appointment of the defence counsel is subject to interlocutory appeal to another equivalent 
% panel of the same court.
auxiliary_right_scope(art81_1a, [art78_1]).

auxiliary_right(art81_1a, PersonId, remedy, appoint_lawyer) :-
    proceeding_matter(PersonId, appointment_denied).

%% auxiliary_right(_art81_2, PersonId, _appoint_lawyer, _replace)
%
% Article 81(2) code of criminal procedure
%
% Upon a justified request of the accused, or his defence counsel, the president of the court or the court referendary of the court competent to 
% hear the case may appoint a new defence counsel to replace the former.
auxiliary_right_scope(art81_2, [art78_1]).

auxiliary_right(art81_2, PersonId, appoint_lawyer, replace) :-
    person_request_submitted(PersonId, replace_lawyer).

%% has_right(_art87_2, PersonId, _right_to_access_lawyer, _appoint_lawyer)
%
% Article 87(2-3) code of criminal procedure
%
% 2. A person, who is not a party to the proceedings, may appoint a legal counsel if his interest in the proceedings so requires.
% 3. The court, and in preparatory proceedings the public prosecutor, may refuse to admit the attorney referred to in § 2 to participation in the 
% proceedings, if in their opinion it is not necessary for the protection of the interests of the person, who is not a party to the proceedings.
has_right(art87_2, PersonId, right_to_access_lawyer, appoint_lawyer) :-
    person_status(PersonId, third_party),
    proceeding_matter(PersonId, need_to_appoint_counsel),
    \+ authority_decision(PersonId, opinion_not_necessary).

% Article 88(1) code of criminal procedure
% 1. Only an advocate, a legal advisor or a counsel of the Office of the General Counsel to the Republic of Poland may act as an legal counsel. 
% Articles 77, 78, 81a § 1-3, 83, 84 and 86 § 2 and provisions issued on the basis of Article 81a § 4 apply accordingly to the legal counsel.
