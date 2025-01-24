% remove annoying ellipsis behavior
:- set_prolog_flag(answer_write_options,
		   [	quoted(true),
			portray(true),
			attributes(portray)
		   ]).
:- set_prolog_flag(debugger_write_options,
		   [	quoted(true),
			portray(true),
			attributes(portray)
		   ]).

% get stack traces in exceptions
:- use_module(library(prolog_stack)).
:- dynamic prolog_stack:stack_guard/1.
:- multifile prolog_stack:stack_guard/1.
prolog_stack:stack_guard(_).
