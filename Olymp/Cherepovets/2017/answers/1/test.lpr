program test;

const
  MaxT = 1000;
  MaxMN = 100;

var
  m, n, p, q: smallint;
  t: longint;

  procedure randomize_input(var m, n, p, q: smallint);
  begin
    m := random(MaxMN) + 1;
    n := random(MaxMN) + 1;
    p := random(m) + 1;
    q := random(n) + 1;
  end;

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

  function optimal_search(m, n, p, q: smallint): int64;
  begin
    exit(p * q * (m - p + 1) * (n - q + 1));
  end;

begin
  randomize;
  for t := 1 to MaxT do
  begin
    randomize_input(m, n, p, q);
    if full_search(m, n, p, q) <> optimal_search(m, n, p, q) then
      writeln('Error');
  end;
  writeln('Done');
end.

