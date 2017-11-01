program answer;

const
  Lim = 100;
var
  T, N, K, a, b, i, j: longint;
  m: array[1..Lim, 1..Lim] of longint;

  function optimal_search(n, k: longint): longint;
  var
    a, b, i, d, w, max, min: longint;
  begin
    if m[n, k] <> 0 then
      exit(m[n, k])
    else
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
            d := optimal_search(a, i) + optimal_search(b, k - i) + 1;
            if d > max then
              max := d;
          end;
        if max < min then
          min := max;
      end;
      m[n, k] := min;
      exit(min);
    end;
  end;

begin
  for i := 1 to Lim do
    for j := 1 to Lim do
      m[i, j] := 0;

  readln(T);
  for i := 1 to T do
  begin
    readln(N, K, a, b);
    writeln(optimal_search(n, k));
  end;
end.
