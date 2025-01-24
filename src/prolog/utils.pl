:- set_prolog_flag(unknown, warning).
:- style_check(-discontiguous).
:- style_check(-singleton).

:- include('meta_interpreter.pl').

:- dynamic person_status/2.
:- dynamic proceeding_status/2.
:- dynamic proceeding_type/2.
:- dynamic person_document/2.
:- dynamic proceeding_matter/2.
:- dynamic authority_decision/2.
:- dynamic holds_parental_responsibility/2.

auxiliary_right(Art, Ref, PersonId, Matter, Value) :-
    auxiliary_right_scope(Art, Refs),
    member(Ref, Refs),
    auxiliary_right(Art, PersonId, Matter, Value).

auxiliary_right_checked(Art, Ref, PersonId, Matter, Value) :-
    auxiliary_right_scope(Art, Refs),
    member(Ref, Refs),
    has_right(_, _, Ref, PersonId, _),
    auxiliary_right(Art, PersonId, Matter, Value).

right_property(Art, Ref, PersonId, Matter, Value) :-
    right_property_scope(Art, Refs),
    member(Ref, Refs),
    right_property(Art, PersonId, Matter, Value).

right_property_checked(Art, Ref, PersonId, Matter, Value) :-
    right_property_scope(Art, Refs),
    member(Ref, Refs),
    has_right(_, _, Ref, PersonId, _),
    right_property(Art, PersonId, Matter, Value).

explain(X, Explanation) :- call(solve(X, Explanation)).

person_language(PersonId, Language):-
    person_understands(PersonId, Language),
    person_speaks(PersonId, Language).

% define deprived_of_liberty