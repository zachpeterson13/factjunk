%%%-------------------------------------------------------------------
%% @doc factjunk public API
%% @end
%%%-------------------------------------------------------------------

-module(factjunk_app).
-include_lib("eunit/include/eunit.hrl").
-behaviour(application).
-export([start/2, stop/1, fac/1]).

fac(0) -> 1;
fac(1) -> 1;
fac(N) -> N * fac(N-1).

start(_StartType, _StartArgs) ->
    factjunk_sup:start_link().

stop(_State) ->
    ok.

-ifdef(EUNIT).
fac_test_() ->
    [?_assertEqual(fac(0), 1),
    ?_assertEqual(fac(1), 1)
    ].
-endif.
