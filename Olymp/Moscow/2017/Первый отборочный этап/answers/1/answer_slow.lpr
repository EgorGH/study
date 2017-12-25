program answer_slow;

var
  a, b, c: longint;

  function full_search(): longint;
  var
    i, q: longint;
  begin
    q := 0;
    for i := a to b do
      if i mod c = 0 then
        q += 1;
    exit(q);
  end;

begin
  readln(a);
  readln(b);
  readln(c);
  writeln(full_search());
end.

