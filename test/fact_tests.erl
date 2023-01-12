-module(fact_tests).
-include_lib("eunit/include/eunit.hrl").

fac_test_() ->
    [
    ?_assertEqual(1, factjunk_app:fac(0)),
    ?_assertEqual(1, factjunk_app:fac(1)),
    ?_assertEqual(720, factjunk_app:fac(6))
    ].

rpc_test_() ->
    Pid = factjunk_app:start(),
    [
    ?_assertEqual(fail, factjunk_app:rpc(Pid, -1)),
    ?_assertEqual(fail, factjunk_app:rpc(Pid, 1.5)),
    ?_assertEqual(1, factjunk_app:rpc(Pid, 0)),
    ?_assertEqual(1, factjunk_app:rpc(Pid, 1)),
    ?_assertEqual(720, factjunk_app:rpc(Pid, 6))
    ].