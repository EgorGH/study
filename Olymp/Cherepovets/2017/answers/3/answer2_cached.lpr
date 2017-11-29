program answer2_cached;

uses
  Math;

const
  Lim = 18;

type
  ttable = array[0..Lim, 0..Lim * 9, 0..1] of longint;
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

  function quantity(a, b: longint; zero: byte): longint;
  var
    i: longint;
  begin
    if table[a, b, zero] <> -1 then
      exit(table[a, b, zero]);

    quantity := 0;

    if a = 1 then
      if b >= 10 then
      begin
        table[a, b, zero] := 0;
        exit(0);
      end
      else
      begin
        table[a, b, zero] := 1;
        exit(1);
      end;
    if b = 0 then
    begin
      table[a, b, zero] := 1;
      exit(1);
    end;

    for i := 1 - zero to min(b, 9) do
    begin
      quantity := quantity + quantity(a - 1, b - i, 1);
      table[a, b, zero] := quantity;
    end;
  end;

  procedure fill_table(var table: ttable);
  var
    i, j: longint;
  begin
    for i := 0 to Lim do
      for j := 0 to Lim * 9 do
      begin
        table[i, j, 0] := -1;
        table[i, j, 1] := -1;
      end;

    for i := 2 to Lim do
      for j := 1 to Lim * 9 do
        table[i, j, 0] := quantity(i, j, 0);
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

