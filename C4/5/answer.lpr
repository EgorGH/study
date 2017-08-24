program answer;

const
  MaxD = 99;

var
  i, rem, max, m_often, res, k, d, N: integer;
  m: array[0..MaxD] of integer;
  found: boolean;
begin
  found := False;

  for i := 1 to MaxD do
    m[i] := 0;

  readln(N);

  for i := 1 to N do
  begin
    Read(d);
    readln(k);
    rem := k mod d;
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
    res := 0
  else
    res := m_often;

  writeln(res);

  readln();
end.
