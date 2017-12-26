program test;

uses
  SysUtils;

const
  Lim = 100000;
  MaxT = 100000;

var
  n, m, k, i, t: longint;
  Data: array[1..Lim] of longint;

  function optimal_search(): longint;
  var
    i, idx, pos: longint;
  begin
    pos := m;
    for i := 1 to k do
    begin
      idx := Data[i] mod n + 1;
      if idx > pos then
        pos += 1
      else if idx = pos then
        pos := 1;
    end;
    exit(pos);
  end;

  function full_search(): longint;
  var
    w: array[1..Lim] of longint;
    i, j, temp: longint;
  begin
    for i := 1 to n do
      w[i] := i;

    for i := 1 to k do
    begin
      temp := w[Data[i] mod n + 1];
      for j := Data[i] mod n downto 1 do
        w[j + 1] := w[j];
      w[1] := temp;
    end;

    for i := 1 to n do
      if w[i] = m then
        exit(i);
  end;

  function process_test(maxn, maxk, maxt: longint): boolean;
  begin
    n := maxn;
    m := random(n) + 1;
    k := maxk;
    for i := 1 to k do
      Data[i] := random(maxt) + 1;
    exit(optimal_search() = full_search());
  end;

begin
  randomize();
  for t := 1 to MaxT do
    if not process_test(10, 20, 30) then
      writeln('error!');
  writeln('done!');
end.
