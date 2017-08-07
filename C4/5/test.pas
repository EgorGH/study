program test;

const
  Lim = 10000;
  MaxD = 99;
  MaxK = 1000;
  MaxT = 10000;
var
  d, k: array[1..Lim] of integer;
  N, t, i: integer;

  procedure init();
  var
    i: integer;
  begin
    N := 1 + random(10);
    for i := 1 to N do
    begin
      d[i] := 1 + random(MaxD + 1);
      k[i] := D[i] + random(MaxK - D[i]);
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
      if (m[i] <> 0) and (not flag or (Count >= maxCount)) and
        (not flag or (m[i] > m_often)) then
      begin
        flag := True;
        maxCount := Count;
        m_often := m[i];
      end;
    end;

    exit(m_often);
  end;

begin
  randomize;
  readln(N);
  for i := 1 to N do
  begin
    Read(d[i]);
    readln(k[i]);
  end;
  writeln(solveA);

  readln();
end.
