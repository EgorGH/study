program test;

const
  MaxT = 100;
  Lim = 500;

type
  tpoint = record
    x, y: longint;
  end;

var
  moves: array[1..4, 1..2] of longint = ((1, 0), (-1, 0), (0, -1), (0, 1));
  Data: array[0..Lim + 1, 0..Lim + 1] of smallint;
  walls: array[1..Lim * Lim] of tpoint;
  t, m, n, k: longint;

  procedure randomize_walls();
  var
    i, j: longint;
    t: tpoint;
  begin
    for i := 0 to n - 1 do
      for j := 0 to m - 1 do
      begin
        walls[i * m + j + 1].x := i + 1;
        walls[i * m + j + 1].y := j + 1;
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

    for i := 1 to k do
      Data[walls[i].x, walls[i].y] := i;

    for i := 0 to n + 1 do
    begin
      Data[i, 0] := k + 1;
      Data[i, m + 1] := k + 1;
    end;

    for i := 0 to m + 1 do
    begin
      Data[0, i] := k + 1;
      Data[n + 1, i] := k + 1;
    end;
  end;

  function full_search(): longint;
  var
    x, y, i, j, d, t, q, s: longint;
  begin
    d := k;
    q := 1;

    while d >= 0 do
    begin
      if Data[1, 1] = -1 then
      begin
        Data[walls[d].x, walls[d].y] := 0;
        d := d - 1;
        continue;
      end;

      Data[1, 1] := 1;

      if Data[m, n] > 0 then
        if d = k then
          exit(0)
        else
          exit(d + 1);

      s := 0;
      q := q + 1;
      for i := 1 to m do
        for j := 1 to n do
          if Data[i, j] = q - 1 then
            for t := 1 to 4 do
            begin
              x := i + moves[t, 1];
              y := j + moves[t, 2];

              if (x >= 1) and (y >= 1) and (x <= m) and (y <= n) then
                if (x <> -1) and (y <> -1) and (Data[x, y] = 0) then
                  Data[x, y] := q;
            end;

      for i := 1 to m do
        for j := 1 to n do
          if Data[i, j] >= q then
            s := 1;

      if s = 0 then
      begin
        Data[walls[d].x, walls[d].y] := 0;
        d := d - 1;
        q := q - 2;
      end;
    end;
  end;

  procedure print_data();
  var
    i, j: longint;
  begin
    for i := 0 to n + 1 do
    begin
      for j := 0 to m + 1 do
        Write(Data[i, j]: 3);
      writeln();
    end;
  end;

  function optimal_search(): longint;
  begin

  end;

begin
  for t := 1 to MaxT do
  begin
    n := random(10) + 1;
    m := random(10) + 1;
    k := random(n * m) + 1;
    randomize_walls();
    prepare_data();
    print_data();
    if full_search() <> optimal_search() then
      writeln('Error');
  end;
  writeln('Done');
  readln();
end.

