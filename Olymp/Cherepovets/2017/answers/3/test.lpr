program test;

uses
  Math;

const
  MaxT = 100;
  MaxN = 5;

var
  t, n, k: longint;

  function dsum(x: longint): longint;
  begin
    dsum := 0;
    while x > 0 do
    begin
      dsum += x mod 10;
      x := x div 10;
    end;
  end;

  function full_search(n, k: longint): longint;
  var
    kdsum, a, b, i: longint;
    q: longint = 0;
  begin
    kdsum := dsum(k);
    a := round(power(10, ceil(log10(k))));
    b := round(power(10, n));

    for i := a to b do
    begin
      if dsum(i) < kdsum then
        q += 1;
    end;

    exit(q);
  end;

  function optimal_search(n, k: longint): longint;
  begin

  end;

begin
  randomize;
  for t := 1 to MaxT do
  begin
    n := random(MaxN) + 1;
    k := random(round(power(10, n))) + 1;
    if full_search(n, k) <> optimal_search(n, k) then
      writeln('Error');
  end;
  writeln('Done');
  readln();
end.