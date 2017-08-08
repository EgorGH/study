program test;

const
  Lim = 10000;
  MaxD = 99;
  MaxK = 1000;
  MaxT = 100000;
var
  d, k: array[1..Lim] of integer;
  N, t: integer;

  procedure init();
  var
    i: integer;
  begin
    N := 1 + random(5);
    for i := 1 to N do
    begin
      d[i] := 1 + random(MaxD + 1);
      k[i] := d[i] + random(MaxK - d[i]);
    end;
  end;

  procedure print();
  var
    i: integer;
  begin
    writeln(N);
    for i := 1 to N do
      Write(d[i]: 4);
    writeln();
    for i := 1 to N do
      Write(k[i]: 4);
    writeln();
  end;

  function solveA(): integer;
  var
    i, j, Count, maxCount, m_often: integer;
    m: array[1..Lim] of integer;
    flag: boolean;

  begin
    flag := False;

    for i := 1 to N do
      m[i] := k[i] mod d[i];
    for i := 1 to N do
    begin
      Count := 1;
      for j := 1 to N do
        if (m[i] = m[j]) and (i <> j) then
          Count := Count + 1;
      if (not flag or (Count > maxCount) or (Count = maxCount) and
        (m[i] > m_often)) and (m[i] <> 0) then
      begin
        flag := True;
        maxCount := Count;
        m_often := m[i];
      end;
    end;

    if not flag then
      m_often := 0;

    exit(m_often);
  end;

  function solveB(): integer;
  var
    i, rem, m_often: integer;
    m: array[1..MaxD] of integer;
    flag: boolean;

  begin
    flag := False;

    for i := 1 to MaxD do
      m[i] := 0;

    for i := 1 to N do
    begin
      rem := k[i] mod d[i];
      if rem <> 0 then
        m[rem] := m[rem] + 1;
    end;

    for i := 1 to MaxD do
      if not flag or (m[i] > m[m_often]) or ((m[i] = m[m_often]) and (i > m_often)) then
      begin
        flag := True;
        m_often := i;
      end;

    if m[m_often] = 0 then
      m_often := 0;

    exit(m_often);

  end;

begin
  randomize;
  for t := 1 to maxT do
  begin
    init();
    if solveA <> solveB then
    begin
      print();
      writeln(solveA);
      writeln(solveB);
    end;
  end;
  writeln('done');

  readln();
end.
