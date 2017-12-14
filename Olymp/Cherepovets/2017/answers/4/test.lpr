program test;

uses
  SysUtils;

const
  Lim = 500;
  MaxT = 10000;

type
  tpoint = record
    x, y: longint;
  end;

var
  Data: array[0..Lim + 1, 0..Lim + 1] of smallint;
  moves: array[1..4, 1..2] of shortint = ((1, 0), (-1, 0), (0, -1), (0, 1));
  walls: array[1..Lim * Lim] of tpoint;
  a, b, k, m, n, t, max: longint;

  procedure randomize_walls();
  var
    i, j: longint;
    t: tpoint;
  begin
    for i := 0 to m - 1 do
      for j := 0 to n - 1 do
      begin
        walls[i * n + j + 1].y := i + 1;
        walls[i * n + j + 1].x := j + 1;
      end;

    for i := n * m downto 2 do
    begin
      j := random(i) + 1;
      t := walls[i];
      walls[i] := walls[j];
      walls[j] := t;
    end;
  end;

  procedure prepare_data();
  var
    i, j: longint;
  begin
    for i := 0 to m + 1 do
      for j := 0 to n + 1 do
        Data[i, j] := 0;

    for i := 0 to m + 1 do
    begin
      Data[i, 0] := -1;
      Data[i, n + 1] := -1;
    end;

    for i := 0 to n + 1 do
    begin
      Data[0, i] := -1;
      Data[m + 1, i] := -1;
    end;

    for i := 1 to k do
      Data[walls[i].y, walls[i].x] := -1;
  end;

  procedure prepare_data_2();
  var
    i, j: longint;
  begin
    for i := 0 to m + 1 do
      for j := 0 to n + 1 do
        Data[i, j] := 0;

    for i := 0 to m + 1 do
    begin
      Data[i, 0] := k + 1;
      Data[i, n + 1] := k + 1;
    end;

    for i := 0 to n + 1 do
    begin
      Data[0, i] := k + 1;
      Data[m + 1, i] := k + 1;
    end;

    for i := 1 to k do
      Data[walls[i].y, walls[i].x] := i;
  end;

  procedure print_data();
  var
    i, j: longint;
  begin
    for i := 0 to m + 1 do
    begin
      for j := 0 to n + 1 do
        Write(Data[i, j]: 3);
      writeln();
    end;
    writeln();
  end;

  function is_possible(): boolean;
  var
    q, i, j, k: longint;
    f: boolean;
  begin
    if Data[1, 1] = 0 then
      Data[1, 1] := 1;
    repeat
      q := 0;
      for i := 1 to m do
        for j := 1 to n do
          if Data[i, j] = 0 then
          begin
            f := False;
            for k := 1 to 4 do
              if Data[i + moves[k, 1], j + moves[k, 2]] = 1 then
                f := True;
            if f then
            begin
              q += 1;
              Data[i, j] := 1;
            end;
          end;
    until (q = 0) or (Data[m, n] = 1);
    exit(Data[m, n] = 1);
  end;

  function full_search(): longint;
  var
    d: longint;
  begin
    d := k;
    while not is_possible() and (d > 0) do
    begin
      Data[walls[d].y, walls[d].x] := 0;
      d := d - 1;
    end;
    if d = k then
      exit(0)
    else
      exit(d + 1);
  end;

  procedure clear_path();
  var
    i, j: longint;
  begin
    for i := 1 to m do
      for j := 1 to n do
        if Data[i, j] = -1 then
          Data[i, j] := 0;
  end;

  function is_possible_optimal(): boolean;
  var
    a, b, c, d, i, x, y, direction: longint;
  begin
    direction := 1;

    x := 1;
    y := 1;

    a := -1;
    b := 0;
    c := 0;
    d := 1;
    max := 0;

    if Data[1, 1] <> 0 then
      for i := 1 to k do
        if Data[walls[i].y, walls[i].x] = Data[1, 1] then
        begin
          max := i;
          exit(False);
        end;

    while (Data[1, 1] > -1) and (Data[m, n] > -1) do
    begin
      //print_data();
      if (Data[x + a, y + b] > max) and (Data[x + a, y + b] <= k) then
        max := Data[x + a, y + b];

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

      if Data[x + a, y + b] < 1 then
      begin
        direction := (direction + 3) mod 4;
        x := x + a;
        y := y + b;
        Data[x, y] := -1;
        continue;
      end;

      if Data[x + c, y + d] > 0 then
      begin
        direction := (direction + 1) mod 4;
        continue;
      end;

      x := x + c;
      y := y + d;
      Data[x, y] := -1;
    end;

    if Data[1, 1] = -1 then
      exit(False)
    else
      exit(True);
  end;

  function optimal_search(): longint;
  var
    i: longint;
  begin
    while not is_possible_optimal() do
    begin
      print_data();
      for i := max to k do
        Data[walls[i].y, walls[i].x] := 0;
      clear_path();
    end;

    exit(max);
  end;

begin
  randomize;
  for t := 1 to MaxT do
  begin
    m := 10;
    n := 10;
    k := random(m * n) + 1;

    randomize_walls();

    prepare_data();
    a := full_search();

    prepare_data_2();
    print_data();
    b := optimal_search();

    if a <> b then
      writeln('Error')
    else
      writeln(t);
  end;
  writeln('Done');
  readln();
end.
