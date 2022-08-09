-module(cliente).
-export([client/0]).
-include_lib("proper/include/proper.hrl").
-include_lib("eunit/include/eunit.hrl").

client() ->
         
         {ok,Socket} = gen_tcp:connect("localhost",8094,[binary,{active,true}]),
         
         {ok, Temp} = io:read("Inserte la  temperatura a convertir: "),
         %Bing=term_to_binary(Temp),
         ok= gen_tcp:send(Socket, term_to_binary(Temp)),
         receive
                   {tcp,Socket,Bin}->
                            %io:format("Respuesta del servidor  = ~p~n",[Bin]),
                            Val=binary_to_term(Bin),
                            io:format("Respuesta del servidor  = ~p~n",[Val]),
                            gen_tcp:close(Socket)
                            %client()
         end.


socket_test()->
    {ok,_}=gen_tcp:connect("localhost",8094,[binary,{active,true}]).

sock_test()->
    {ok,_}=gen_tcp:connect("localhost",5000,[binary,{active,true}]).


