program answer_slow;

uses
  Math;

var
  n, m, i: longint;
  k: longint;

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

begin
  readln(n, m);
  for i := 1 to m do
  begin
    Read(k);
    Write(full_search(n, k), ' ');
  end;
end.
