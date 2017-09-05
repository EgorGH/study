program answerA;

const
  Lim = 10000;
  M = 6;
var
  a: array[1..Lim] of longint;
  N, i, j, min: longint;
  found: boolean;
begin
  found := False;

  readln(N);

  for i := 1 to N do
    readln(a[i]);

  for i := 1 to N - M do
    for j := i + M to N do
      if (a[i] * a[j] mod 2 = 0) and ((a[i] * a[j] < min) or not found) then
      begin
        found := True;
        min := a[i] * a[j];
      end;

  if found then
    writeln(min)
  else
    writeln(-1);
end.
