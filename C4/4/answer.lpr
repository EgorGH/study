program answer;

type
  TRes = record
    q: integer;
    min: double;
  end;

var
  N, i, q: longword;
  found, fMin, fMax: boolean;
  res: TRes;
  a, min, max: double;

begin
  q := 0;
  fMin := False;
  fMax := False;
  found := False;

  readln(N);

  for i := 1 to N do
  begin
    readln(a);

    if a > 1 then
    begin
      found := True;
      q := q + 1;
      if not fMin or (a < min) then
      begin
        fMin := True;
        min := a;
      end;
    end
    else
    if not fMax or (a > max) then
    begin
      fMax := True;
      max := a;
    end;
  end;

  if found then
  begin
    res.q := q;
    res.min := min;
  end
  else
  begin
    res.q := 1;
    res.min := max;
  end;

  writeln(res.q, ' ', res.min: 0: 1);

  readln();
end.
