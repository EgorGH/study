program answer;

uses
  Math;

const
  MaxQ = 100000;

type
  TRes = record
    x: int64;
    y: int64;
    r: int64;
  end;

var
  a, b, c, d, k, n: int64;

  function min(a, b: int64): int64;
  begin
    if a < b then
      min := a
    else
      min := b;
  end;

  function min(a, b, c: int64): int64;
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

  function analyze(a, b, c, d, k, n: int64): int64;
  var
    x0, y0: int64;
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

  function get_res(x0, delta, a, b, c, d, k, n: int64): TRes;
  begin
    get_res.x := x0 + delta;
    get_res.y := min((k - a * get_res.x) div c, (n - b * get_res.x) div d);
    get_res.r := k + n - a * get_res.x - b * get_res.x - c * get_res.y - d * get_res.y;
  end;

  function full_search(res0, res1, res2: TRes;
    x0, delta, a, b, c, d, k, n: int64): TRes;
  var
    x, min: qword;
    q: longint = 0;
    save: TRes;
    found: boolean = False;
  begin
    x := x0;

    while (k - c * res2.y >= 0) and (n - d * res2.y >= 0) and
      (k - a * res2.x >= 0) and (n - b * res2.x >= 0) and (res0.x >= 0) and
      (res0.y >= 0) and (q < MaxQ) do
    begin
      x := x + delta;

      res0 := get_res(x, 0, a, b, c, d, k, n);
      res1 := get_res(x, -1 * delta, a, b, c, d, k, n);
      res2 := get_res(x, delta, a, b, c, d, k, n);

      if not found or (res0.r < min) then
      begin
        found := True;
        min := res0.r;
        save := res0;
      end;

      q := q + 1;
    end;
    exit(save);
  end;

  function optimal_search(a, b, c, d, k, n: int64): TRes;
  var
    res0, res1, res2, x, y, z: TRes;
    x0: int64;
  begin
    x0 := analyze(a, b, c, d, k, n);

    res0 := get_res(x0, 0, a, b, c, d, k, n);
    res1 := get_res(x0, -1, a, b, c, d, k, n);
    res2 := get_res(x0, 1, a, b, c, d, k, n);

    x := res0;
    y := full_search(res0, res1, res2, x0, 1, a, b, c, d, k, n);
    z := full_search(res0, res2, res1, x0, -1, a, b, c, d, k, n);

    if min(x.r, y.r, z.r) = x.r then
      exit(x)
    else if min(x.r, y.r, z.r) = y.r then
      exit(y)
    else
      exit(z);
  end;

begin
  readln(a, b, c, d);
  readln(k, n);
  writeln(optimal_search(a, b, c, d, k, n).x, ' ', optimal_search(a, b, c, d, k, n).y);
end.
