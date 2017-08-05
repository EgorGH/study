program test;

uses
  Math;

const
  Lim = 1000;
  MaxR = 1000;
  MaxT = 100000;

type
  TMax = record
    maxA: longint;
    maxB: longint;
    fA: boolean;
    fB: boolean;
  end;

var
  a: array[1..Lim] of integer;
  N, t, i: integer;

  function update_max(a: TMax; b: longint): TMax;
  begin
    if not a.fA or (b >= a.maxA) then
    begin
      a.fB := a.fA;
      a.maxB := a.maxA;
      a.fA := True;
      a.maxA := b;
    end
    else if not a.fB or (b >= a.maxB) then
    begin
      a.fB := True;
      a.maxB := B;
    end;
    exit(a);
  end;

  procedure init();
  var
    i: integer;
  begin
    N := 2 + random(14);
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

  function solveA(): longint;
  var
    prod, i, j: longint;
    mul_14: TMax;
  begin
    mul_14.fA := False;

    for i := 1 to N - 1 do
      for j := i + 1 to N do
      begin
        prod := a[i] * a[j];
        if (prod mod 14 = 0) then
          mul_14 := update_max(mul_14, prod);
      end;

    if mul_14.fA then
      exit(mul_14.maxA)
    else
      exit(0);
  end;

  function solveB(): longint;
  var
    m7, m2, m14, m: Tmax;
    mM: integer;
    mul_1, mul_2: longint;

  begin
    m7.fA := False;
    m2.fA := False;
    m14.fA := False;
    m.fA := False;
    m.fB := False;

    for i := 1 to N do
    begin
      if (a[i] mod 7 = 0) and (a[i] mod 2 <> 0) then
        m7 := update_max(m7, a[i]);
      if (a[i] mod 2 = 0) and (a[i] mod 7 <> 0) then
        m2 := update_max(m2, a[i]);
      if a[i] mod 14 = 0 then
        m14 := update_max(m14, a[i]);
      m := update_max(m, a[i]);
    end;

    if m14.maxA = m.maxA then
      mM := m.maxB
    else
      mM := m.maxA;

    mul_1 := m2.maxA * m7.maxA;
    mul_2 := m14.maxA * mM;

    if m14.fA and m7.fA and m2.fA then
      exit(max(mul_1, mul_2))
    else if m14.fA then
      exit(mul_2)
    else if m2.fA and m7.fA then
      exit(mul_1)
    else
      exit(0);

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
