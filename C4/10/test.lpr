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

    for v := 1 to (1 shl N) - 1 do
    begin
      temp := eval(v);
      if (temp mod 3 <> 0) and (not fSum or (temp > res)) then
      begin
        fSum := True;
        res := temp;
      end;
    end;

    exit(res);
  end;

  function solveB(): longint;
  var
    i, sum0, sum1, sum2, res: longint;

  begin
    sum0 := 0;
    sum1 := 0;
    sum2 := 0;

    for i := 1 to N do
    begin
      if sum0 + a[i] mod 2 = 0 then
        sum0 := sum0 + a[i];
      if sum1 + a[i] mod 2 = 0 then
        sum0 := sum1 + a[i];
      if sum2 + a[i] mod 2 = 0 then
        sum0 := sum2 + a[i];
      if sum0 + a[i] mod 2 = 1 then
        sum1 := sum0 + a[i];
      if sum1 + a[i] mod 2 = 1 then
        sum1 := sum1 + a[i];
      if sum2 + a[i] mod 2 = 1 then
        sum1 := sum2 + a[i];
      if sum0 + a[i] mod 2 = 2 then
        sum2 := sum0 + a[i];
      if sum1 + a[i] mod 2 = 2 then
        sum2 := sum1 + a[i];
      if sum2 + a[i] mod 2 = 2 then
        sum2 := sum2 + a[i];

      if sum0 + b[i] mod 2 = 0 then
        sum0 := sum0 + b[i];
      if sum1 + b[i] mod 2 = 0 then
        sum0 := sum1 + b[i];
      if sum2 + b[i] mod 2 = 0 then
        sum0 := sum2 + b[i];
      if sum0 + b[i] mod 2 = 1 then
        sum1 := sum0 + b[i];
      if sum1 + b[i] mod 2 = 1 then
        sum1 := sum1 + b[i];
      if sum2 + b[i] mod 2 = 1 then
        sum1 := sum2 + b[i];
      if sum0 + b[i] mod 2 = 2 then
        sum2 := sum0 + b[i];
      if sum1 + b[i] mod 2 = 2 then
        sum2 := sum1 + b[i];
      if sum2 + b[i] mod 2 = 2 then
        sum2 := sum2 + b[i];
    end;

    res := max(sum1, sum2);

    exit(res);
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
