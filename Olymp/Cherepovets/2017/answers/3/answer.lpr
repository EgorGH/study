program answer;

uses
  Math;

const
  Lim = 18;

type
  tdata = array[1..Lim, 1..Lim * 9] of int64;

var
  i, m, n: longint;
  k: int64;
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

    if kdq + 1 <= Lim then
      q := q + Data[kdq + 1, kdsum - 1];

    exit(q);
  end;

begin
  readln(n, m);
  fill_data(Data, n);
  for i := 1 to m do
  begin
    Read(k);
    Write(optimal_search(data, k), ' ');
  end;
end.
