program answer;

const
  Lim = 500;
  LimK = Lim * Lim;

var
  m, n, k, i: longint;
  labyrinth: array[1..Lim, 1..Lim] of longint;
  moves: array[1..4, 1..2] of longint = ((1, 0), (-1, 0), (0, -1), (0, 1));
  ky, kx: array[1..LimK] of longint;

  function optimal_search(): longint;
  var
    x, y, i, j, d, t, q, s: longint;
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

              if (x >= 1) and (y >= 1) and (x <= m) and (y <= n) then
                if (x <> -1) and (y <> -1) and (labyrinth[x, y] = 0) then
                  labyrinth[x, y] := q;
            end;

      for i := 1 to m do
        for j := 1 to n do
          if labyrinth[i, j] >= q then
            s := 1;

      if s = 0 then
      begin
        labyrinth[ky[d], kx[d]] := 0;
        d := d - 1;
        q := q - 2;
      end;
    end;
  end;

begin
  readln(m, n, k);

  for i := 1 to k do
  begin
    readln(ky[i], kx[i]);
    labyrinth[ky[i], kx[i]] := -1;
  end;

  writeln(optimal_search());
end.
