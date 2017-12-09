program answer_slow;

const
  Lim = 500;

type
  tpoint = record
    x, y: longint;
  end;

var
  m, n, k, i: longint;
  Data: array[0..Lim + 1, 0..Lim + 1] of shortint;
  moves: array[1..4, 1..2] of shortint = ((1, 0), (-1, 0), (0, -1), (0, 1));
  walls: array[1..Lim * Lim] of tpoint;

  procedure prepare_data();
  var
    i: longint;
  begin
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

  function optimal_search(): longint;
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

begin
  readln(m, n, k);
  prepare_data();

  for i := 1 to k do
  begin
    readln(walls[i].y, walls[i].x);
    Data[walls[i].y, walls[i].x] := -1;
  end;

  writeln(optimal_search());
  readln();
end.
