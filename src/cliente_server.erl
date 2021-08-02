-module(cliente_server).
-behaviour(gen_server).
-export([start_link/0, temp/1, get_cont/0]).
-export([init/1, handle_call/3, handle_cast/2, terminate/2,mayor/1]).
-include_lib("proper/include/proper.hrl").
-include_lib("eunit/include/eunit.hrl").
-define(concuerror_options, [{module, ?MODULE}, quiet]).
-record(estado, {cont}).


%% Client API
start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, {}, []).

temp(Num) ->
    gen_server:cast(?MODULE, {temp, Num}).



get_cont() ->
    gen_server:call(?MODULE, {get_cont}).

%% Server functions
init({}) ->
    { ok,#estado{cont=0.0}}.

handle_cast({temp, Num}, #estado{cont = Cont} = Estado) ->
    Cels = Num*  9 / 5 + 32,
    Ger=float_to_list(Cels,[{decimals,2}]),
    io:format("La temperatura en grados Fahrenheit es ~s!~n",[Ger]),
    {noreply, Estado#estado{cont =Ger }};

handle_cast(Msg, Estado) ->
    error_logger:warning_msg("Bad message: ~p~n", [Msg]),
    {noreply, Estado}.

handle_call({get_cont},_From,Estado) ->
    {reply,{ok,Estado#estado.cont},Estado};

handle_call(Request, _From, Estado) ->
    error_logger:warning_msg("Bad message: ~p~n", [Request]),
    {reply, {error, unknown_call}, Estado}.



terminate(_Reason, _Estado) ->
    ok.
 
 cels_test() ->
     ?assertEqual({noreply,9.0},handle_cast({temp,36.5},90.70)).
  new_test() ->
    ?assertEqual({noreply,90.70},handle_cast({temp,36.5},90.70)).
  new1_test() ->
    ?assertEqual({noreply,k},handle_cast({temp,36.5},90.70)).

prop_cliente() ->
    ?FORALL(T, float(),mayor(T)).

mayor(T) ->
    T >=-273.15.


