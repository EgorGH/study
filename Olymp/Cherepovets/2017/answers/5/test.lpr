program test;

uses
  Math;

const
  MaxN = 100;
  MaxSize = 2 * MaxN + 1;

type
  tdata = array[1..MaxSize, 1..MaxSize] of longint;

var
  size, n: longint;
  Data, visits, relations: tdata;

  procedure print_data();
  var
    i, j: longint;
  begin
    for i := 1 to n do
    begin
      for j := 1 to size do
        Write(Data[i, j]: 3);
      writeln();
    end;
    writeln();
  end;

  procedure Clear(var Data: tdata);
  var
    i, j: longint;
  begin
    for i := 1 to size do
      for j := 1 to size do
        Data[i, j] := 0;
  end;

  procedure optimal_search();
  var
    i, j, prev: longint;
  begin
    for i := 1 to size do
      Data[1, i] := i;

    for i := 1 to n do
      data[i, 1] := 1;

    for i := 2 to n do
      for j := 2 to size do
      begin
        prev := data[i - 1, j];
        if prev = 2 then
          data[i, j] := prev + 1
        else if prev = size then
          data[i, j] := prev - 1
        else if prev mod 2 = 0 then
          data[i, j] := prev - 2
        else
          data[i, j] := prev + 2;
      end;
  end;

  function check_data(): boolean;
  var
    a, b, x, y: longint;
  begin
    for a := 1 to n do
      for b := 1 to size do
      begin
        x := Data[a, b];
        y := IfThen(b < size, Data[a, b + 1], Data[a, 1]);

        if (visits[a, x] = 1) or (relations[x, y] = 1) then
          exit(False);

        visits[a, x] := 1;
        relations[x, y] := 1;
        relations[y, x] := 1;
      end;
    exit(True);
  end;

begin
  for n := 1 to MaxN do
  begin
    size := 2 * n + 1;

    Clear(Data);
    optimal_search();

    Clear(visits);
    Clear(relations);
    if not check_data() then
      writeln('Error');
  end;
  writeln('Done');
end.

