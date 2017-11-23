program answer;

const
  Lim = 500;

var
  m, n, k, i: longint;
  labyrinth: array[0..Lim + 1, 0..Lim + 1] of longint;
  moves: array[1..4, 1..2] of longint = ((1, 0), (-1, 0), (0, -1), (0, 1));
  by, bx: array[1..Lim * Lim] of longint;

  procedure make_borders();
  var
    i: longint;
  begin
    for i := 0 to m + 1 do
    begin
      labyrinth[i, 0] := -1;
      labyrinth[i, n + 1] := -1;
    end;

    for i := 0 to n + 1 do
    begin
      labyrinth[0, i] := -1;
      labyrinth[m + 1, i] := -1;
    end;
  end;

  function optimal_search(): longint;
  var
    x, y, q, s, i, j, d, t: longint;
  begin
    d := k;
    labyrinth[1, 1] := 1;
    q := 1;

    while d > 0 do
    begin
      if labyrinth[m, n] <> 0 then
        if d = k then
          exit(0)
        else
          exit(d + 1);

      s := 0;
      q := q + 1;
      for i := 1 to m do
        for j := 1 to n do
          if labyrinth[i, j] = q - 1 then
            for t := 1 to 4 do
            begin
              x := i + moves[t, 1];
              y := j + moves[t, 2];
              if (x <> -1) and (y <> -1) and (labyrinth[x, y] = 0) then
                labyrinth[x, y] := q;
            end;

      for i := 1 to m do
        for j := 1 to n do
          if labyrinth[i, j] >= q then
            s := s + 1;

      if s = 0 then
      begin
        labyrinth[by[d], bx[d]] := 0;
        d := d - 1;
        q := q - 2;
      end;
    end;
  end;

begin
  readln(m, n, k);

  make_borders();

  for i := 1 to k do
  begin
    readln(by[i], bx[i]);
    labyrinth[by[i], bx[i]] := -1;
  end;

  writeln(optimal_search());
end.
