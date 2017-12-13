program test_slow;

uses
  Math;

const
  MaxN = 8;
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
        write(data[i, j]: 3);
      writeln();
    end;
    writeln();
  end;

  procedure Clear(var data: tdata);
  var
    i, j: longint;
  begin
    for i := 1 to size do
      for j := 1 to size do
        data[i, j] := 0;
  end;

  procedure full_search_routine(a, b, c, Value: longint);
  begin
    data[a, b] := c;
    visits[a, c] := value;

    relations[Data[a, b - 1], c] := Value;
    relations[c, Data[a, b - 1]] := value;

    if b = size then
    begin
      relations[Data[a, 1], c] := Value;
      relations[c, Data[a, 1]] := Value;
    end;
  end;

  function full_search(a, b, c: longint): boolean;
  var
    i: longint;
  begin
    if a > n then
      exit(True);

    if visits[a, c] = 1 then
      exit(False);
    if (b > 1) and (relations[c, Data[a, b - 1]] = 1) then
      exit(False);
    if (b = size) and (relations[c, Data[a, 1]] = 1) then
      exit(False);

    full_search_routine(a, b, c, 1);

    if (b = size) and full_search(a + 1, 1, 1) then
      exit(True);
    if (b < size) then
      for i := 2 to size do
        if full_search(a, b + 1, i) then
          exit(True);

    full_search_routine(a, b, c, 0);
    exit(False);
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

    Clear(visits);
    Clear(relations);
    Clear(Data);
    full_search(1, 1, 1);

    Clear(visits);
    Clear(relations);
    if not check_data() then
      writeln('Error');
  end;
  writeln('Done');
end.
