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
    i, prod, mEven, min, r: longint;
    w: array[0..M - 1] of integer;
    found, fEven, fMin: boolean;
  begin
    found := False;
    fEven := False;
    fMin := False;

    for i := 1 to M do
      w[i mod M] := a[i];

    for i := M + 1 to N do
    begin
      r := w[i mod M];

      if (r < min) or not fMin then
      begin
        fMin := True;
        min := r;
      end;

      if (r mod 2 = 0) and (not fEven or (r < mEven)) then
      begin
        fEven := True;
        mEven := r;
      end;

      if (a[i] mod 2 = 0) and (not found or (a[i] * min < prod)) then
      begin
        found := True;
        prod := a[i] * min;
      end;

      if (a[i] mod 2 <> 0) and fEven and (not found or (a[i] * mEven < prod)) then
      begin
        found := True;
        prod := a[i] * mEven;
      end;

      w[i mod M] := a[i];
    end;

    if found then
      exit(prod)
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
  writeln('Done!');
  readln();
end.
