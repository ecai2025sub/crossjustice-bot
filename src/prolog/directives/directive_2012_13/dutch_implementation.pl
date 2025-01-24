
:- module(directive_2012_13_nl, [has_right/5, auxiliary_right/5, auxiliary_right_checked/5, right_property/5, right_property_checked/5, explain/2]).

:- include('./../../utils.pl').

has_right(Right, nl, Article, PersonId, Matter) :-
    has_right(Article, PersonId, Right, Matter).

%%%%% Preliminary Remark %%%%
%As a second preliminary remark, note that the term 'suspect' in this table may refer to the suspect or the accused, or both,
%depending on the context. This corresponds to the Dutch legal terminology, in which persons suspected of a crime are called 'suspects',
%both before and after indictment.

%%%%% (Dutch) Code of Criminal Procedure %%%%%

%% has_right(_art27c_1, PersonId, _right_to_information, _accusation)
%
% Article 27c(1) code of criminal procedure
%
% Upon being stopped or arrested, the suspect shall be informed of which criminal act he is suspected of having committed.
% The suspect who was not stopped or arrested shall be informed of the accusation at the latest preceding the first interrogation.
has_right(art27c_1, PersonId, right_to_information, accusation) :-
    person_status(PersonId, suspect);
    person_status(PersonId, arrested).

%% has_right(_art27c_2, PersonId, _right_to_information, _)
%
% Article 27c(2) code of criminal procedure
%
% Preceding to the first interrogation and without prejudice to the provisions of Article 29(2), the suspect who has not been
% arrested shall be informed of his right to legal assistance, referred to in Article 28(1) and, if applicable, his right to
% interpretation and translation, referred to in Article 27(4).
has_right(art27c_2, PersonId, right_to_information, lawyer) :-
    person_status(PersonId, suspect),
    \+ person_status(PersonId, arrested).

has_right(art27c_2, PersonId, right_to_information, interpretation) :-
    person_status(PersonId, suspect),
    \+ person_status(PersonId, arrested).

has_right(art27c_2, PersonId, right_to_information, translation) :-
    person_status(PersonId, suspect),
    \+ person_status(PersonId, arrested).

%% has_right(_art27c_3, PersonId, _right_to_information, _)
%
% Article 27c(3) code of criminal procedure
%
% Promptly upon arrest, but at the latest preceding the first interrogation, the suspect shall be informed in writing of:
% a) his right to be informed according to paragraph 1;
% b) the rights referred to in paragraph 2;
% c) the provision of Article 29(2);
% d) the right of access to the materials of the case as provided for under Articles 30-34;
% e) the term within which the suspect, pursuant to this code and if not yet released, is brought before the examining judge;
% f) the possibilities under this code to request revocation or suspension of pre-trial detention.
% g) the right to have one person informed of deprivation of liberty, in accordance with Article 27e(1);
% h) the right to have consular authorities informed of deprivation of liberty, in accordance with Article 27(2);
% i) those rights envisaged by legislative decree

has_right(art27c_3_a, PersonId, right_to_information, accusation) :-
    person_status(PersonId, arrested).

has_right(art27c_3_b, PersonId, right_to_information, lawyer) :-
    person_status(PersonId, arrested).

has_right(art27c_3_b, PersonId, right_to_information, interpretation) :-
    person_status(PersonId, arrested).

has_right(art27c_3_b, PersonId, right_to_information, translation) :-
    person_status(PersonId, arrested).

has_right(art27c_3_d, PersonId, right_to_information, access_materials) :-
    person_status(PersonId, arrested).

has_right(art27c_3_e, PersonId, right_to_information, limitation_to_deprivation_of_liberty) :-
    person_status(PersonId, arrested).

has_right(art27c_3_f, PersonId, right_to_information, revocation_suspension) :-
    person_status(PersonId, arrested),
    proceeding_matter(PersonId, detention),
    proceeding_matter(PersonId, pre_trial).

has_right(art27c_3_g, PersonId, right_to_information, inform_person) :-
    person_status(PersonId, arrested),
    person_status(PersonId, deprived_of_liberty).

has_right(art27c_3_h, PersonId, right_to_information, inform_consul) :-
    person_status(PersonId, arrested),
    person_status(PersonId, deprived_of_liberty).

has_right(art27c_3_i, PersonId, right_to_information, rights) :-
    person_status(PersonId, arrested).

