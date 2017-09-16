program answer;

uses
  Math;

type
  TMax = record
    maxA: longword;
    maxB: longword;
    fA: boolean;
    fB: boolean;
  end;
var
  m13, m2, m26, m: TMax;
  N, i, a, control, res, mMax, prod1, prod2: longword;

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

begin
  m13.fA := False;
  m2.fA := False;
  m26.fA := False;
  m.fA := False;
  m.fB := False;

  readln(N);

  for i := 1 to N do
  begin
    readln(a);

    if (a mod 13 = 0) and (a mod 2 <> 0) then
      m13 := update_max(m13, a);

    if (a mod 2 = 0) and (a mod 13 <> 0) then
      m2 := update_max(m2, a);

    if a mod 26 = 0 then
      m26 := update_max(m26, a);

    m := update_max(m, a);
  end;

  if m26.maxA = m.maxA then
    mMax := m.maxB
  else
    mMax := m.maxA;

  prod1 := m2.maxA * m13.maxA;
  prod2 := m26.maxA * mMax;

  if m26.fA and m13.fA and m2.fA then
    res := max(prod1, prod2)
  else if m2.fA and m13.fA then
    res := prod1
  else if m26.fA then
    res := prod2
  else
    res := 0;

  readln(control);

  writeln('Calculated control number: ', res);

  if res = control then
    writeln('Control passed')
  else
    writeln('Control did not pass');

  readln();
end.
