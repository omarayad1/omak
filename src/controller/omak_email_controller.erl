-module(omak_email_controller, [Req]).
-compile(export_all).

submit('POST', []) ->
	Email = Req:post_param("email"),
	IndexOfAuc = string:str(Email, "@aucegypt.edu"),
	if IndexOfAuc > 0 ->
			ValidationKey = base64:encode_to_string(crypto:strong_rand_bytes(10)),
			NewEmail = emails:new(id, Email, ValidationKey),
			{ok, SavedEmail} = NewEmail:save(),
			ssl:start(),
			application:start(email),
			email:send(
				{<<"User Email">>, Email},
				{<<"Omak Registration Team">>, <<"register@omak.com">>},
				<<"Registration">>,
				"Please Complete Your registration at OMAK, your validation key is: " ++ ValidationKey
				),
			{json, [{success, true}]};
		true ->
			{json, [{success, false}]}
	end.
validate('GET', [ValidationId]) ->
	Record = boss_db:find(emails, [{validation_id, ValidationId}]),
	{json, [{value, Record}]}.