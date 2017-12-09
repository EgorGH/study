program test_slow;

const
  MaxN = 3;

var
  size, n, k: longint;
  Data: array of longint;

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

  function optimal_search(n, k: longint): longint;
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

begin
  SetLength(Data, power_10(MaxN));

  randomize;
  for n := 1 to MaxN do
    for k := 1 to power_10(n) do
    begin
      size := power_10(n);
      fill_data(Data, size);

      if full_search(Data, k) <> optimal_search(n, k) then
        writeln('Error');
    end;
  writeln('Done');
end.
