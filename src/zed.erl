-module(zed,[ Name]).
-behavior(gen_server).

-export([start_link/0, init/1, handle_cast/2]).
-export([increment/0]).

increment() ->
    gen_server:cast(Name, increment).

start_link() ->
    gen_server:start_link({local, Name}, {?MODULE, Name}, [], []).

init([]) ->
    {ok, 0}.

handle_cast(increment, Counter) ->
    NewCounter = Counter + 1,
    io:format("~p~n", [NewCounter]),
    {noreply, NewCounter}.