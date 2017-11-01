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
  i: longint;
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

  function min(a, b: longint): longint;
  begin
    if a < b then
      min := a
    else
      min := b;
  end;

  function min(a, b, c: longint): longint;
  begin
    if a < b then
      if a < c then
        min := a
      else
        min := c
    else
    if b < c then
      min := b
    else
      min := c;
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

  function analyze(a, b, c, d, k, n: longint): longint;
  var
    x0, y0: longint;
  begin
    if a * d - b * c = 0 then
      exit(0);

    x0 := (k * d - n * c) div (a * d - b * c);
    y0 := min((k - a * x0) div c, (n - b * x0) div d);

    while (x0 < 0) or (k < c * y0) or (n < d * y0) do
    begin
      y0 := y0 - 1;
      x0 := min((k - c * y0) div a, (n - d * y0) div b);
    end;

    while (y0 < 0) or (k < a * x0) or (n < b * x0) do
    begin
      x0 := x0 - 1;
      y0 := min((k - a * x0) div c, (n - b * x0) div d);
    end;

    if x0 < 0 then
      exit(0)
    else
      exit(x0);
  end;

  function get_res(x0, a, b, c, d, k, n: longint): TRes;
  begin
    get_res.x := x0;
    get_res.y := min((k - a * get_res.x) div c, (n - b * get_res.x) div d);
    get_res.r := k + n - a * get_res.x - b * get_res.x - c * get_res.y - d * get_res.y;
  end;

  function full_search(x0, delta, a, b, c, d, k, n: longint): TRes;
  var
    x, min: longint;
    q: longint = 0;
    res_cur, res_prev: TRes;
    found: boolean = False;
  begin
    x := x0;
    res_cur := get_res(x, a, b, c, d, k, n);

    while (k - c * res_cur.y >= 0) and (n - d * res_cur.y >= 0) and
      (k - a * res_cur.x >= 0) and (n - b * res_cur.x >= 0) and (res_cur.x >= 0) and
      (res_cur.y >= 0) and (q <= MaxQ) do
    begin
      x := x + delta;
      res_prev := res_cur;
      res_cur := get_res(x, a, b, c, d, k, n);

      if not found or (res_prev.r < min) then
      begin
        found := True;
        min := res_prev.r;
        full_search := res_prev;
      end;

      q := q + 1;
    end;
  end;

  function optimal_search(a, b, c, d, k, n: longint): TRes;
  var
    x, y, z: TRes;
    x0: longint;
  begin
    x0 := analyze(a, b, c, d, k, n);

    if x0 = 0 then
      exit(full_search(x0, 1, a, b, c, d, k, n));

    x := get_res(x0, a, b, c, d, k, n);
    y := full_search(x0, 1, a, b, c, d, k, n);
    z := full_search(x0, -1, a, b, c, d, k, n);

    if min(x.r, y.r, z.r) = x.r then
      exit(x)
    else if min(x.r, y.r, z.r) = y.r then
      exit(y)
    else
      exit(z);
  end;

begin
  randomize();
  for i := 1 to MaxT do
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