% TODO need to add Time
% To arrested persons, information about the accusation must be provided upon arrest (first sentence);
% to non-arrested persons, information about the accusation must be provided at the latest prior to the first police interrogation
% (second sentence).

%% auxiliary_right(art27c_4, PersonId, _right_to_information, Language)
%
% Article 27c(4) - Partially implemented
%
% The suspect who does not, or not sufficiently, speak or understand Dutch, shall be informed of his rights in a language he understands.

auxiliary_right_scope(art27c_4, [art27c_1, art27c_2, art27c_3_a, art27c_3_b, art27c_3_d, art27c_3_e, art27c_3_f, art27c_3_g, art27c_3_h, art27c_3_i]).

auxiliary_right(art27c_4, PersonId, right_to_information, Language) :-
    person_language(PersonId, Language),
    proceeding_language(PersonId, dutch),
    \+ Language = dutch.

%% auxiliary_right(_art27c_5, PersonId, _record, _information)
%
% Article 27c(5) code of criminal procedure
%
% The communication of rights shall be officially recorded.

auxiliary_right_scope(art27c_5, [art27c_1, art27c_2, art27c_3_a, art27c_3_b, art27c_3_d, art27c_3_e, art27c_3_f, art27c_3_g, art27c_3_h, art27c_3_i]).

auxiliary_right(art27c_5, PersonId, record, information).

%% has_right(_art59_2, PersonId, _right_to_information, _accusation)
%
% Article 59(2) code of criminal procedure
%
% It shall specify as precisely as possible the criminal offence, the grounds on which it is issued and the specific circumstances
% that led to the assumption of these grounds.
has_right(art59_2, PersonId, right_to_information, accusation) :-
    person_status(PersonId, accused).

%% has_right(_art78_2, PersonId, _right_to_information, _accusation)
%
% Article 78(2) code of criminal procedure
%
% It shall specify as precisely as possible the criminal offence in regard of which the suspicion has arisen and the facts or
% circumstances on which the serious suspicions against the suspect are based, as well as the conduct, facts or circumstances
% which show that the conditions set in section 67a have been met.
has_right(art78_2, PersonId, right_to_information, accusation) :-
    person_status(PersonId, suspect).

%%Article 258 code of criminal procedure
%The case shall be brought before the court by means of a summons served on behalf of the public prosecutor on the suspect; the start
%of the trial proceedings is thus initiated.
% proceeding_status(PersonId, started) :-
%    person_status(PersonId, suspect),
%    proceeding_matter(PersonId, summoned_court).

%The presiding judge of the District Court shall determine, on application and recommendation of the public prosecutor, the date and
%time of the court session. In the determination of the date and time of the court session or later, he may order that the suspect
%appear in person; to that end he may also order that he be forcibly brought to court. The presiding judge may also order that a witness
%who, based on facts and circumstances, is not thought likely to comply with the summons to appear at the court session, be forcibly
%brought to court. In addition, the presiding judge of the District Court may order the public prosecutor to conduct further
%investigations or have others conduct further investigations, and to add data carriers and documents to the case documents or to
%submit convicting pieces of evidence.
%The persons as referred to in section 51e(2, first sentence),(3), (5) or (6), may request the leave of the presiding judge to have
%their lawyer, or an authorised representative who has been given a special power of attorney for that purpose, exercise the right
%vested in them to make a verbal statement at the court session. If more than three surviving relatives referred to in 51e(4)(b)
%have notified their wish to exercise their right to make a verbal statement at the court session, and they fail to agree among
%themselves which of them will address the court, the presiding judge shall decide which three persons may exercise the right to make
%a verbal statement.

%Article 261(1-2) code of criminal procedure
%The summons shall contain a statement of the offence which is indicted, stating at approximately which time and at which place it
%was allegedly committed; in addition, it shall state the statutory provisions under which the offence is punishable.
%It shall also state the circumstances under which the offence was allegedly committed.

