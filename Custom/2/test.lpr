program test;

const
  HMax = 4;
  TMax = 10;

var
  a, b, c, d, t, i, j: longint;
  moves: array[1..8, 1..2] of
  longint = ((1, 2), (-1, -2), (2, 1), (-2, -1), (-1, 2), (1, -2), (-2, 1), (2, -1));
  trace: array[1..HMax, 1..HMax] of longint;

  procedure init();
  begin
    a := random(HMax) + 1;
    b := random(HMax) + 1;
    c := random(HMax) + 1;
    d := random(HMax) + 1;
    for i := 1 to HMax do
      for j := 1 to HMax do
        trace[i, j] := 0;
  end;

  function full_search(a, b, c, d: longint): longint;
  var
    minq, i: longint;
    found: boolean = False;
    q: array[1..8] of longint = (-1, -1, -1, -1, -1, -1, -1, -1);
  begin
    if (a = c) and (b = d) then
      exit(0);

    if (a < 1) or (b < 1) or (a > HMax) or (b > HMax) then
      exit(-1);

    if trace[a, b] = 1 then
      exit(-1);

    trace[a, b] := 1;

    for i := 1 to 8 do
      q[i] := full_search(a + moves[i, 1], b + moves[i, 2], c, d);

    trace[a, b] := 0;

    for i := 1 to 8 do
      if (q[i] >= 0) and (not found or (q[i] < minq)) then
      begin
        found := True;
        minq := q[i];
      end;

    exit(minq + 1);
  end;

  function optimal_search(a, b, c, d: longint): longint;
  var
    i, j, q, k, x, y: longint;
    found: boolean = False;
  begin
    for i := 1 to HMax do
      for j := 1 to HMax do
        trace[i, j] := 0;

    trace[a, b] := 1;
    q := 1;

    while not found do
    begin
      if trace[c, d] > 0 then
        exit(trace[c, d] - 1);

      q := q + 1;
      for i := 1 to 8 do
        for j := 1 to 8 do
          if trace[i, j] = q - 1 then
            for k := 1 to 8 do
            begin
              x := i + moves[k, 1];
              y := j + moves[k, 2];
              if (trace[x, y] = 0) and (x >= 1) and (y >= 1) and
                (x <= HMax) and (y <= HMax) then
                trace[x, y] := q;
            end;
    end;
  end;

begin
  for t := 1 to TMax do
  begin
    init();
    if full_search(a, b, c, d) <> optimal_search(a, b, c, d) then
      writeln('Error');
  end;
  writeln('Done');
  readln();
end.
