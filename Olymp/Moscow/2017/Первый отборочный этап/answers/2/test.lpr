program test;

const
  MaxTest = 10000;
  MaxN = 1000;
  MaxK = 1000;
  MaxT = 1000;

var
  tst, n, m, k, i: longint;
  t: array[1..MaxT] of longint;

  function full_search(): longint;
  var
    mas: array[1..MaxN] of longint;
    i, j, temp: longint;
  begin
    for i := 1 to n do
      mas[i] := i;

    for i := 1 to k do
    begin
      temp := mas[t[i] mod n + 1];
      for j := t[i] mod n downto 1 do
        mas[j + 1] := mas[j];
      mas[1] := temp;
    end;

    for i := 1 to n do
      if mas[i] = m then
        exit(i);
  end;

  function optimal_search(): longint;
  var
    i, len, pos: longint;
  begin
    pos := m;
    for i := 1 to k do
    begin
      len := t[i] mod n;
      if len + 1 > pos then
        pos += 1
      else if len + 1 = pos then
        pos := 1;
    end;
    exit(pos);
  end;

begin
  randomize();
  for tst := 1 to MaxTest do
  begin
    n := random(MaxN) + 1;
    m := random(n) + 1;
    k := random(MaxK) + 1;
    for i := 1 to k do
      t[i] := random(MaxT) + 1;

    if full_search() <> optimal_search() then
      writeln('Error');
  end;
  writeln('Done');
end.

