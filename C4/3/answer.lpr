program answer;

uses
  Math;

type
  TMax = record
    maxA: longint;
    maxB: longint;
    fA: boolean;
    fB: boolean;
  end;

var
  N, R, i, mM, a: integer;
  Res, mul_1, mul_2: longint;
  m7, m2, m14, m: Tmax;

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

begin
  m7.fA := False;
  m2.fA := False;
  m14.fA := False;
  m.fA := False;
  m.fB := False;

  readln(N);

  for i := 1 to N do
  begin
    readln(a);
    if (a mod 7 = 0) and (a mod 2 <> 0) then
      m7 := update_max(m7, a);
    if (a mod 2 = 0) and (a mod 7 <> 0) then
      m2 := update_max(m2, a);
    if a mod 14 = 0 then
      m14 := update_max(m14, a);
    m := update_max(m, a);
  end;

  if m14.maxA = m.maxA then
    mM := m.maxB
  else
    mM := m.maxA;

  mul_1 := m2.maxA * m7.maxA;
  mul_2 := m14.maxA * mM;

  if m14.fA and m7.fA and m2.fA then
    Res := max(mul_1, mul_2)
  else if m14.fA then
    Res := mul_2
  else if m2.fA and m7.fA and (m2.maxA <> m7.maxA) then
    Res := mul_1
  else
    Res := 0;

  Read(R);

  writeln('Вычисленное контрольное значение: ', R);

  if R = Res then
    Write('Контроль пройден')
  else
    Write('Контроль не пройден');

  readln();
end.
