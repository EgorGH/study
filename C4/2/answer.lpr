program answer;

type
  TMin = record
    minA: longint;
    minB: longint;
    fA: boolean;
    fB: boolean;
  end;

var
  a, N, i: integer;
  sum: longint;
  even, odd: TMin;

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

begin
  readln(N);

  even.fA := False;
  even.fB := False;
  odd.fA := False;
  odd.fB := False;

  if N = 2 then
  begin
    readln(a);
    sum := a;
    readln(a);
    sum := sum + a;
    N := 0;
  end;

  for i := 1 to N do
  begin
    readln(a);
    if a mod 2 = 0 then
      even := update_min(even, a)
    else
      odd := update_min(odd, a);
  end;

  if not even.fB and (N > 2) then
    sum := odd.minA + odd.minB
  else if not odd.fB and (N > 2) then
    sum := even.minA + even.minB
  else if (even.minA + even.minB < odd.minA + odd.minB) and (N > 2) then
    sum := even.minA + even.minB
  else if N > 2 then
    sum := odd.minA + odd.minB;

  writeln(sum);

  readln();
end.
