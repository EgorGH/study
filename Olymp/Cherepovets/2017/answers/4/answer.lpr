program answer;

const
  Lim = 500;
  LimK = Lim * Lim;

var
  m, n, k, i: longint;
  labyrinth: array[0..Lim + 1, 0..Lim + 1] of longint;
  ky, kx: array[1..LimK] of longint;

  procedure prepare_labyrinth();
  var
    i: longint;
  begin
    for i := 0 to m + 1 do
    begin
      labyrinth[i, 0] := 1;
      labyrinth[i, n + 1] := 1;
    end;

    for i := 0 to n + 1 do
    begin
      labyrinth[0, i] := 1;
      labyrinth[m + 1, i] := 1;
    end;
  end;

  procedure print_labyrinth();
  var
    i, j: longint;
  begin
    for i := 0 to m + 1 do
    begin
      for j := 0 to n + 1 do
        Write(labyrinth[i, j]: 3);
      writeln();
    end;
    writeln();
  end;

  function check(): boolean;
  var
    x, y, a, b, c, d, direction: longint;
  begin
    direction := 1;

    x := 1;
    y := 1;

    a := -1;
    b := 0;
    c := 0;
    d := 1;

    while (labyrinth[1, 1] > -1) and (labyrinth[m, n] > -1) do
    begin
      print_labyrinth();

      case direction of
        0:
        begin
          a := 0;
          b := -1;
          c := -1;
          d := 0;
        end;
        1:
        begin
          a := -1;
          b := 0;
          c := 0;
          d := 1;
        end;
        2:
        begin
          a := 0;
          b := 1;
          c := 1;
          d := 0;
        end;
        3:
        begin
          a := 1;
          b := 0;
          c := 0;
          d := -1;
        end;
      end;

      if labyrinth[x + a, y + b] < 1 then
      begin
        direction := (direction + 3) mod 4;
        x := x + a;
        y := y + b;
        labyrinth[x, y] := -1;
        continue;
      end;

      if labyrinth[x + c, y + d] > 0 then
        direction := (direction + 1) mod 4;

      if labyrinth[x + c, y + d] < 1 then
      begin
        x := x + c;
        y := y + d;
        labyrinth[x, y] := -1;
      end;
    end;

    if labyrinth[1, 1] = -1 then
      exit(False)
    else
      exit(True);
  end;

begin
  readln(m, n, k);
  prepare_labyrinth();

  for i := 1 to k do
  begin
    readln(ky[i], kx[i]);
    labyrinth[ky[i], kx[i]] := i;
  end;

  writeln(check());
  readln();
end.
