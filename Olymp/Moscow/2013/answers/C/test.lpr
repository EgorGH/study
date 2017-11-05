program test;

const
  MaxT = 1000;
  MaxN = 1000;

type
  tres = ^byte;

var
  t, N, q1, q2: longint;
  a, b, c: tres;

  function full_search(N: longint; a, b, c: tres): longint;
  var
    i, j, q: longint;
  begin
    a[1] := 1;

    for i := 2 to N do
    begin
      for j := 1 to N do
        if a[j - 1] + a[j + 1] = 1 then
          b[j] := 1
        else
          b[j] := 0;

      c := a;
      a := b;
      b := c;
    end;

    q := 0;
    for i := 1 to N do
      if a[i] = 1 then
        q := q + 1;

    exit(q);
  end;

  function optimal_search(N: longint): longint;
  var
    q, p, w: longint;
  begin

    p := 1;
    while p * 2 <= N do
    begin
      p := p * 2;
    end;

    q := 1;
    w := p;

    while p <> N do
    begin
      w := w div 2;
      if N > p then
      begin
        q := q * 2;
        p := p + w;
      end
      else
        p := p - w;
    end;

    exit(q);
  end;

begin
  a := GetMem((MaxN + 2) * sizeof(byte));
  b := GetMem((MaxN + 2) * sizeof(byte));
  c := GetMem((MaxN + 2) * sizeof(byte));
  randomize();

  for t := 1 to MaxT do
  begin
    FillByte(a[0], MaxN + 2, 0);
    FillByte(b[0], MaxN + 2, 0);

    N := random(MaxN) + 1;
    q1 := full_search(N, a, b, c);
    q2 := optimal_search(N);
    if q1 <> q2 then
      writeln('Error!');
  end;
  writeln('Done');
end.
