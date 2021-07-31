-module(test).
-include_lib("eunit/include/eunit.hrl").

temp_test() -> 
	[cels(),
	?_assertError(badarith, 1/0)].

cels() ->
	[?_assertEqual(ok, cliente_server:temp(36)),
	?_assertEqual(ok, cliente_server:temp(45.6))].
	