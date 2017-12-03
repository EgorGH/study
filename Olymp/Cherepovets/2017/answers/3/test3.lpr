program test3;

uses
  Math;

const
  MaxN = 4;
  Lim = 18;

type
  tdata = array[1..Lim, 1..Lim * 9] of int64;

var
  n: longint;
  k: longint;
  Data: tdata;

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

  procedure fill_data(var Data: tdata; n: longint);
  var
    i, j, p: longint;
  begin
    for i := 1 to n do
      for j := 1 to n * 9 do
        Data[i, j] := 0;

    for i := 1 to 9 do
      Data[1, i] := 1;

    for i := 2 to n do
      for j := 1 to n * 9 do
        for p := 0 to min(j - 1, 9) do
          Data[i, j] := Data[i, j] + Data[i - 1, j - p];

    for i := 1 to n do
      for j := 2 to n * 9 do
        Data[i, j] := Data[i, j] + Data[i, j - 1];

    for i := n - 1 downto 1 do
      for j := 1 to n * 9 do
        Data[i, j] := Data[i, j] + Data[i + 1, j];
  end;

  function optimal_search(var Data: tdata; k: int64): int64;
  var
    kdsum, kdq: longint;
    q: int64;
  begin
    q := 0;
    kdsum := dsum(k);
    kdq := dq(k);

    if kdsum > 1 then
      q := q + 1;
    q := q + Data[kdq + 1, kdsum - 1];

    exit(q);
  end;

begin
  randomize;
  for n := 1 to MaxN do
  begin
    fill_data(Data, n);
    for k := 1 to power_10(n) do
      if full_search(n, k) <> optimal_search(Data, k) then
        writeln('Error');
  end;
  writeln('Done');
end.
