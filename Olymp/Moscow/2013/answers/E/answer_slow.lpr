program answer_slow;

var
  N, K, a, b: integer;

  function f(n, k: integer): integer;
  var
    a, b, i, d, max: integer;
  begin
    max := 0;
    d := 0;
    if n = k then
      exit(0);
    if k = 0 then
      exit(0);
    a := n div 2;
    b := n - n div 2;
    for i := k downto 0 do
      if (i <= a) and (k - i <= b) then
      begin
        d := f(a, i) + f(b, k - i) + 1;
        if d > max then
          max := d;
      end;
    exit(max);
  end;

begin
  readln(N, K);
  writeln(f(n, k));
  readln();
end.
