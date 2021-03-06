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

  procedure sort(var m: array of integer);
  var
    i, j, imin, temp: integer;
  begin
    for i := 1 to N - 1 do
    begin
      imin := i;
      for j := i + 1 to N do
        if m[j] < m[imin] then
          imin := j;
      temp := m[imin];
      m[imin] := m[i];
      m[i] := temp;
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
    i, q, max, m_often: integer;
    m: array[1..Lim] of integer;
    found: boolean;

  begin
    found := False;
    q := 1;
    max := 1;

    for i := 1 to N do
      m[i] := k[i] mod d[i];

    sort(m);

    m_often := m[1];

    for i := 1 to N - 1 do   // нахождение одинаковых элементов (не равных 0)
      if (m[i] = m[i + 1]) and (m[i] <> 0) then
      begin
        found := True;
        q := q + 1;
        if q >= max then
        begin
          max := q;
          m_often := m[i + 1];
        end;
      end
      else
      begin
        q := 1;
        if not found then
          m_often := m[i + 1];
      end;

    exit(m_often);
  end;

  function solveB(): integer;
  var
    i, rem, max, m_often: integer;
    m: array[0..MaxD] of integer;
    found: boolean;
  begin
    found := False;

    for i := 1 to MaxD do
      m[i] := 0;

    for i := 1 to N do
    begin
      rem := k[i] mod d[i];
      m[rem] := m[rem] + 1;
    end;

    max := 1;

    for i := 1 to MaxD do
      if m[i] >= max then
      begin
        found := True;
        max := m[i];
        m_often := i;
      end;

    if not found then
      exit(0)
    else
      exit(m_often);
  end;

begin
  randomize;
  for t := 1 to maxT do
  begin
    init();
    if solveA() <> solveB() then
    begin
      print();
      writeln(solveA());
      writeln(solveB());
    end;
  end;
  writeln('Done.');
  readln();
end.
