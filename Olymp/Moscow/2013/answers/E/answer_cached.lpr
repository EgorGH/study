program answer_cached;

const
  Lim = 100;
var
  T, N, K, a, b, i, j: longint;
  m: array[1..Lim, 1..Lim] of longint;

  function cached_search(n, k: longint): longint;
  forward;

  function full_search(n, k: longint): longint;
  var
    a, b, i, d, w, max, min: longint;
  begin
    min := 100;
    if (n = k) or (k = 0) then
      exit(0);
    for w := 1 to n - 1 do
    begin
      max := 0;
      a := w;
      b := n - w;
      for i := 0 to k do
        if (i <= a) and (k - i <= b) then
        begin
          d := cached_search(a, i) + cached_search(b, k - i) + 1;
          if d > max then
            max := d;
        end;
      if max < min then
        min := max;
    end;
    m[n, k] := min;
    exit(min);
  end;

  function cached_search(n, k: longint): longint;
  var
    q: longint;
  begin
    if m[n, k] = 0 then
    begin
      q := full_search(n, k);
      m[n, k] := q;
      exit(q);
    end
    else
      exit(m[n, k]);
  end;

begin
  for i := 1 to Lim do
    for j := 1 to Lim do
      m[i, j] := 0;

  readln(T);
  for i := 1 to T do
  begin
    readln(N, K, a, b);
    writeln(cached_search(n, k));
  end;
end.
