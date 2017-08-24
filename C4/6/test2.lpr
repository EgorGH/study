program test2;

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
    N := M + 1 + random(5);
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
    i, j, k, p, min_sum, min_left: integer;
    w: array[1..M] of integer;
  begin
    min_sum := a[1] + a[5];
    min_left := a[1];

    for i := 1 to N - (M - 1) do
    begin
      k := 0;
      for j := i to i + (M - 1) do
      begin
        k := k + 1;
        w[k] := a[j];
      end;

      for p := i - 1 downto 1 do
        if (a[p] < min_left) then
          min_left := a[p];

      if (j < N) and (w[1] + a[j + 1] <= min_sum) then
        min_sum := w[1] + a[j + 1];

      if (j < N) and (a[j + 1] + min_left <= min_sum) then
        min_sum := a[j + 1] + min_left;
    end;

    exit(min_sum);
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
