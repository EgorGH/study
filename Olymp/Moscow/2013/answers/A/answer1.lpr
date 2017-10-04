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
  N, i, j, x, y, ltr: integer;
  d, q: integer = 0;
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

  for i := 0 to 25 do
  begin
    for j := 0 to 25 do
      Write(T[i, j]: 6);
    writeln();
  end;

  for i := 0 to 25 do
  begin
    for j := 0 to 25 do
    begin
      if T[i, j] = False then
        q := q + 1;
    end;
    if q = 26 then
      S[i] := chr(d + 1);
  end;

  readln();
end.
