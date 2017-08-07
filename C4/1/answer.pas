program answer;

uses
  Math;

type
  TTriangle = record
    A, B, C: longint;
    fA, fB, fC, f: boolean;
    S: double;
  end;

var
  i, N: integer;
  neg, pos: ttriangle;
  x, y: longint;
  S: double;

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

begin
  neg.fA := False;
  neg.fB := False;
  neg.fC := False;
  pos.fA := False;
  pos.fB := False;
  pos.fC := False;

  readln(N);

  for i := 1 to N do
  begin
    Read(x);
    readln(y);

    if x < 0 then
      neg := update_triangle(neg, -x, abs(y))
    else if x > 0 then
      pos := update_triangle(pos, x, abs(y));
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
    S := max(neg.S, pos.S)
  else if neg.f then
    S := neg.S
  else if pos.f then
    S := pos.S
  else
    S := 0;

  writeln(S: 0: 1);

  readln();
end.
