program test;

const
  MaxT = 10000;
  Lim = 200000;

var
  a, b, c: longint;
  t: longint;

  function full_search(a, b, c: longint): longint;
  var
    i: longint;
  begin
    full_search := 0;
    for i := a to b do
      if i mod c = 0 then
        full_search += 1;
  end;

  function optimal_search(a, b, c: longint): longint;
  var
    i, q: longint;
  begin
    q := 0;

    i := a;
    while (i mod c <> 0) and (i <= b) do
      i += 1;

    while (i <= b) do
    begin
      i += c;
      q += 1;
    end;

    exit(q);
  end;

begin
  randomize;
  for t := 1 to MaxT do
  begin
    b := random(Lim) + 1;
    a := random(b) + 1;
    c := random(Lim) + 1;

    if full_search(a, b, c) <> optimal_search(a, b, c) then
      writeln('Error');
  end;
  writeln('Done');
end.
