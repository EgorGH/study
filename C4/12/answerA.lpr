program answerA;

const
  Lim = 1000;
var
  N, q, i, j: longword;
  a: array[1..Lim] of longword;
begin
  q := 0;

  readln(N);

  for i := 1 to N do
    readln(a[i]);

  for i := 1 to N - 1 do
    for j := i + 1 to N do
      if a[i] * a[j] mod 26 = 0 then
        q := q + 1;

  writeln(q);
  readln();
end.
