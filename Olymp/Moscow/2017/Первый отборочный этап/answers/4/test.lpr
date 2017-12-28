program test;

uses
  Math;

const
  MaxT = 1000000;
  Lim = 100;

var
  k, n, t: longint;
  Data: array[0..Lim] of qword;

  function full_search(): qword;
  var
    i, p: longint;
    time: qword = 0;
  begin
    for i := n downto 1 do
      while Data[i] > 0 do
      begin
        p := min(Data[i], k);
        Data[i] -= p;
        Data[i - 1] += p;
        time += 2;
      end;
    exit(time);
  end;

  function optimal_search(): qword;
  var
    i: longint;
    time: qword = 0;
  begin
    for i := n downto 1 do
    begin
      time += 2 * i * (Data[i] div k);
      Data[i - 1] += Data[i] mod k;
      time += IfThen(Data[i] mod k > 0, 2, 0);
    end;
    exit(time);
  end;

  function process_test(maxk, maxn, maxdata: longint): boolean;
  var
    i, a, b: longint;
    data_original: array[0..Lim] of longint;
  begin
    k := random(maxk) + 1;
    n := random(maxn) + 1;
    for i := 1 to n do
      data_original[i] := random(maxdata + 1);
    Data := data_original;
    a := full_search();
    Data := data_original;
    b := optimal_search();
    exit(a = b);
  end;

begin
  randomize();
  for t := 1 to MaxT do
    if not process_test(10, 10, 10) then
      writeln('error!');
  writeln('done!');
end.
