program answer;

var
  M, N, P, Q: int64;

  function optimal_search(m, n, p, q: int64): int64;
  begin
    exit(p * q * (m - p + 1) * (n - q + 1));
  end;

begin
  readln(m, n, p, q);
  writeln(optimal_search(m, n, p, q));
end.

