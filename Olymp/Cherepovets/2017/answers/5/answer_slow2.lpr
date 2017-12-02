program answer_slow2;

const
  Lim = 5;

var
  size, N: longint;
  Data: array[1..Lim, 1..2 * Lim + 1] of longint;
  relations: array[1..2 * Lim + 1, 1..2 * Lim + 1] of byte;
  trace: array[1..2 * Lim + 1] of byte;

  procedure prepare_data();
  var
    i, j: longint;
  begin
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

  function full_search(a, b, Value: longint): boolean;
  var
    i: longint;
    rel: byte;
    flag: boolean;
  begin
    writeln(a, ' ', b, ' ', Value);

    if b = 1 then
      rel := 0
    else if b = size then
      rel := relations[Value, 1]
    else
      rel := relations[Data[a, b - 1], Value];

    if (trace[Value] = 1) or (rel = 1) then
      exit(False);

    relations[Data[a, b - 1], Value] := 1;
    relations[Value, Data[a, b - 1]] := 1;

    if b = size then
    begin
      relations[Data[a, 1], Value] := 1;
      relations[Value, Data[a, 1]] := 1;
    end;

    Data[a, b] := Value;
    trace[Value] := 1;

    if b = size then
      exit(True);

    for i := 1 to size do
    begin
      flag := full_search(a, b + 1, i);

      if flag then
        exit(True);
    end;

    trace[Value] := 0;

    relations[Data[a, b - 1], Value] := 0;
    relations[Value, Data[a, b - 1]] := 0;

    if b + 1 = size then
    begin
      relations[Data[a, 1], Value] := 0;
      relations[Value, Data[a, 1]] := 0;
    end;

    exit(False);
  end;

  procedure full_search();
  var
    i, j: longint;
  begin
    for i := 2 to N do
    begin
      for j := 1 to size do
        trace[j] := 0;
      full_search(i, 1, 1);
    end;
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

begin
  readln(N);
  size := 2 * n + 1;
  prepare_data();
  full_search();
  print_data();
  readln();
end.