%Article 265 code of criminal procedure
%A period of at least ten days must have expired between the day on which the summons in served on the suspect and the day of the
%court session. In the event that the examining magistrate has issued orders for the maintenance of public order in accordance with
%Part Seven of Book Four, a period of at least four days must have expired.
%If the summons is served in the manner provided for in section 587(2), the suspect may have included in the record of delivery a statement in which he consents to a reduction of this time limit; he must sign the statement; if he is unable to sign, the cause of the inability shall be stated in the record.
%If the one or the other is omitted, the District Court shall adjourn the hearing, unless the suspect has appeared. In the latter case and if the suspect applies for a postponement in the interest of his defence, then the District Court shall adjourn the hearing for a definite period, unless it considers in a reasoned decision that, in all reasonableness, continuation of the hearing cannot prejudice the suspect in his defence.

%%%%% Surrender of Persons Act %%%%%

%% has_right(_art17_3, PersonId, _right_to_information, _)
%
% Article 17(3) surrender of persons act
%
% Upon arrest, the requested person shall be promptly informed in writing about:
% a) the right to receive a copy of the European arrest warrant, as referred to in Article 23(3);
% b) the right of access to a lawyer, as referred to in Article 43a, and the possibility to request the appointment of a lawyer in
% the issuing Member State, as referred to in Article 21a;
% c) the right to interpretation, as referred to in Article 30, and the right to translation, as provided for under Article 23(3),
% fourth and fifth sentences;
% d) the right to be heard, as referred to in Article 24;
% e) the rights referred to in Article 27c(3) under g and h of the Code of Criminal Procedure.
has_right(art17_3_a, PersonId, right_to_information, receive_copy_europeanArrestWarrant) :-
    person_status(PersonId, arrested).

has_right(art17_3_b, PersonId, right_to_information, lawyer) :-
    person_status(PersonId, arrested).

has_right(art17_3_c, PersonId, right_to_information, interpretation) :-
    person_status(PersonId, arrested).

has_right(art17_3_c, PersonId, right_to_information, translation) :-
    person_status(PersonId, arrested).

has_right(art17_3_d, PersonId, right_to_information, right_to_be_heard) :-
    person_status(PersonId, arrested).

has_right(art17_3_e, PersonId, right_to_information, inform_person) :-
    person_status(PersonId, arrested).

has_right(art17_3_e, PersonId, right_to_information, inform_consul) :-
    person_status(PersonId, arrested).

%% auxiliary_right(_art17_3, PersonId, _right_to_information, Language)
%
% Article 17(3) surrender of persons act
%
% The requested person who does not have a sufficient command of Dutch shall be informed of his rights in a language he understands.
% Articles 27e, 488ab, and 488b Code of Criminal Procedure shall apply accordingly.
% The suspect who does not, or not sufficiently, speak or understand Dutch, shall be informed of his rights in a language he understands.

auxiliary_right_scope(art17_3, [art17_3_a, art17_3_b, art17_3_c, art17_3_d, art17_3_e]).

auxiliary_right(art17_3, PersonId, right_to_information, Language) :-
    person_language(PersonId, Language),
    proceeding_language(PersonId, dutch),
    \+ Language = dutch.


%Article 21(1) surrender of persons act
%The requested person may be arrested without further formalities on the basis of a European arrest warrant which meets the
%requirements of Article 2. Article 17, paragraph 3, shall apply mutatis mutandis.

%%%%% Decree on information about rights in criminal proceedings %%%%%
%Article 1(c) code of criminal procedure
%The letter of rights under Article 27c(3) Code of Criminal Procedure shall include information about:
%c. what follows from the Official instruction for the police, the royal gendarmerie and other investigating officers.

%%%%% Official instruction for the police, the royal gendarmerie and other investigating officers %%%%%

%% has_right(_art17_3_e, PersonId, _right_to_information, _medical_assistance)
%
% Article 32 Official instruction for the police, the royal gendarmerie and other investigating officers
%
% Where there are indications that the detainee needs medical assistance or medication has been found on him, the officer shall
% consult with the doctor. The officer shall also consult with the doctor if the detainee himself has requested medical assistance
% or medication.
has_right(art17_3_e, PersonId, right_to_information, medical_assistance) :-
    person_status(PersonId, detained),
    (   person_request_submitted(PersonId, medical_assistance)
    ;   person_status(PersonId, need_medical_assistance)
    ).

%Where the detainee has asked for medical assistance by his own doctor, the officer shall inform the doctor in question thereof.
%Where the detainee has made it known that he does not want medical assistance, while there are indications that medical assistance
%is desirable, the officer shall warn the doctor and inform the doctor of the detainee's attitude.


