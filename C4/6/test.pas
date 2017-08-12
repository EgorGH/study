program test;

const
  Lim = 10000;
  MaxR = 1000;
  MaxT = 10000;

type
  TMin = record
    minA: longint;
    minB: longint;
    fA: boolean;
    fB: boolean;
  end;

var
  a: array[1..Lim] of integer;
  N, t: integer;

  function update_min(a: TMin; b: longint): TMin;
  begin
    if not a.fA or (b <= a.minA) then
    begin
      a.fB := a.fA;
      a.minB := a.minA;
      a.fA := True;
      a.minA := b;
    end
    else if not a.fB or (b <= a.minB) then
    begin
      a.fB := True;
      a.minB := B;
    end;
    exit(a);
  end;

  procedure init();
  var
    i: integer;
  begin
    randomize;
    N := 5 + random(10);
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
    i, j: integer;
    res: TMin;
  begin
    for i := 1 to N - 4 do
      for j := i + 4 to N do
        res := update_min(res, a[i] + a[j]);

    exit(res.minA);
  end;

  function solveB(): longint;
  var i:integer; min1,min2:TMin;
  begin
    i := 0;
    min1.fA := False;
    min1.fB := False;
    min2.fA := False;
    min2.fB := False;


  end;

begin
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
