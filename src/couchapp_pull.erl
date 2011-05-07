%%% -*- erlang -*-
%%%
%%% This file is part of couchapp released under the Apache 2 license.
%%% See the NOTICE for more information.

-module(couchapp_pull).

-include("couchapp.hrl").

-export([pull/2]).

%% ====================================================================
%% Public API
%% ====================================================================

pull([Url], Config) ->
    case couchapp_util:in_couchapp(".") of
        {ok, _} ->
            case couchapp_util:parse_couchapp_url(Url) of
                {ok, Db, _AppName, DocId} ->
                    couchapp_clone:do_clone(".", DocId, Db, Config),
                    ?INFO("pull success. ~n", []);
                Error ->
                    ?ERROR("pull: ~p~n", [Error])
            end;
        _ ->
            ?ERROR("You must be inside a couchapp to couchapp pull.~n", []),
            halt(1)
    end;

pull(_Args, _Config) ->
    ?ERROR("invalid arguments. Command line should be : 'couchapp pull "
       ++ "URL'~n", []),
    halt(1).


