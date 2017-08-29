program answer;

const
  M = 6;
var
  N, a, i, min_prod, min_left_odd, min_left_even, pOdd, pEven: longint;
  w: array[0..M - 1] of integer;
  found, fOdd, fEven: boolean;
begin
  found := False;
  fOdd := False;
  fEven := False;

  readln(N);

  for i := 1 to M do
  begin
    readln(a);
    w[i mod M] := a;
  end;

  for i := M + 1 to N do
  begin
    readln(a);

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

    pOdd := min_left_odd * a;
    pEven := min_left_even * a;

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

    w[i mod M] := a;
  end;

  if found then
    writeln(min_prod)
  else
    writeln(-1);

  readln();
end.
