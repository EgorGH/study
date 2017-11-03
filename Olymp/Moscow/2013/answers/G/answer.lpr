program answer;

var
  N: longint;
  SecretKeeper, Finder: longint;

  procedure print_episode(event, a, b: longint);
  begin
    Write('Character ', a, ' finds out ');
    case event of
      0: Write('the secret.');
      1: Write('that character ', b, ' does not know the secret.');
      2: Write('that character ', b, ' knows the secret.');
    end;
    writeln();
  end;

begin
  readln(N);
  for SecretKeeper := 1 to N do
  begin
    print_episode(0, SecretKeeper, 0);

    if SecretKeeper = N then
      print_episode(2, 1, SecretKeeper)
    else
      for Finder := 1 to N do
      begin
        if Finder = SecretKeeper then
          print_episode(2, Finder + 1, Finder)
        else if Finder = SecretKeeper + 1 then
          print_episode(1, SecretKeeper, Finder)
        else
        begin
          print_episode(2, Finder, SecretKeeper);
          print_episode(1, Finder, SecretKeeper + 1);
        end;
      end;
  end;
  writeln('The end. No secret now!');
end.
