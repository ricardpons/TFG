-module(tcp_sup).
-behaviour(supervisor).

-export([start_link/0, start_socket/0]).
-export([init/1]).
-include_lib("proper/include/proper.hrl").
-include_lib("eunit/include/eunit.hrl").


start_link() ->
  supervisor:start_link({local, ?MODULE}, ?MODULE, []),
  ok.

init([]) ->
  
  {ok, ListenSocket} = gen_tcp:listen(8067, [binary,{active,true},{packet,4}]),

  spawn_link(fun empty_listeners/0),
  {ok, { {simple_one_for_one, 60, 3600},
         [
          {tcp_server, {tcp_server, start_link, [ListenSocket]}, permanent, 10000, worker, [tcp_server]}
         ]
       } }.

start_socket() ->
  supervisor:start_child(?MODULE, []),
  ok.


% Se inicializa el supervisor con 10 instancias del servidor
empty_listeners() ->
  [start_socket() || _ <- lists:seq(1,10)],
  ok.


tcp_sup_test()->
  [sup()].
sup() ->
  [?_assertEqual(ok,start_link()),
    ?_assertEqual(ok,start_socket())].


  


