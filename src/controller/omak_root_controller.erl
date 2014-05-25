-module(omak_root_controller, [Req]).
-compile(export_all).

hello('GET', []) ->
    {output, "<strong>Hello Bitches!!!</strong>"}.