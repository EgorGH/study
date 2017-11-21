program answer_slow;

var
  m, n, p, q: smallint;

  function full_search(m, n, p, q: smallint): int64;
  var
    quantity: int64;
    ax, ay, bx, by: smallint;
  begin
    quantity := 0;
    for ax := 1 to p do
      for ay := 1 to q do
        for bx := p to m do
          for by := q to n do
            quantity += 1;
    exit(quantity);
  end;

begin
  readln(m, n, p, q);
  writeln(full_search(m, n, p, q));
end.
