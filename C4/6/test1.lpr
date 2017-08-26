program test1;

const
  Lim = 10000;
  MaxR = 1000;
  MaxT = 100000;
  M = 4;
  K = 2 * M;

var
  a: array[1..Lim] of integer;
  N, t: integer;

  procedure init();
  var
    i: integer;
  begin
    N := M + 1 + random(10);
    for i := 1 to N do
      a[i] := random(MaxR + 1);
  end;

  procedure print();
  var
    i: integer;
  begin
    writeln(N);
    for i := 1 to N do
      Write(a[i], ' ');
    writeln();
  end;

  function solveA(): integer;
  var
    i, j, min: integer;
  begin
    min := a[1] + a[M + 1];

    for i := 1 to N - M do
      for j := i + M to N do
        if a[i] + a[j] < min then
          min := a[i] + a[j];

    exit(min);
  end;

  function solveB(): integer;
  var
    i, j, r, min: integer;
    mins: array[1..K, 1..2] of integer;
  begin
    min := a[1] + a[M + 1];

    for i := 1 to K do
      mins[i, 1] := 10001;

    for i := 1 to N do
      for j := 1 to K do
        if a[i] <= mins[j, 1] then
        begin
          for r := K downto (j + 1) do
            mins[r] := mins[r - 1];
          mins[j, 1] := a[i];
          mins[j, 2] := i;
          break;
        end;

    for i := 1 to K - 1 do
      for j := i + 1 to K do
        if (abs(mins[i, 2] - mins[j, 2]) > M - 1) and
          (mins[i, 1] + mins[j, 1] < min) then
          min := mins[i, 1] + mins[j, 1];

    exit(min);
  end;

begin
  randomize;
  for t := 1 to MaxT do
  begin
    init();
    if solveA() <> solveB() then
    begin
      print();
      writeln(solveA());
      writeln(solveB());
    end;
  end;
  writeln('Done!');
  readln();
end.
