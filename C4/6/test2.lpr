program test2;

const
  Lim = 10000;
  MaxR = 1000;
  MaxT = 100000;
  M = 4;

var
  a: array[1..Lim] of integer;
  N, t: integer;

  procedure init();
  var
    i: integer;
  begin
    N := M + 1 + random(5);
    for i := 1 to N do
      a[i] := random(MaxR + 1);
  end;

  procedure print();
  var
    i: integer;
  begin
    writeln(N);
    for i := 1 to N do
      Write(a[i], ' ');
    writeln();
  end;

  function solveA(): integer;
  var
    i, j, min: integer;
  begin
    min := a[1] + a[M + 1];

    for i := 1 to N - M do
      for j := i + M to N do
        if a[i] + a[j] < min then
          min := a[i] + a[j];

    exit(min);
  end;

  function solveB(): integer;
  var
    i, min_sum, min_left: integer;
    w: array[0..M - 1] of integer;
  begin
    min_sum := a[1] + a[M + 1];
    min_left := a[1];

    for i := 1 to M do
      w[i mod M] := a[i];

    for i := M + 1 to N do
    begin
      if w[i mod M] < min_left then
        min_left := w[i mod M];

      if min_left + a[i] < min_sum then
        min_sum := min_left + a[i];

      w[i mod M] := a[i];
    end;

    exit(min_sum);
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
  writeln('Done!!');
  readln();
end.
