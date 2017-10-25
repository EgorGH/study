program test;

const
  MaxT = 1000;
  Max = 1000;

var
  t, N, q1, q2: longint;

  function full_search(N: longint): longint;
  var
    a, b, c: array of byte;
    i, j, q: longint;
  begin
    SetLength(a, N + 2);
    FillByte(a[0], N + 2, 0);
    SetLength(b, N + 2);
    FillByte(b[0], N + 2, 0);

    A[1] := 1;

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
    q, p, w: qword;
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
  randomize();
  for t := 1 to MaxT do
  begin
    N := random(Max) + 1;
    q1 := full_search(N);
    q2 := optimal_search(N);
    if q1 <> q2 then
      writeln('Error! ', N);
  end;
  writeln('All tests passed');
end.
