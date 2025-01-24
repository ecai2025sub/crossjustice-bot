solve((A,B), Result) :- !,
    solve(A, ARes),
    solve(B, BRes),
    append(ARes, BRes, Result).

solve((A;_), Result) :-
    solve(A, Result).

solve((_;B), Result) :- !,
    solve(B, Result).

solve(member(A, B), [system_predicate]) :- !,
    call(member(A, B)).

solve(\+(A), [not(A)]) :- !,
    call(\+(A)).

solve((A)\=(B), [doNotUnify(A, B)]) :- !,
    call((A)\=(B)).

solve(A, [system_predicate]) :-
    predicate_property(A, built_in), !,
    call(A).

solve(A, [A|[Res]]) :-
    clause(A,B),
    solve(B, Res).

solve(A, [abduced(A)]) :-
    abd_enabled,
    A \= has_right(_, _, _, _),
    A \= has_right(_, _, _, _, _),
    \+ clause(A, _),
    \+ call(A).
