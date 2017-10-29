program horse_move;

var
  a, b, c, d: longint;

  function min_moves(a, b, c, d: longint): longint;
  var
    i, j, q, k, x, y: longint;
    found: boolean = False;
    moves: array[1..8, 1..2] of
    longint = ((1, 2), (-1, -2), (2, 1), (-2, -1), (-1, 2), (1, -2), (-2, 1), (2, -1));
    trace: array[1..8, 1..8] of longint;
  begin
    for i := 1 to 8 do
      for j := 1 to 8 do
        trace[i, j] := 0;

    trace[a, b] := 1;
    q := 0;

    while not found do
    begin
      q := q + 1;
      for i := 1 to 8 do
        for j := 1 to 8 do
        begin
          if (i = c) and (j = d) and (trace[i, j] <> 0) then
            exit(trace[i, j] - 1);

          if trace[i, j] = q then
            for k := 1 to 8 do
            begin
              x := i + moves[k, 1];
              y := j + moves[k, 2];
              if (trace[x, y] = 0) and (x >= 1) and (y >= 1) and
                (x <= 8) and (y <= 8) then
                trace[x, y] := q + 1;
            end;
        end;
    end;
  end;

begin
  readln(a, b, c, d);
  writeln(min_moves(a, b, c, d));
  readln();
end.
