program answer_slow;

var
  a, b, c: int64;
  q: longint = 0;
  i: longint;

begin
  readln(a);
  readln(b);
  readln(c);

  for i := a to b do
    if i mod c = 0 then
      q += 1;

  writeln(q);
end.

