program test2_cached;

uses
  Math;

const
  Lim = 4;

var
  n, k: longint;
  cache: array[1..Lim * 9, 1..Lim, 0..1] of longint;

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

  function optimal_search(a, b: longint; c: byte): int64;
  var
    i: longint;
    q: int64;
  begin
    if ((b = 1) and (a <= 9)) or (a = 0) then
      exit(1);
    if (b = 1) and (a >= 10) then
      exit(0);

    q := 0;
    for i := min(a, 9) downto c do
      q += optimal_search(a - i, b - 1, 0);

    exit(q);
  end;

  function optimal_search_cached(a, b: longint; c: byte): int64;
  begin
    optimal_search_cached := cache[a, b, c];
    if optimal_search_cached = -1 then
    begin
      optimal_search_cached := optimal_search(a, b, c);
      cache[a, b, c] := optimal_search_cached;
    end;
  end;

  function optimal_search(n: longint; k: int64): int64;
  var
    kdsum, kdq, i, j: longint;
    q: int64;
  begin
    kdsum := dsum(k);
    kdq := dq(k);

    q := 0;
    if kdsum > 1 then
      q += 1;

    for i := 1 to kdsum - 1 do
      for j := kdq + 1 to n do
        q += optimal_search_cached(i, j, 1);

    exit(q);
  end;

  procedure prepare_cache(n: longint);
  var
    i, j, p: longint;
  begin
    for i := 1 to n * 9 do
      for j := 1 to n do
        for p := 0 to 1 do
          cache[i, j, p] := -1;
  end;

begin
  for n := 1 to Lim do
  begin
    prepare_cache(n);
    for k := 1 to power_10(n) do
      if full_search(n, k) <> optimal_search(n, k) then
        writeln('Error');
  end;
  writeln('Done');
end.

