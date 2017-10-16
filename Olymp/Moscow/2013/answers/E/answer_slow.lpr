program answer_slow;

var
  T, N, K, a, b, i: integer;

  function f(n, k: integer): integer;
  var
    a, b, i, d, w, max, min: integer;
  begin
    max := 0;
    min := 100;
    if (n = k) or (k = 0) then
      exit(0);
    for w := 1 to n - 1 do
    begin
      a := w;
      b := n - w;
      for i := 0 to k do
        if (i <= a) and (k - i <= b) then
        begin
          d := f(a, i) + f(b, k - i) + 1;
          if d > max then
            max := d;
        end;
      if max < min then
        min := max;
    end;
    exit(min);
  end;

begin
  //readln(T);
  //for i := 1 to T do
  //begin
  //  readln(N, K, a, b);
  //  writeln(f(n, k));
  //end;
  writeln(f(10, 2));
  readln();
end.
