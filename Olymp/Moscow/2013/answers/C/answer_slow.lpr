program answer_slow;

var
  a, b: array of byte;
  N, i, j, p, k, q: longint;
begin
  readln(N);

  SetLength(a, N + 2);
  FillByte(a[0], N + 2, 0);
  SetLength(b, N + 2);
  FillByte(b[0], N + 2, 0);

  k := 1;
  p := 0;
  q := 0;

  while k < N / 2 do
  begin
    k := 2 * k;
    p := p + 1;
  end;

  A[k] := 1;

  for i := k + 1 to N do
  begin
    for j := 1 to N do
      if a[j - 1] + a[j + 1] = 1 then
        b[j] := 1
      else
        b[j] := 0;

    for j := 1 to N do
      a[j] := b[j];
  end;

  for i := 1 to N do
    if a[i] = 1 then
      q := q + 1;

  writeln(q);
  readln();
end.
