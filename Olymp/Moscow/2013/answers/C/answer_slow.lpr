program answer_slow;

var
  a, b, c: array of byte;
  N, i, j, q: longint;
begin
  readln(N);

  SetLength(a, N + 2);
  FillByte(a[0], N + 2, 0);
  SetLength(b, N + 2);
  FillByte(b[0], N + 2, 0);

  A[1] := 1;

  for i := 2 to N do
  begin
    for j := 1 to N do
      if a[j - 1] + a[j + 1] = 1 then
        b[j] := 1
      else
        b[j] := 0;

    c := a;
    a := b;
    b := c;
  end;

  q := 0;
  for i := 1 to N do
    if a[i] = 1 then
      q := q + 1;

  writeln(q);
  readln();
end.
