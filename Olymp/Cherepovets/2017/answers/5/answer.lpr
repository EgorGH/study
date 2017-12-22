program answer;

uses
  Math;

const
  MaxN = 100;
  MaxSize = 2 * MaxN + 1;

type
  tdata = array[1..MaxSize, 1..MaxSize] of longint;

var
  size, n: longint;
  Data: tdata;

  procedure print_data();
  var
    i, j: longint;
  begin
    for i := 1 to n do
    begin
      for j := 1 to size do
        Write(Data[i, j], ' ');
      writeln();
    end;
  end;

  procedure optimal_search();
  var
    i, j, prev: longint;
  begin
    for i := 1 to size do
      Data[1, i] := i;

    for i := 1 to n do
      Data[i, 1] := 1;

    for i := 2 to n do
      for j := 2 to size do
      begin
        prev := Data[i - 1, j];
        if prev = 2 then
          Data[i, j] := prev + 1
        else if prev = size then
          Data[i, j] := prev - 1
        else if prev mod 2 = 0 then
          Data[i, j] := prev - 2
        else
          Data[i, j] := prev + 2;
      end;
  end;

begin
  readln(n);
  size := 2 * n + 1;

  optimal_search();

  print_data();
end.
