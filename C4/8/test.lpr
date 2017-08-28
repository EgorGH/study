program test;

const
  Lim = 10000;
  MaxR = 1000;
  MaxT = 100000;
  M = 6;

var
  a: array[1..Lim] of longint;
  N, t: longint;

  procedure init();
  var
    i: integer;
  begin
    N := M + 1 + random(10);
    for i := 1 to N do
      a[i] := 1 + random(MaxR + 1);
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

  function solveA(): longint;
  var
    i, j, min: longint;
    found: boolean;
  begin
    found := False;

    for i := 1 to N - M do
      for j := i + M to N do
        if (a[i] * a[j] mod 2 = 0) and ((a[i] * a[j] < min) or not found) then
        begin
          found := True;
          min := a[i] * a[j];
        end;

    if found then
      exit(min)
    else
      exit(-1);
  end;

  function solveB(): longint;
  var
    i, min_prod, min_left_odd, min_left_even, pOdd, pEven: longint;
    w: array[0..M - 1] of integer;
    found, fOdd, fEven: boolean;
  begin
    found := False;
    fOdd := False;
    fEven := False;

    for i := 1 to M do
      w[i mod M] := a[i];

    for i := M + 1 to N do
    begin
      if (w[i mod M] mod 2 <> 0) and ((w[i mod M] < min_left_odd) or not fOdd) then
      begin
        fOdd := True;
        min_left_odd := w[i mod M];
      end;

      if (w[i mod M] mod 2 = 0) and ((w[i mod M] < min_left_even) or not fEven) then
      begin
        fEven := True;
        min_left_even := w[i mod M];
      end;

      pOdd := min_left_odd * a[i];
      pEven := min_left_even * a[i];

      if fOdd and (pOdd mod 2 = 0) and ((pOdd < min_prod) or not found) then
      begin
        found := True;
        min_prod := pOdd;
      end;

      if fEven and (pEven mod 2 = 0) and ((pEven < min_prod) or not found) then
      begin
        found := True;
        min_prod := pEven;
      end;

      w[i mod M] := a[i];
    end;

    if found then
      exit(min_prod)
    else
      exit(-1);
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
  writeln('Done!@!');
  readln();
end.
