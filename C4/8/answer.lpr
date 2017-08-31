program answer;

const
  M = 6;
var
  N, a, i, prod, mEven, min, temp: longint;
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

    temp := w[i mod M];

    if (temp < min) or not fMin then
    begin
      fMin := True;
      min := temp;
    end;

    if (temp mod 2 = 0) and ((temp < mEven) or not fEven) then
    begin
      fEven := True;
      mEven := temp;
    end;

    if fMin and (a mod 2 = 0) and ((a * min < prod) or not found) then
    begin
      found := True;
      prod := a * min;
    end;

    if fEven and (a mod 2 <> 0) and ((a * mEven < prod) or not found) then
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
