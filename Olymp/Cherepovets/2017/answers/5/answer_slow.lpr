program answer_slow;

const
  MaxN = 10;
  MaxSize = 2 * MaxN + 1;

var
  size, n: longint;
  Data: array[1..MaxN, 1..MaxSize] of longint;
  relations: array[1..MaxSize, 1..MaxSize] of byte;

  procedure prepare_data();
  var
    i, j: longint;
  begin
    for i := 1 to size do
      for j := 1 to size do
        Data[i, j] := 0;

    for i := 1 to size do
      for j := 1 to size do
        relations[i, j] := 0;

    for i := 1 to size do
      Data[1, i] := i;

    for i := 1 to size - 1 do
    begin
      j := i + 1;
      relations[i, j] := 1;
      relations[j, i] := 1;
    end;

    relations[size, 1] := 1;
    relations[1, size] := 1;
  end;

  procedure print_data();
  var
    i, j: longint;
  begin
    for i := 1 to N do
    begin
      for j := 1 to size do
        Write(Data[i, j], ' ');
      writeln();
    end;
  end;

  function full_search(a, b, Value: longint): boolean;
  var
    i: longint;
    rel: byte;
  begin
    //writeln(a, ' ', b, ' ', Value);
    //print_data();
    //readln();

    for i := 1 to b - 1 do
      if Data[a, i] = Value then
        exit(False);

    if b = 1 then
      rel := 0
    else if b = size then
      rel := relations[Value, 1] or relations[Data[a, b - 1], Value]
    else
      rel := relations[Data[a, b - 1], Value];

    if rel = 1 then
      exit(False);

    Data[a, b] := Value;

    relations[Data[a, b - 1], Value] := 1;
    relations[Value, Data[a, b - 1]] := 1;

    if (a = n) and (b = size) then
      exit(True);

    if b = size then
    begin
      relations[Data[a, 1], Value] := 1;
      relations[Value, Data[a, 1]] := 1;
      //if a = 5 then
      //begin
      //  writeln(a);
      //  print_data();
      //  writeln();
      //end;
      exit(full_search(a + 1, 1, 1));
    end;

    for i := 1 to size do
      if full_search(a, b + 1, i) then
        exit(True);

    relations[Data[a, b - 1], Value] := 0;
    relations[Value, Data[a, b - 1]] := 0;

    if b = size then
    begin
      relations[Data[a, 1], Value] := 0;
      relations[Value, Data[a, 1]] := 0;
    end;

    exit(False);
  end;

begin
  n := 6;
  //readln(n);
  size := 2 * n + 1;

  prepare_data();
  full_search(2, 1, 1);
  print_data();

  readln();
end.
