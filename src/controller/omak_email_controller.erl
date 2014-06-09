-module(omak_email_controller, [Req]).
-compile(export_all).

submit('POST', []) ->
	Email = Req:post_param("email"),
	IndexOfAuc = string:str(Email, "@aucegypt.edu"),
	if IndexOfAuc > 0 ->
			ValidationKey = base64:encode_to_string(crypto:strong_rand_bytes(10)),
			Now = erlang:now(),
			ssl:start(),
			NewEmail = pending_emails:new(id, Email, ValidationKey, Now),
			{ok, SavedEmail} = NewEmail:save(),
			application:start(email),
			email:send(
				{<<"User Email">>, Email},
				{<<"Omak Registration Team">>, <<"register@omak.com">>},
				<<"Registration">>,
				"Please Complete Your registration at OMAK, please validate your email by visiting the following link: localhost:8001/#/validateEmail/" ++ edoc_lib:escape_uri(ValidationKey)
				),
			{json, [{success, true}]};
		true ->
			{json, [{success, false}]}
	end.
validate('GET', [ValidationId]) ->
	ssl:start(),
	Record = boss_db:find(pending_emails, [{validation_id, ValidationId}]),
	io:format(Record),
	{json, [{value, Record}]}.