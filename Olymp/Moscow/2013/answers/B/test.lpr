program test;

uses
  Math;

const
  MaxT = 1000000;
  MaxABCD = 100;
  MaxR = 1000;
  MaxQ = 1000000;

type
  TRes = record
    x: longint;
    y: longint;
    r: longint;
  end;
var
  a, b, c, d, k, n: longint;
  t: longint;
  r1, r2, r3: TRes;

  procedure init();
  begin
    a := random(MaxABCD) + 1;
    b := random(MaxABCD) + 1;
    c := random(MaxABCD) + 1;
    d := random(MaxABCD) + 1;
    k := random(MaxR) + 1;
    n := random(MaxR) + 1;
  end;

  function full_search(a, b, c, d, k, n: longint): TRes;
  var
    x, y, r, xmin, ymin, rmin: longint;
  begin
    x := 0;
    y := min(k div c, n div d);

    xmin := x;
    ymin := y;
    rmin := k + n - c * ymin - d * ymin;

    while x < min(k div a, n div b) do
    begin
      x := x + 1;
      y := min((k - a * x) div c, (n - b * x) div d);
      r := k + n - a * x - b * x - c * y - d * y;
      if r < rmin then
      begin
        rmin := r;
        xmin := x;
        ymin := y;
      end;
    end;

    full_search.x := xmin;
    full_search.y := ymin;
    full_search.r := rmin;
  end;

  function full_search(start, finish, delta, a, b, c, d, k, n: longint): TRes;
  var
    x, y, r, xmin, ymin, rmin: longint;
    q: longint = 0;
  begin
    x := start;
    y := min((k - a * x) div c, (n - b * x) div d);
    r := k + n - a * x - b * x - c * y - d * y;

    xmin := x;
    ymin := y;
    rmin := r;

    while (x * delta < finish * delta) and (q < MaxQ) do
    begin
      q := q + 1;

      x := x + delta;
      y := min((k - a * x) div c, (n - b * x) div d);
      r := k + n - a * x - b * x - c * y - d * y;
      if r < rmin then
      begin
        rmin := r;
        xmin := x;
        ymin := y;
      end;
    end;

    full_search.x := xmin;
    full_search.y := ymin;
    full_search.r := rmin;
  end;

  function optimal_search(a, b, c, d, k, n, start: longint): TRes;
  var
    x, y: TRes;
    finish: longint;
  begin
    finish := min(k div a, n div b);
    x := full_search(start, finish, 1, a, b, c, d, k, n);
    y := full_search(start, 0, -1, a, b, c, d, k, n);

    if x.r < y.r then
      exit(x)
    else
      exit(y);
  end;

  function correct_start(a, b, c, d, k, n, x: longint): longint;
  var
    y: longint;
  begin
    y := min((k - a * x) div c, (n - b * x) div d);

    while (y < 0) or (k < a * x) or (n < b * x) do
    begin
      x := x - 1;
      y := min((k - a * x) div c, (n - b * x) div d);
    end;

    exit(x);
  end;

  function optimal_search(a, b, c, d, k, n: longint): TRes;
  var
    x, y, t: longint;
    res: TRes;
  begin
    if (a > k) and (c > k) or (b > n) and (d > n) then
    begin
      res.x := 0;
      res.y := 0;
      res.r := k + n;
      exit(res);
    end;

    if a * d - b * c = 0 then
    begin
      x := 0;
      res := full_search(x, min(k div a, n div b), 1, a, b, c, d, k, n);
      exit();
    end;

    x := (k * d - n * c) div (a * d - b * c);
    y := (k * b - a * n) div (c * b - a * d);

    if x < 0 then
    begin
      y := correct_start(c, d, a, b, k, n, y);

      res := optimal_search(c, d, a, b, k, n, y);

      t := res.x;
      res.x := res.y;
      res.y := t;
    end
    else
    begin
      x := correct_start(a, b, c, d, k, n, x);

      res := optimal_search(a, b, c, d, k, n, x);
    end;

    exit(res);
  end;

begin
  randomize();
  for t := 1 to MaxT do
  begin
    init();
    r1 := full_search(a, b, c, d, k, n);
    r2 := full_search(b, a, d, c, n, k);
    r3 := optimal_search(a, b, c, d, k, n);
    if (r1.r <> r2.r) or (r1.r <> r3.r) then
      writeln('Error');
  end;
  writeln('Done');
end.
