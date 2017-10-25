program answer;

var
  a, b, c: qword;
  i, N: integer;

begin
  readln(N);
  a := 1;
  b := 1;
  for i := 3 to N + 2 do
  begin
    c := b;
    b := a + b;
    a := c;
  end;
  writeln(a, ' ', b);
end.
