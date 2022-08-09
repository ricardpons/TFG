-module(tcp_server).
-behaviour(gen_server).

-export([start_link/1]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2,stop/0]).
-include_lib("eunit/include/eunit.hrl").

-type name():: atom().
-record(state, {socket,temp::float(),name::name()}).






start_link(Socket) ->
  gen_server:start_link(?MODULE, Socket, []),
  ok.

init(Socket) ->
  %% Aquí se empieza a aceptar la escucha en el socket.
  
  gen_server:cast(self(), accept),
  {ok, #state{socket=Socket}}.



handle_cast(accept, State = #state{socket=ListenSocket}) ->
  {ok, AcceptSocket} = gen_tcp:accept(ListenSocket),
  tcp_sup:start_socket(),
  {noreply, State#state{socket=AcceptSocket}};
handle_cast(_, State) ->
  {noreply, State}.





handle_info({tcp, Socket, Msg}, State) ->
    
    Val=binary_to_term(Msg),

	
    Ter=Val*  32,
  
  send(Socket, term_to_binary(Ter)),
  {noreply, State};

handle_info({tcp_closed, _Socket}, State) -> {stop, normal, State};
handle_info({tcp_error, _Socket, _}, State) -> {stop, normal, State};
handle_info(E, State) ->
  io:fwrite("unexpected: ~p~n", [E]),
  {noreply, State}.

handle_call(_E, _From, State) -> {noreply, State}.
stop() ->
  gen_server:stop(?MODULE).


%% función para enviar de vuelta el mensaje al cliente.
send(Socket, Str) ->
  
  ok = inet:setopts(Socket, [binary,{active, once}]),
  ok = gen_tcp:send(Socket, term_to_binary(Str)),
  ok.


