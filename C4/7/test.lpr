program test;

uses
  SysUtils;

const
  Lim = 10000;
  MaxR = 1000;
  MaxT = 100000;

type
  TRes = record
    sum: longint;
    index: string;
  end;

var
  a: array[1..Lim] of longint;
  N, t: integer;

  procedure init();
  var
    i: integer;
  begin
    N := 3 + random(5);
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

  function eval(v: longword): TRes;
  var
    i: longword;
    sum: longint;
    index: string;
  begin
    sum := 0;
    index := '';

    for i := 1 to N do
    begin
      if v mod 2 <> 0 then
      begin
        sum := sum + a[i];
        index := index + IntToStr(i) + ' ';
      end;

      v := v div 2;

      eval.sum := sum;
      eval.index := index;
    end;
  end;

  function solveA(): string;
  var
    v: longword;
    res, temp: TRes;
    fSum: boolean;

  begin
    fSum := False;

    for v := 1 to (1 shl N) - 1 do
    begin
      temp := eval(v);
      if (temp.sum mod 2 = 0) and (not fSum or (temp.sum > res.sum)) then
      begin
        fSum := True;
        res := temp;
      end;
    end;

    exit(res.index);
  end;

  function solveB(): string;
  var
    index: string;
    i, min_odd, imin_odd, q_odd, izero: longint;
    found: boolean;
  begin
    index := '';
    found := False;
    q_odd := 0;

    for i := 1 to N do
    begin
      if a[i] = 0 then
        izero := i;

      if (a[i] mod 2 <> 0) and (not found or (a[i] <= min_odd)) then
      begin
        found := True;
        imin_odd := i;
        min_odd := a[i];
      end;

      if (a[i] mod 2 <> 0) then
        q_odd := q_odd + 1;
    end;

    for i := 1 to N do
      if (i <> izero) and ((q_odd mod 2 = 0) or (i <> imin_odd)) then
        index := index + IntToStr(i) + ' ';

    exit(index);
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
