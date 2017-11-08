program answer;

var
  a, b: longint;

  function get_sum(x, y: longint): longint;
  var
    sum: longint = 0;
  begin
    while x > 0 do
    begin
      sum := sum + (x mod y);
      x := x div y;
    end;
    exit(sum);
  end;

  function full_search(a, b: longint): longint;
  var
    k, sumA, sumB: longint;
  begin
    k := 9;
    repeat
      k := k + 1;
      sumA := get_sum(k, a);
      sumB := get_sum(k, b);
    until sumA = sumB;
    exit(k);
  end;

  function optimal_search(a, b: longint): longint;
  var
    c, k, n, sumA, sumB: longint;
  begin
    if a > b then
    begin
      c := a;
      a := b;
      b := c;
    end;

    if (b < 10) then
      exit(full_search(a, b));

    if (a > 10) then
      exit(10);

    k := 10;
    n := 1;
    repeat
      sumA := get_sum(k, a);
      sumB := get_sum(k, b);

      if sumA < sumB then
      begin
        k := n * b;
        n := n + 1;
      end
      else
        k := k + 1;
    until sumA = sumB;
    exit(k - 1);
  end;

begin
  while not EOF(input) do
  begin
    readln(a, b);
    writeln(optimal_search(a, b));
  end;
end.

