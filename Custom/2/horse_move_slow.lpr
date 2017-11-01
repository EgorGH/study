program horse_move_slow;

const
  N = 4;

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

begin
  trace := GetMem(N * sizeof(ttrace_row));
  for i := 0 to N - 1 do
    trace[i] := GetMem(N * sizeof(longint));
  reset_trace(trace);

  readln(a, b, c, d);
  writeln(full_search(N, a, b, c, d));
  readln();
end.
