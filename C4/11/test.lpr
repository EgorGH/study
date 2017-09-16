program test;

uses
  Math;

const
  Lim = 1000;
  MaxR = 1000;
  MaxT = 100000;
type
  TMax = record
    maxA: longword;
    maxB: longword;
    fA: boolean;
    fB: boolean;
  end;
var
  a: array[1..Lim] of longword;
  N, t, i: longword;

  function update_max(a: TMax; b: longword): TMax;
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
    i: longword;
  begin
    N := 2 + random(10);
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
    m26: TMax;
    prod, i, j: longword;
  begin
    m26.fA := False;

    for i := 1 to N - 1 do
      for j := i + 1 to N do
      begin
        prod := a[i] * a[j];
        if (prod mod 26 = 0) then
          m26 := update_max(m26, prod);
      end;

    if m26.fA then
      exit(m26.maxA)
    else
      exit(0);
  end;

  function solveB(): longword;
  var
    m13, m2, m26, m: TMax;
    mMax, prod1, prod2: longword;

  begin
    m13.fA := False;
    m2.fA := False;
    m26.fA := False;
    m.fA := False;
    m.fB := False;

    for i := 1 to N do
    begin
      if (a[i] mod 13 = 0) and (a[i] mod 2 <> 0) then
        m13 := update_max(m13, a[i]);

      if (a[i] mod 2 = 0) and (a[i] mod 13 <> 0) then
        m2 := update_max(m2, a[i]);

      if a[i] mod 26 = 0 then
        m26 := update_max(m26, a[i]);

      m := update_max(m, a[i]);
    end;

    if m26.maxA = m.maxA then
      mMax := m.maxB
    else
      mMax := m.maxA;

    prod1 := m2.maxA * m13.maxA;
    prod2 := m26.maxA * mMax;

    if m26.fA and m13.fA and m2.fA then
      exit(max(prod1, prod2))
    else if m2.fA and m13.fA then
      exit(prod1)
    else if m26.fA then
      exit(prod2)
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
  writeln('Done!');
  readln();
end.   m2 := update_max(m2, a[i]);

      if a[i] mod 26 = 0 then
        m26 := update_max(m26, a[i]);

      m := update_max(m, a[i]);
    end;

    if m26.maxA = m.maxA then
      mMax := m.maxB
    else
      mMax := m.maxA;

    prod1 := m2.maxA * m13.maxA;
    prod2 := m26.maxA * mMax;

    if m26.fA and m13.fA and m2.fA then
      exit(max(prod1, prod2))
    else if m2.fA and m13.fA then
      exit(prod1)
    else if m26.fA then
      exit(prod2)
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
  writeln('Done!');
  readln();
end.
