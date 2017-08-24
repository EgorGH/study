program test1;

const
  Lim = 10000;
  MaxR = 1000;
  MaxT = 100000;
  M = 4;

type
  TMin = record
    minA: longint;
    minB: longint;
    fA: boolean;
    fB: boolean;
  end;

var
  a: array[1..Lim] of integer;
  N, t: integer;

  function update_min(a: TMin; b: longint): TMin;
  begin
    if not a.fA or (b <= a.minA) then
    begin
      a.fB := a.fA;
      a.minB := a.minA;
      a.fA := True;
      a.minA := b;
    end
    else if not a.fB or (b <= a.minB) then
    begin
      a.fB := True;
      a.minB := B;
    end;
    exit(a);
  end;

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
    i, j: integer;
    res: TMin;
  begin
    res.fA := False;

    for i := 1 to N - M do
      for j := i + M to N do
        res := update_min(res, a[i] + a[j]);

    exit(res.minA);
  end;

  function solveB(): integer;
  var
    i, j, k: integer;
    min: array[1..2 * m, 1..2] of integer;
    res: TMin;
  begin
    res.fA := False;

    for i := 1 to 2 * M do
    begin
      min[i, 1] := 10001;
      min[i, 2] := 10001;
    end;

    for i := 1 to N do
    begin
      for j := 1 to 2 * M do
      begin
        if a[i] <= min[j, 1] then
        begin
          for k := 2 * M downto (j + 1) do
          begin
            min[k, 1] := min[k - 1, 1];
            min[k, 2] := min[k - 1, 2];
          end;
          min[j, 1] := a[i];
          min[j, 2] := i;
          break;
        end;
      end;
    end;

    for i := 1 to 2 * M - 1 do
      for j := i + 1 to 2 * M do
        if abs(min[i, 2] - min[j, 2]) > M - 1 then
          res := update_min(res, min[i, 1] + min[j, 1]);

    exit(res.minA);
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
