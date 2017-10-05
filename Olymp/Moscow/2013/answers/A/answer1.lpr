program answer1;

const
  Lim = 33;
var
  w: array[1..Lim] of string = ('bwncjec', 'bwwbcc', 'bwwt', 'teuaukh',
    'toiicjqah', 'toivewkr', 'fuujlewbieuw', 'fuv', 'fjhrer', 'lebtau',
    'cxcacwi', 'cxeri', 'qbea', 'qbjfjh', 'kableuaor', 'koebjiz',
    'koeiyj', 'sbaq', 'aeqc', 'nbwoba', 'nbwoqbfiojc', 'nbis',
    'wbwuicxiojc', 'rualu', 'ruau', 'roei', 'ronn', 'rowlbh', 'rowrsewc',
    'vclwcrlbh', 'xujk', 'xjbh', 'duu');
  T: array[0..25, 0..25] of boolean;
  S: array[0..25] of char;
  N, i, j, x, y, ltr, k: integer;
  q: integer = -1;

  procedure Clear(x: integer);
  var
    i: integer;
  begin
    for i := 0 to 25 do
      if T[i, x] = True then
        T[i, x] := False;
  end;

begin
  N := 33;

  for i := 0 to 25 do
    for j := 0 to 25 do
      T[i, j] := False;

  for i := 1 to N - 1 do
    for j := i + 1 to N do
    begin
      ltr := 1;
      while w[i][ltr] = w[j][ltr] do
        ltr := ltr + 1;
      x := Ord(w[i][ltr]) - 97;
      y := Ord(w[j][ltr]) - 97;
      T[x, y] := True;
    end;

  Write('  ');
  for i := 0 to 25 do
    Write(chr(i + 97): 2);
  writeln();
  for i := 0 to 25 do
  begin
    Write(chr(i + 97): 2);
    for j := 0 to 25 do
      if T[i, j] = True then
        Write(1: 2)
      else
        Write(0: 2);
    writeln();
  end;

  for i := 0 to 25 do
  begin
    k := 0;
    for j := 0 to 25 do
      if T[i, j] = False then
        k := k + 1;
    if k = 26 then
    begin
      q := q + 1;
      S[i] := chr(q + 97);
      Clear(i);
    end;
  end;

  writeln();
  for i := 0 to 25 do
    Write(chr(i + 97), ' ');
  writeln();
  for i := 0 to 25 do
    Write(s[i], ' ');

  readln();
end.
