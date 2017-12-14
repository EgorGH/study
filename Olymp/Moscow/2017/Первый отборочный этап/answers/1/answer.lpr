program answer;

var a, b, c: int64;

  function optimal_search(a, b, c: int64): int64;
  var
    i, q: int64;
  begin
    q := 0;

    i := a;
    while (i mod c <> 0) and (i <= b) do
      i := i + 1;

    while (i <= b) do
    begin
      i := i + c;
      q := q + 1;
    end;

    exit(q);
  end;

begin
  readln(a);
  readln(b);
  readln(c);
  writeln(optimal_search(a, b, c));
end.

