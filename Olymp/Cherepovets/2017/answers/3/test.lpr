program test;

uses
  Math;

const
  MaxT = 1000;
  MaxN = 3;
  Lim = 18;

type
  ttable = array of array of longint;

var
  t, size, n, k: longint;
  Data: array of longint;
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

  function compare(a, b: longint): longint;
  var
    adsum, bdsum: longint;
  begin
    adsum := dsum(a);
    bdsum := dsum(b);

    if (adsum > bdsum) or (adsum = bdsum) and (a > b) then
      exit(1);
    if (adsum < bdsum) or (adsum = bdsum) and (a < b) then
      exit(-1);
    exit(0);
  end;

  procedure fill_data(var Data: array of longint; size: longint);
  var
    i, imin, j, t: longint;
  begin
    for i := 0 to size - 1 do
      Data[i] := i + 1;

    for i := 0 to size - 2 do
    begin
      imin := i;
      for j := i + 1 to size - 1 do
        if compare(Data[j], Data[imin]) < 0 then
          imin := j;
      t := Data[imin];
      Data[imin] := Data[i];
      Data[i] := t;
    end;
  end;

  function full_search(Data: array of longint; k: longint): longint;
  var
    i, q, kdq: longint;
  begin
    kdq := dq(k);
    q := 0;
    i := 0;

    while Data[i] <> k do
    begin
      if kdq < dq(Data[i]) then
        q += 1;
      i += 1;
    end;

    exit(q);
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
  SetLength(Data, power_10(MaxN));
  SetLength(table, Lim + 1, (Lim - 1) * 9 + 1);
  fill_table(table);

  randomize;
  for t := 1 to MaxT do
  begin
    n := random(MaxN) + 1;
    k := random(power_10(n)) + 1;

    size := power_10(n);
    fill_data(Data, size);

    if full_search(Data, k) <> optimal_search(table, n, k) then
      writeln('Error');
  end;
  writeln('Done');
end.
