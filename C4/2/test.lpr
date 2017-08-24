program test;

const
  Lim = 10000;
  Max = 30000;
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
    N := 10 + random(6);
    for i := 1 to N do
      a[i] := random(Max + 1);
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
    sum: longint;
    even, odd: TMin;
  begin
    even.fA := False;
    odd.fA := False;
    for i := 1 to N - 1 do
      for j := i + 1 to N do
      begin
        sum:=A[i] + A[j];
        if (sum mod 2 = 0) then
          even := update_min(even, sum)
        else
          odd := update_min(odd, sum);
      end;

    if even.fA then
      exit(even.minA)
    else
      exit(odd.minA);
  end;

  function solveB(): longint;
  var
    i, v: integer;
    even, odd: TMin;
    sum: longint;
  begin
    even.fA := False;
    even.fB := False;
    odd.fA := False;
    odd.fB := False;

    if N = 2 then
      exit(a[1] + a[2]);

    for i := 1 to N do
      if a[i] mod 2 = 0 then
        even := update_min(even, a[i])
      else
        odd := update_min(odd, a[i]);

    if not even.fB then
      exit(odd.minA + odd.minB)
    else if not odd.fB then
      exit(even.minA + even.minB)
    else if even.minA + even.minB < odd.minA + odd.minB then
      exit(even.minA + even.minB)
    else
      exit(odd.minA + odd.minB);
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
