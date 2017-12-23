program answer;

uses
  SysUtils;

const
  Lim = 500;

type
  tpoint = record
    x, y: longint;
  end;

var
  Data: array[0..Lim + 1, 0..Lim + 1] of smallint;
  walls: array[1..Lim * Lim] of tpoint;
  m, n, k, i, max: longint;

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

  procedure clear_path();
  var
    i, j: longint;
  begin
    for i := 1 to n do
      for j := 1 to m do
        if Data[i, j] = -1 then
          Data[i, j] := 0;
  end;

  function is_possible_optimal(): boolean;
  var
    a, b, c, d, i, x, y, q, direction: longint;
  begin
    direction := 1;

    x := 1;
    y := 1;

    a := -1;
    b := 0;
    c := 0;
    d := 1;

    max := 0;
    q := 0;

    if Data[1, 1] <> 0 then
      for i := 1 to k do
        if Data[walls[i].x, walls[i].y] = Data[1, 1] then
        begin
          max := i;
          exit(False);
        end;

    if Data[n, m] <> 0 then
      for i := 1 to k do
        if Data[walls[i].x, walls[i].y] = Data[n, m] then
        begin
          max := i;
          exit(False);
        end;

    while Data[n, m] > -1 do
    begin
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

      if (Data[x + a, y + b] > max) and (Data[x + a, y + b] <= k) then
        max := Data[x + a, y + b];

      if (x = 1) and (y = 1) and (Data[1, 1] = -1) and (direction = 0) or (q = 10) then
        exit(False);

      if Data[x + a, y + b] < 1 then
      begin
        q := 0;
        direction := (direction + 3) mod 4;
        x := x + a;
        y := y + b;
        Data[x, y] := -1;
        continue;
      end;

      if Data[x + c, y + d] > 0 then
      begin
        q += 1;
        direction := (direction + 1) mod 4;
        continue;
      end;

      x := x + c;
      y := y + d;
      Data[x, y] := -1;
    end;

    exit(True);
  end;

  function optimal_search(): longint;
  var
    i, j, d: longint;
  begin
    if is_possible_optimal() then
      exit(0);

    for i := k downto 1 do
    begin
      clear_path();
      d := max;
      for j := d to k do
        Data[walls[j].x, walls[j].y] := 0;
      if is_possible_optimal() then
        exit(d);
    end;
  end;

begin
  readln(n, m, k);
  for i := 1 to k do
    readln(walls[i].x, walls[i].y);

  prepare_data();
  writeln(optimal_search());
  readln();
end.
