%%%-------------------------------------------------------------------
%% @doc factjunk public API
%% @end
%%%-------------------------------------------------------------------

-module(factjunk_app).
-include_lib("eunit/include/eunit.hrl").
-behaviour(application).
-export([start/2, stop/1, fac/1, rpc/2, loop/0, start/0]).

fac(0) -> 1;
fac(N) -> N * fac(N-1).

start(_StartType, _StartArgs) ->
    factjunk_sup:start_link().

start() ->
    spawn(?MODULE, loop, []).

loop() ->
    receive
        {Pid, Num} when is_integer(Num) == false; Num < 0 ->
            Pid ! {fail, -1},
            loop();
        {Pid, Num} ->
            Prod = fac(Num),
            Pid ! {ok, Prod},
            loop()
    end.

rpc(Pid, Num) ->
    Pid ! {self(), Num},
    receive
        {ok, Result} ->
            Result;
        {fail, _} ->
            fail
    end.

stop(_State) ->
    ok.
