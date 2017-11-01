program test;

const
  NMax = 4;
  TMax = 10000;

type
  ttrace_row = ^longint;
  ttrace = ^ttrace_row;

var
  N, a, b, c, d, t, i, res1, res2: longint;
  moves: array[0..7, 0..1] of
  longint = ((1, 2), (-1, -2), (2, 1), (-2, -1), (-1, 2), (1, -2), (-2, 1), (2, -1));
  trace: ttrace;

  procedure randomize_params(var N, a, b, c, d: longint);
  begin
    N := random(NMax) + 1;
    a := random(N);
    b := random(N);
    c := random(N);
    d := random(N);
  end;

  procedure reset_trace(trace: ttrace);
  begin
    for i := 0 to NMax - 1 do
      FillByte(trace[i, 0], NMax * sizeof(longint), 0);
  end;

  function full_search(N, a, b, c, d: longint): longint;
  var
    minq, i: longint;
    s: longint = 0;
    found: boolean = False;
    q: array[0..7] of longint = (-2, -2, -2, -2, -2, -2, -2, -2);
  begin
    if (a = c) and (b = d) then
      exit(0);

    if (a < 0) or (b < 0) or (a >= N) or (b >= N) then
      exit(-1);

    if trace[a, b] = 1 then
      exit(-1);

    trace[a, b] := 1;

    for i := 0 to 7 do
      q[i] := full_search(N, a + moves[i, 0], b + moves[i, 1], c, d);

    trace[a, b] := 0;

    for i := 0 to 7 do
      if (q[i] >= 0) and (not found or (q[i] < minq)) then
      begin
        found := True;
        minq := q[i];
      end;

    for i := 0 to 7 do
      if q[i] = -1 then
        s := s + 1;
    if s = 8 then
      exit(-1);

    exit(minq + 1);
  end;

  function optimal_search(N, a, b, c, d: longint): longint;
  var
    i, j, q, k, x, y, s: longint;
    found: boolean = False;
  begin
    trace[a, b] := 1;
    q := 1;

    while not found do
    begin
      if trace[c, d] > 0 then
        exit(trace[c, d] - 1);

      s := 0;
      q := q + 1;
      for i := 0 to N - 1 do
        for j := 0 to N - 1 do
          if trace[i, j] = q - 1 then
            for k := 0 to 7 do
            begin
              x := i + moves[k, 0];
              y := j + moves[k, 1];
              if (x >= 0) and (y >= 0) and (x < N) and (y < N) then
                if (trace[x, y] = 0) then
                  trace[x, y] := q;
            end;

      for i := 0 to N - 1 do
        for j := 0 to N - 1 do
          if trace[i, j] > q - 1 then
            s := s + 1;
      if s = 0 then
        exit(-1);
    end;
  end;

begin
  randomize();
  trace := GetMem(NMax * sizeof(ttrace_row));
  for i := 0 to NMax - 1 do
    trace[i] := GetMem(NMax * sizeof(longint));

  for t := 1 to TMax do
  begin
    randomize_params(N, a, b, c, d);

    reset_trace(trace);
    res1 := full_search(N, a, b, c, d);

    reset_trace(trace);
    res2 := optimal_search(N, a, b, c, d);

    if res1 <> res2 then
    begin
      writeln('Error');
      writeln(N, ' ', a, ' ', b, ' ', c, ' ', d);
      writeln(res1, ' ', res2);
    end;
  end;
  writeln('Done');
  readln();
end.
