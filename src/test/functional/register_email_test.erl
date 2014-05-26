-module(register_email_test).
-compile(export_all).

start() ->
	boss_web_test:get_request("/", [], 
		[ fun boss_assert:http_ok/1,
			fun(Res) -> boss_assert:tag_with_text("strong","Hello Bitches!!!", Res) end ], []).
