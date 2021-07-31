-module(cliente_server).
-behaviour(gen_server).
-export([start_link/0, temp/1, get_cont/0]).
-export([init/1, handle_call/3, handle_cast/2, terminate/2]).
-define(concuerror_options, [{module, ?MODULE}, quiet]).
-record(estado, {cont::integer()}).


%% Client API
start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, {}, []).

temp(Num) ->
    Ges= string:to_float(Num),
    gen_server:cast(?MODULE, {temp, Ges}).



get_cont() ->
    gen_server:call(?MODULE, {get_cont}).

%% Server functions
init({}) ->
    {ok, #estado{cont=0}}.

handle_cast({temp, Ges}, #estado{cont = Cont} = Estado) ->
    Cels = Ges*  9 / 5 + 32,
    Ger=float_to_list(Cels,[{decimals,2}]),
    io:format("La temperatura en grados Fahrenheit es ~s!~n",[Ger]),
    {noreply, Estado#estado{cont = Cont }};

handle_cast(Msg, Estado) ->
    error_logger:warning_msg("Bad message: ~p~n", [Msg]),
    {noreply, Estado}.


handle_call(Request, _From, Estado) ->
    error_logger:warning_msg("Bad message: ~p~n", [Request]),
    {reply, {error, unknown_call}, Estado}.



terminate(_Reason, _Estado) ->
    ok.
 
