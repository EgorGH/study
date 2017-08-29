program test;

const
  Lim = 10000;
  MaxR = 10;
  MaxT = 100000;

var
  a: array[1..Lim] of longword;
  N, t: longword;

  procedure init();
  var
    i: integer;
  begin
    N := 1 + random(10);
    for i := 1 to N - 1 do
      a[i] := 1 + random(MaxR + 1);
    a[N] := 0;
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

  function solveA(): longword;
  var
    i, j, q, max: longword;
    found: boolean;
  begin
    found := False;
    i := 0;

    repeat
      i := i + 1;
    until a[i] = 0;

    q := i;

    for i := 1 to q - 1 do
      for j := i to q do
        if (a[i] * a[j] mod 7 = 0) and (a[i] * a[j] mod 49 <> 0) and
          ((a[i] * a[j] > max) or not found) then
        begin
          found := True;
          max := a[i] * a[j];
        end;

    if found then
      exit(max)
    else
      exit(1);
  end;

  function solveB(): longword;
  var
    i, maxA, maxB: longword;
    fA, fB: boolean;
  begin
    i := 0;
    fA := False;
    fB := False;

    repeat
      i := i + 1;
      if (a[i] mod 7 = 0) and (a[i] mod 49 <> 0) and ((a[i] > maxA) or not fA) then
      begin
        fA := True;
        maxA := a[i];
      end;
      if (a[i] mod 7 <> 0) and ((a[i] > maxB) or not fB) then
      begin
        fB := True;
        maxB := a[i];
      end;
    until a[i] = 0;

    if fA and fB then
      exit(maxA * maxB)
    else
      exit(1);
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
  writeln('Done..');
  readln();
end.
