-module(omak_email_controller, [Req]).
-compile(export_all).

submit('POST', []) ->
  Email = Req:post_param("email"),
  IndexOfAuc = string:str(Email, "@aucegypt.edu"),
  if IndexOfAuc > 0 ->
      ValidationKey = http_uri:encode(base64:encode_to_string
      (crypto:strong_rand_bytes(10))),
      Now = calendar:local_time(),
      ssl:start(),
      NewEmail = pending_emails:new(id, Email, ValidationKey, Now),
      {ok, SavedEmail} = NewEmail:save(),
      application:start(email),
      email:send(
        {<<"User Email">>, Email},
        {<<"Omak Registration Team">>, <<"register@omak.com">>},
        <<"Registration">>,
        "Please Complete Your registration at OMAK, please validate your email by visiting the following link: localhost:8001/#/validateEmail/" ++ ValidationKey
      ),
      {json, [{success, true}]};
    true ->
      {json, [{success, false}]}
  end.
validate('GET', [ValidationId]) ->
  ssl:start(),
  Record = boss_db:find(pending_emails, [{validation_id,
    http_uri:encode(ValidationId)}]),
  {json, [{value, Record}]}.
insertEmail('POST', []) ->
  ssl:start(),
  ValidationId = Req:post_param("validation_id"),
  Email = Req:post_param("email"),
  Record = boss_db:find(pending_emails, [{validation_id, ValidationId}, {email,
    Email}]),
%  try
  Time = element(5, lists:nth(1, Record)),
  io:format(calendar:time_difference(Time, calendar:local_time())),
  TimeDiff = calendar:time_difference(Time, calendar:local_time()),
  Days = element(1, TimeDiff),
  io:format(Days),
  Seconds = calendar:time_to_seconds(element(2, TimeDiff)),
  io:format(Seconds),
  Prop = (Days =:= 0) and (Seconds < 7200),
  if Prop ->
      {json, [{success, true}]};
    true ->
      boss_db:delete(element(2, lists:nth(1, Record))),
      {json, [{success, false}, {reason, "Expired Validation Code. Please
      Send Your Email Again"}]}
  end.
%  catch
 %   error:function_clause -> {json, [{success, false}, {reason,
  %    "Invalid Validation Code or Email. Please
   %     Send Your Email Again"}]}
 % end.