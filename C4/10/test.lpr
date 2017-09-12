program test;

uses
  Math;

const
  Lim = 10000;
  MaxR = 10;
  MaxT = 100000;

var
  a, b: array[1..Lim] of longint;
  N, t: integer;

  procedure init();
  var
    i: integer;
  begin
    N := 1 + random(5);
    for i := 1 to N do
    begin
      a[i] := 1 + random(MaxR + 1);
      b[i] := 1 + random(MaxR + 1);
    end;
  end;

  procedure print();
  var
    i: integer;
  begin
    writeln(N);
    for i := 1 to N do
      Write(a[i], ' ');
    writeln();
    for i := 1 to N do
      Write(b[i], ' ');
    writeln();
  end;

  function eval(v: longword): longint;
  var
    i: longword;
    sum: longint;
  begin
    sum := 0;

    for i := 1 to N do
    begin
      if v mod 2 <> 0 then
        sum := sum + a[i]
      else
        sum := sum + b[i];

      v := v div 2;
    end;

    exit(sum);
  end;

  function solveA(): longint;
  var
    v: longword;
    res, temp: longint;
    fSum: boolean;

  begin
    fSum := False;

    for v := 0 to (1 shl N) - 1 do
    begin
      temp := eval(v);
      if (temp mod 3 <> 0) and (not fSum or (temp > res)) then
      begin
        fSum := True;
        res := temp;
      end;
    end;

    if fSum then
      exit(res)
    else
      exit(0);
  end;

  function solveB(): longint;
  var
    i, sum, maxE, minE, diff, diff_min: longint;
    found: boolean;

  begin
    sum := 0;
    found := False;

    for i := 1 to N do
    begin
      maxE := max(a[i], b[i]);
      minE := min(a[i], b[i]);

      sum := sum + maxE;

      diff := maxE - minE;

      if (diff mod 3 <> 0) and (not found or (diff < diff_min)) then
      begin
        found := True;
        diff_min := diff;
      end;
    end;

    if found and (sum mod 3 = 0) then
      sum := sum - diff_min;

    if not found and (sum mod 3 = 0) then
      sum := 0;

    exit(sum);
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
