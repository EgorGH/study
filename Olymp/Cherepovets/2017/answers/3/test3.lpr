program test3;

uses
  Math;

const
  MaxN = 5;
  Lim = 18;

type
  ttable = array[1..Lim, 1..Lim * 9] of longint;

var
  n, k: longint;
  table: ttable;

  function dsum(x: longint): longint;
  begin
    dsum := 0;
    while x > 0 do
    begin
      dsum += x mod 10;
      x := x div 10;
    end;
  end;

  function dq(x: longint): longint;
  begin
    dq := 0;
    while x > 0 do
    begin
      dq += 1;
      x := x div 10;
    end;
  end;

  function power_10(x: longint): longint;
  begin
    power_10 := 1;
    while x > 0 do
    begin
      power_10 *= 10;
      x -= 1;
    end;
  end;

  function full_search(n, k: longint): longint;
  var
    kdsum, kdq, a, b, i: longint;
    q: longint = 0;
  begin
    kdsum := dsum(k);
    kdq := dq(k);
    a := power_10(kdq);
    b := power_10(n);

    for i := a to b do
    begin
      if dsum(i) < kdsum then
        q += 1;
    end;

    exit(q);
  end;

  procedure fill_table(var table: ttable);
  var
    i, j, p: longint;
  begin
    for i := 1 to Lim do
      for j := 1 to Lim  * 9 do
        table[i, j] := 0;

    for i := 1 to 9 do
      table[1, i] := 1;

    for i := 2 to Lim do
      for j := 1 to Lim * 9 do
        for p := 0 to min(j - 1, 9) do
          table[i, j] := table[i, j] + table[i - 1, j - p];
  end;

  function optimal_search(var table: ttable; n, k: longint): longint;
  var
    i, j, kdsum, kdq, q: longint;
  begin
    q := 0;
    kdsum := dsum(k);
    kdq := dq(k);
    if kdsum > 1 then
      q := q + 1;

    for i := kdq + 1 to n do
      for j := 1 to kdsum - 1 do
        q := q + table[i, j];

    exit(q);
  end;

begin
  fill_table(table);

  randomize;
  for n := 1 to MaxN do
    for k := 1 to power_10(n) do
    begin
      if full_search(n, k) <> optimal_search(table, n, k) then
        writeln('Error');
    end;
  writeln('Done');
end.

