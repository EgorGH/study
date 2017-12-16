program answer;

uses
  Math;

const
  Lim = 18;

type
  tdata = array[0..Lim, 0..Lim * 9] of int64;
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

  procedure fill_data(n: longint);
  var
    i, j, p: longint;
  begin
    for i := 0 to n do
      for j := 0 to n * 9 do
        Data[i, j] := 0;

    for i := 0 to 9 do
      Data[1, i] := 1;

    for i := 0 to n do
      Data[i, 0] := 1;

    for i := 2 to n do
      for j := 1 to n * 9 do
        for p := 0 to min(j, 9) do
          Data[i, j] += Data[i - 1, j - p];

    for i := n downto 2 do
      for j := n * 9 downto 1 do
      begin
        Data[i, j] := 0;
        for p := 1 to min(j, 9) do
          Data[i, j] += Data[i - 1, j - p];
      end;

    for i := 1 to n do
      for j := 2 to n * 9 do
        Data[i, j] += Data[i, j - 1];

    for i := n - 1 downto 1 do
      for j := 1 to n * 9 do
        Data[i, j] += Data[i + 1, j];
  end;

  function optimal_search(n: longint; k: int64): int64;
  var
    kdsum, kdq: longint;
  begin
    kdsum := dsum(k);
    kdq := dq(k);

    if kdsum = 1 then
      exit(0);
    if kdq = n then
      exit(1);

    exit(Data[kdq + 1, kdsum - 1] + 1);
  end;

begin
  readln(n, m);
  fill_data(n);
  for i := 1 to m do
  begin
    Read(k);
    Write(optimal_search(n, k), ' ');
  end;
end.

