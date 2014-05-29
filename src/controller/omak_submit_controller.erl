-module(omak_submit_controller, [Req]).
-compile(export_all).

email('POST', []) ->
	Email = Req:post_param("email"),
	NewEmail = emails:new(id, Email),
	{ok, SavedEmail} = NewEmail:save(),
	ssl:start(),
	application:start(email),
	email:send({<<"User Email">>, Email},{<<"Omak Registration Team">>, <<"register@omak.com">>},<<"Registration">>, <<"Please Complete Your registration at OMAK">>),
	{json, [{success, true}]}.