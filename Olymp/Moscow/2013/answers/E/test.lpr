program test;

const
  MaxT = 1000;
  Max = 10;

var
  i, n, k, min1, min2: longint;

  procedure init();
  begin
    n := random(Max) + 1;
    k := random(n) + 1;
  end;

  function f(n, k: integer): integer;
  var
    a, b, i, d, w, max, min: integer;
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
          d := f(a, i) + f(b, k - i) + 1;
          if d > max then
            max := d;
        end;
      if max < min then
        min := max;
    end;
    exit(min);
  end;

  function g(n, k: integer): integer;
  var
    a, b, i, d, w, max, min: integer;
    m: array[1..100, 1..100] of integer;
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
            d := f(a, i) + f(b, k - i) + 1;
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
  randomize();
  for i := 1 to MaxT do
  begin
    init();
    min1 := f(n, k);
    min2 := g(n, k);
    if min1 <> min2 then
      writeln('Error! ', n, ' ', k, ' ', min1, ' ', min2);
  end;
  writeln('All tests passed');
end.
