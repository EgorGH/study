program generate_test;

var
  i, m, n, k: longint;

begin
  readln(m, n, k);
  writeln(m, ' ', n, ' ', k);
  for i := 1 to k do
    writeln(random(m) + 1, ' ', random(n) + 1);
end.

