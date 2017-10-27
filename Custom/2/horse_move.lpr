program horse_move;

var
  a, b, c, d: integer;
  moves: array[1..8, 1..2] of
  integer = ((1, 2), (-1, -2), (2, 1), (-2, -1), (-1, 2), (1, -2), (-2, 1), (2, -1));
  trace: array[1..8, 1..8] of boolean;

  function full_search(a, b, c, d: integer): integer;
  var
    minq, i: integer;
    found: boolean = False;
    q: array[1..8] of integer = (-1, -1, -1, -1, -1, -1, -1, -1);
  begin
    if (a = c) and (b = d) then
      exit(0);

    if (a < 1) or (b < 1) or (a > 8) or (b > 8) then
      exit(-1);

    if trace[a, b] then
      exit(-1);

    trace[a, b] := True;

    for i := 1 to 8 do
      q[i] := full_search(a + moves[i, 1], b + moves[i, 2], c, d);

    for i := 1 to 8 do
      if (q[i] >= 0) and (not found or (q[i] < minq)) then
      begin
        found := True;
        minq := q[i];
      end;

    exit(minq + 1);
  end;

begin
  readln(a, b, c, d);
  writeln(full_search(a, b, c, d));
  readln();
end.
