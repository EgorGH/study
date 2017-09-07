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
    i, j, sa, sb: longint;
    oldsums, newsums: array[0..2] of longint;
    f0, f1, f2: boolean;
  begin
    f0 := False;
    f1 := False;
    f2 := False;

    for i := 0 to 2 do
    begin
      newsums[i] := 0;
      oldsums[i] := 0;
    end;

    for i := 1 to N do
    begin
      for j := 0 to 2 do
      begin
        sa := oldsums[j] + a[i];
        sb := oldsums[j] + b[i];

        if (sa mod 3 = 0) and (not f0 or (sa > newsums[0])) then
        begin
          f0 := True;
          newsums[0] := sa;
        end;
        if (sa mod 3 = 1) and (not f1 or (sa > newsums[1])) then
        begin
          f1 := True;
          newsums[1] := sa;
        end;
        if (sa mod 3 = 2) and (not f2 or (sa > newsums[2])) then
        begin
          f2 := True;
          newsums[2] := sa;
        end;

        if (sb mod 3 = 0) and (not f0 or (sb > newsums[0])) then
        begin
          f0 := True;
          newsums[0] := sb;
        end;
        if (sb mod 3 = 1) and (not f1 or (sb > newsums[1])) then
        begin
          f1 := True;
          newsums[1] := sb;
        end;
        if (sb mod 3 = 2) and (not f2 or (sb > newsums[2])) then
        begin
          f2 := True;
          newsums[2] := sb;
        end;
      end;

      for j := 0 to 2 do
        oldsums[j] := newsums[j];
    end;

    exit(max(newsums[1], newsums[2]));
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
