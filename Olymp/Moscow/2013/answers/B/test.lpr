program test;

uses
  Math;

const
  MaxT = 1000000;
  Max = 100;
  RMax = 1000;

type
  TRes = record
    x: longint;
    y: longint;
    r: longint;
  end;
var
  a, b, c, d, k, n: int64;
  i: longint;
  r1, r2, r3: TRes;

  procedure init();
  begin
    a := int64(random(Max)) + 1;
    b := int64(random(Max)) + 1;
    c := int64(random(Max)) + 1;
    d := int64(random(Max)) + 1;
    k := int64(random(RMax)) + 1;
    n := int64(random(RMax)) + 1;
  end;

  function min(a, b: int64): int64;
  begin
    if (a < b) then
      min := a
    else
      min := b;
  end;

  function full_search(a, b, c, d, k, n: int64): TRes;
  var
    x, y, r, xmin, ymin, rmin: int64;
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
    if (a * d - b * c) = 0 then
      exit(0);

    x0 := floor((k * d - n * c) / (a * d - b * c));
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

    if (x0 < 0) then
      exit(0);

    exit(x0);
  end;

  function f(x0, delta, a, b, c, d, k, n: longint): TRes;
  begin
    f.x := x0 + delta;
    f.y := min((k - a * f.x) div c, (n - b * f.x) div d);
    f.r := k + n - a * f.x - b * f.x - c * f.y - d * f.y;
  end;

  function optimal_search(a, b, c, d, k, n: longint): TRes;
  var
    res0, res1, res2, save, save0, save1, save2: TRes;
    min0, min1, min2, x0: longint;
    qa: integer = 0;
    qb: integer = 0;
  begin
    x0 := analyze(a, b, c, d, k, n);
    if x0 = 0 then
      exit(full_search(a, b, c, d, k, n));

    res0 := f(x0, 0, a, b, c, d, k, n);
    res1 := f(x0, -1, a, b, c, d, k, n);
    res2 := f(x0, 1, a, b, c, d, k, n);

    save0 := res0;
    save := res0;
    min0 := res0.r;

    while (k - c * res2.y >= 0) and (n - d * res2.y >= 0) and
      (k - a * res2.x >= 0) and (n - b * res2.x >= 0) and (res0.x >= 0) and
      (res0.y >= 0) and (qa < 30) do
    begin
      x0 := x0 + 1;

      res0 := f(x0, 0, a, b, c, d, k, n);
      res1 := f(x0, -1, a, b, c, d, k, n);
      res2 := f(x0, 1, a, b, c, d, k, n);

      if (res0.r <= res2.r) and (res0.r <= res1.r) then
      begin
        qa := qa + 1;
        if res0.r < min0 then
        begin
          min0 := res0.r;
          save0 := res0;
        end;
      end;
    end;

    min1 := res0.r;
    save1 := res0;

    x0 := save.x;
    res0 := f(x0, 0, a, b, c, d, k, n);
    res1 := f(x0, -1, a, b, c, d, k, n);
    res2 := f(x0, 1, a, b, c, d, k, n);

    while (k - c * res1.y >= 0) and (n - d * res1.y >= 0) and
      (k - a * res1.x >= 0) and (n - b * res1.x >= 0) and (res0.x >= 0) and
      (res0.y >= 0) and (qb < 30) do
    begin
      x0 := x0 - 1;

      res0 := f(x0, 0, a, b, c, d, k, n);
      res1 := f(x0, -1, a, b, c, d, k, n);
      res2 := f(x0, 1, a, b, c, d, k, n);

      if (res0.r <= res2.r) and (res0.r <= res1.r) then
      begin
        qb := qb + 1;
        if res0.r < min0 then
        begin
          min0 := res0.r;
          save0 := res0;
        end;
      end;
    end;

    min2 := res0.r;
    save2 := res0;

    if min2 < min1 then
      if min2 < min0 then
        optimal_search := save2
      else
        optimal_search := save0
    else
    if min1 < min0 then
      optimal_search := save1
    else
      optimal_search := save0;
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
    begin
      writeln(a, ' ', b, ' ', c, ' ', d, ' ', k, ' ', n);
      writeln(r1.r, ' ', r2.r, ' ', r3.r);
      r3 := optimal_search(a, b, c, d, k, n);
      writeln('Error');
    end;
  end;
  writeln('Done');
end.
