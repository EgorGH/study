program answer;

uses
  Math;

const
  Lim = 18;

type
  ttable = array of array of longint;

var
  i, m, n, k: longint;
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

  procedure fill_table(var table: ttable);
  var
    i, j, p: longint;
  begin
    for i := 1 to Lim do
      for j := 1 to (Lim - 1) * 9 do
        table[i, j] := 0;

    for i := 1 to 9 do
      table[1, i] := 1;

    for i := 2 to Lim do
      for j := 1 to (Lim - 1) * 9 do
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
  SetLength(table, Lim + 1, (Lim - 1) * 9 + 1);
  fill_table(table);

  readln(n, m);

  for i := 1 to m do
  begin
    Read(k);
    Write(optimal_search(table, n, k), ' ');
  end;
end.
