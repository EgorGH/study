program answer;

const
  N = 8;
type
  ttrace_row = ^longint;
  ttrace = ^ttrace_row;
var
  i, a, b, c, d: longint;
  moves: array[0..7, 0..1] of
  longint = ((1, 2), (-1, -2), (2, 1), (-2, -1), (-1, 2), (1, -2), (-2, 1), (2, -1));
  trace: ttrace;

  procedure reset_trace(trace: ttrace);
  begin
    for i := 0 to N - 1 do
      FillByte(trace[i, 0], N * sizeof(longint), 0);
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
          if trace[i, j] >= q then
            s := s + 1;
      if s = 0 then
        exit(-1);
    end;
  end;

begin
  trace := GetMem(N * sizeof(ttrace_row));
  for i := 0 to N - 1 do
    trace[i] := GetMem(N * sizeof(longint));
  reset_trace(trace);

  readln(a, b, c, d);
  writeln(optimal_search(N, a, b, c, d));
end.
