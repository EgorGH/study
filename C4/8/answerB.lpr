program answerB;

const
  M = 6;
var
  N, a, i, prod, mEven, min, r: longint;
  w: array[0..M - 1] of integer;
  found, fEven, fMin: boolean;
begin
  found := False;
  fEven := False;
  fMin := False;

  readln(N);

  for i := 1 to M do
  begin
    readln(a);
    w[i mod M] := a;
  end;

  for i := M + 1 to N do
  begin
    readln(a);

    r := w[i mod M];

    if not fMin or (r < min) then
    begin
      fMin := True;
      min := r;
    end;

    if (r mod 2 = 0) and (not fEven or (r < mEven)) then
    begin
      fEven := True;
      mEven := r;
    end;

    if (a mod 2 = 0) and (not found or (a * min < prod)) then
    begin
      found := True;
      prod := a * min;
    end;

    if (a mod 2 <> 0) and fEven and (not found or (a * mEven < prod)) then
    begin
      found := True;
      prod := a * mEven;
    end;

    w[i mod M] := a;
  end;

  if found then
    writeln(prod)
  else
    writeln(-1);

  readln();
end.
