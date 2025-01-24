:- module(directive_2016_1919_bg, [has_right/5, auxiliary_right/5, auxiliary_right_checked/5, right_property/5, right_property_checked/5, explain/2]).

:- include('./../../utils.pl').

has_right(Right, bg, Article, PersonId, Matter) :-
    has_right(Article, PersonId, Right, Matter).

%% has_right(_art94_1_9, PersonId, _right_to_legal_aid, _free)
%
% Article 94(1)(9) - Fully implemented
%
% Mandatory participation of defence counsel
% (1) Participation of the defence counsel in criminal proceedings shall be mandatory in cases where:
% 6. A request under Article 64 has been made or the accused party is detained;
% 9. The accused party cannot afford to pay a lawyer fee, wishes to have a defence counsel and the interests of justice so require.
has_right(art94_1_9, PersonId, right_to_legal_aid, free) :-
    person_status(PersonId, accused),
    authority_decision(PersonId, lack_resources).

% TODO - Wishes? Submit a request?

%% has_right(_art23_1, PersonId, _right_to_legal_aid, _free)
%
% Article 23(1) - Fully implemented
%
% (1) The legal aid system referred to in Item 3 of Article 21 herein shall cover the cases in which the assistance of a lawyer,
% a stand-by defence counsel or representation is mandatory as provided by virtue of a law.
% (2) The legal aid system shall furthermore cover the cases in which an accused, a defendant, or a party to a criminal,
% civil or administrative matter is unable to pay for the assistance of a lawyer, wishes to have such assistance, and the interests of justice require this.
% (4) In criminal matters, the determination that the accused or the defendant is unable to pay a lawyer's fee shall be made by the authority who directs the
% procedural steps on the basis of the property status of the person ascertained ex officio in the specific matter and of the circumstances referred to in
% Items 1, 3, 4, 5, 6 and 7 of Paragraph (3). In respect of the private accuser, the civil plaintiff, the civil respondent and the private complainant, the
% determination shall be made according to the procedure established by Paragraph (3).
has_right(art23_1, PersonId, right_to_legal_aid, free) :-
    proceeding_matter(PersonId, lawyer_presence_mandatory).

%% has_right(_art58_2, PersonId, _right_to_access_lawyer, _europeanArrestWarrant)
%
% Article 58(2) - Fully implemented
%
% Information Provided by Issuing Authority
% (1) The issuing authority under Article 56 (1) shall provide the necessary information and data in relation to the execution of a European arrest warrant at the request of the executing authority.
% (2) Where the person claimed has stated before the competent authority of the executing state that he/she wishes to exercise his/her right to a defence
% councel in the Republic of Bulgaria to support his/her defence councel in the executing state with information and advice and the issuing authority referred
% to in Article 56(1) has been notified accordingly by the competent authority of the executing state, the issuing authority shall provide the person claimed with
% the information he/she requires in order to be facilitated in appointing a defense counsel in the Republic of Bulgaria and shall appoint a defence counsel if the person claimed has not authorised such councel.
has_right(art58_2, PersonId, right_to_access_lawyer, europeanArrestWarrant) :-
    proceeding_matter(PersonId, europeanArrestWarrant),
    person_request_submitted(PersonId, appoint_lawyer).

%% auxiliary_right(_art25_1, PersonId, _remedy, _appeal)
%
% Article 25(1) - Fully implemented
%
% (1) In the cases referred to in Items 3 and 4 of Article 21 herein, the decision to grant legal aid shall be made by the authority directing the procedural steps or by the relevant
% police or customs authority or authority under Article 124b(1) of the State Agency for National Security Act at the request of the person concerned or by virtue of the law, and explanations
% in writing shall be provided to the person by a declaration in a standard form endorsed by the NLAB to the effect that in case of a judgment finding against the said person or a sentence,
% the person owes reimbursement of the costs of legal aid. A refusal to grant legal aid shall be reasoned and shall be appealable according to the applicable procedure.
auxiliary_right_scope(art25_1, [art23_1, art94_1_9]).

auxiliary_right(art25_1, PersonId, remedy, appeal).


