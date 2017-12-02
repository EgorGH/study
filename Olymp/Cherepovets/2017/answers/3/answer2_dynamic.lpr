program answer2_dynamic;

uses
  Math;

const
  Lim = 18;

type
  ttable = array[0..Lim, 0..Lim * 9, 0..1] of int64;
var
  i, m, n: longint;
  k: int64;
  table: ttable;

  function dsum(x: int64): longint;
  begin
    dsum := 0;
    while x > 0 do
    begin
      dsum += x mod 10;
      x := x div 10;
    end;
  end;

  function dq(x: int64): longint;
  begin
    dq := 0;
    while x > 0 do
    begin
      dq += 1;
      x := x div 10;
    end;
  end;

  procedure fill_table(var table: ttable);
  var
    i, j, k, p: longint;
  begin
    for i := 0 to Lim do
      for j := 0 to Lim * 9 do
        for k := 0 to 1 do
          table[i, j, k] := 0;

    for i := 0 to 9 do
      for j := 0 to 1 do
        table[1, i, j] := 1;

    for i := 10 to Lim * 9 do
      for j := 0 to 1 do
        table[1, i, j] := 0;

    for i := 0 to Lim do
      for j := 0 to 1 do
        table[i, 0, j] := 1;

    for i := 2 to Lim do
      for j := 1 to Lim * 9 do
        for k := 0 to 1 do
          for p := 1 - k to min(j, 9) do
            table[i, j, k] += table[i - 1, j - p, 1];
  end;

  function optimal_search(var table: ttable; n: longint; k: int64): int64;
  var
    i, j, kdsum, kdq: longint;
    q: int64;
  begin
    q := 0;
    kdsum := dsum(k);
    kdq := dq(k);
    if kdsum > 1 then
      q := q + 1;

    for i := kdq + 1 to n do
      for j := 1 to kdsum - 1 do
        q := q + table[i, j, 0];

    exit(q);
  end;

begin
  fill_table(table);

  readln(n, m);

  for i := 1 to m do
  begin
    Read(k);
    Write(optimal_search(table, n, k), ' ');
  end;
end.

