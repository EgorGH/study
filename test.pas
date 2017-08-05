program test;

uses
  Math;

const
  maxR = 50;
  maxT = 100000;
  Lim = 1000;

type
  TTriangle = record
    A, B, C: longint;
    fA, fB, fC, f: boolean;
    S: double;
  end;

var
  x, y: array[1..Lim] of longint;
  i, N, t: integer;

  function update_triangle(a: Ttriangle; x, y: longint): Ttriangle;
  begin
    if (y = 0) and ((x > a.B) or (a.fB = False)) then
    begin
      a.fB := True;
      a.B := x;
    end;
    if (y = 0) and ((x < a.A) or (a.fA = False)) then
    begin
      a.fA := True;
      a.A := x;
    end;
    if (y > 0) and ((y > a.C) or (a.fC = False)) then
    begin
      a.fC := True;
      a.C := y;
    end;
    exit(a);
  end;

  procedure init();
  var
    i: integer;
  begin
    N := 2 + random(10);
    for i := 1 to N do
      x[i] := random(MaxR + 1) - 26;
    for i := 1 to N do
      y[i] := random(MaxR + 1) - 26;
  end;

  procedure print();
  var
    i: integer;
  begin
    writeln(N);
    for i := 1 to N do
      Write(x[i]: 4);
    writeln();
    for i := 1 to N do
      Write(y[i]: 4);
    writeln();
  end;

  function solveA(): double;
  var
    a, b, c: longint;
    s, smax: double;
  begin
    smax := 0;

    for a := 1 to N do
      if y[a] = 0 then
        for b := 1 to N do
          if y[b] = 0 then
            for c := 1 to N do
              if ((x[a] > 0) and (x[b] > 0) and (x[c] > 0)) or
                ((x[a] < 0) and (x[b] < 0) and (x[c] < 0)) then
              begin
                s := abs(x[a] - x[b]) * abs(y[c]) / 2;
                if s > smax then
                  smax := s;
              end;

    exit(smax);

  end;

  function solveB(): double;
  var
    neg, pos: ttriangle;

  begin
    neg.fA := False;
    neg.fB := False;
    neg.fC := False;
    pos.fA := False;
    pos.fB := False;
    pos.fC := False;

    for i := 1 to N do
    begin
      if x[i] < 0 then
        neg := update_triangle(neg, -x[i], abs(y[i]))
      else if x[i] > 0 then
        pos := update_triangle(pos, x[i], abs(y[i]));
    end;

    if pos.fA and pos.fB and pos.fC then
    begin
      pos.f := True;
      pos.S := (pos.B - pos.A) * pos.C / 2;
    end
    else
      pos.f := False;

    if neg.fA and neg.fB and neg.fC then
    begin
      neg.f := True;
      neg.S := (neg.B - neg.A) * neg.C / 2;
    end
    else
      neg.f := False;

    if neg.f and pos.f then
      exit(max(neg.S, pos.S))
    else if neg.f then
      exit(neg.S)
    else if pos.f then
      exit(pos.S)
    else
      exit(0);
  end;

begin
  randomize;
  for t := 1 to MaxT do
  begin
    init();
    if solveA() <> solveB() then
    begin
      print();
      writeln(solveA(): 0: 1);
      writeln(solveB(): 0: 1);
    end;
  end;
  writeln('Done!');
  readln();
end.
