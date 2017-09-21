program test;

const
  MaxR = 10000;
  MaxT = 100000;
  Lim = 1000;
var
  a: array[1..Lim] of longword;
  N, t: longword;

  procedure init();
  var
    i: longword;
  begin
    N := 1 + random(100);
    for i := 1 to N do
      a[i] := random(MaxR + 1);
  end;

  procedure print();
  var
    i: longword;
  begin
    writeln(N);
    for i := 1 to N do
      Write(a[i], ' ');
    writeln();
  end;

  function solveA(): longword;
  var
    q, i, j: longword;
  begin
    q := 0;

    for i := 1 to N - 1 do
      for j := i + 1 to N do
        if a[i] * a[j] mod 26 = 0 then
          q := q + 1;

    exit(q);
  end;

  function solveB(): longword;
  var
    q26, q2, q13, s1, s2, i: longword;
  begin
    q26 := 0;
    q2 := 0;
    q13 := 0;
    s1 := 0;
    s2 := 0;

    for i := 1 to N do
    begin
      if a[i] mod 26 = 0 then
        q26 := q26 + 1;

      if (a[i] mod 13 = 0) and (a[i] mod 2 <> 0) then
        q13 := q13 + 1;

      if (a[i] mod 2 = 0) and (a[i] mod 13 <> 0) then
        q2 := q2 + 1;
    end;

    s1 := round(q26 * (2*N - q26 - 1) / 2);
    s2 := q2 * q13;

    exit(s1 + s2);
  end;

begin
  randomize;
  for t := 1 to MaxT do
  begin
    init();
    if solveA() <> solveB() then
    begin
      print();
      writeln(solveA());
      writeln(solveB());
    end;
  end;
  writeln('Done');
  readln();
end.
