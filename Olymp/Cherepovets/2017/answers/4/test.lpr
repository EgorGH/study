program test;

uses
  SysUtils;

const
  Lim = 500;
  MaxT = 10;

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
    for i := 1 to n do
      for j := 1 to m do
        Data[i, j] := 0;

    for i := 0 to n + 1 do
    begin
      Data[i, m + 1] := k + 1;
      Data[i, 0] := k + 1;
    end;

    for i := 0 to m + 1 do
    begin
      Data[n + 1, i] := k + 1;
      Data[0, i] := k + 1;
    end;

    for i := 1 to k do
      Data[walls[i].x, walls[i].y] := i;
  end;

  procedure print_data();
  var
    i, j: longint;
  begin
    writeln(n, ' ', m, ' ', k);

    for i := 0 to n + 1 do
    begin
      for j := 0 to m + 1 do
        Write(Data[i, j]: 3);
      writeln();
    end;
    writeln();
  end;

  function is_possible(): boolean;
  var
    i, j, k, q: longint;
    found: boolean;
  begin
    if Data[1, 1] > 0 then
      exit(False);

    Data[1, 1] := -1;

    repeat
      q := 0;
      for i := 1 to n do
        for j := 1 to m do
          if Data[i, j] = 0 then
          begin
            found := False;
            for k := 1 to 4 do
              if Data[i + moves[k, 1], j + moves[k, 2]] = -1 then
                found := True;
            if found then
            begin
              Data[i, j] := -1;
              q := q + 1;
            end;
          end;
    until (Data[n, m] = -1) or (q = 0);

    exit(Data[n, m] = -1);
  end;

  function full_search(): longint;
  var
    i: longint;
  begin
    if is_possible() then
      exit(0);

    for i := k downto 1 do
    begin
      Data[walls[i].x, walls[i].y] := 0;
      if is_possible() then
        exit(i);
    end;
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

    if Data[m, n] <> 0 then
      for i := 1 to k do
        if Data[walls[i].y, walls[i].x] = Data[m, n] then
        begin
          max := i;
          exit(False);
        end;

    while (Data[1, 1] > -1) and (Data[m, n] > -1) do
    begin
      if (Data[x + a, y + b] > max) and (Data[x + a, y + b] <= k) then
        max := Data[x + a, y + b];

      if (Data[x, y] = -1) and (direction = 1) then
        exit(False);

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
    i, j: longint;
  begin
    //print_data();
    if is_possible_optimal() then
      exit(0);

    for i := k downto 1 do
    begin
      //print_data();
      for j := max to k do
        Data[walls[j].x, walls[j].y] := 0;

      if is_possible_optimal() then
        exit(max);

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
    //print_data();
    a := full_search();

    prepare_data();
    //print_data();
    b := optimal_search();

    if a <> b then
    begin
      writeln('error');
      //prepare_data();
      //b := optimal_search();
    end;
  end;
  writeln('Done');
  readln();
end.
