program test;

uses
  Math;

const
  MaxT = 10000;
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

  function partial_search(a, b, c, d, k, n: int64): TRes;
  var
    xp, yp: real;
    x, y, r, x1, x2, y1, y2, r1, r2: int64;
  begin
    if (a * d - b * c) = 0 then
    begin
      x := 0;
      y := min(k div c, n div d);
      r := k + n - a * x - b * x - c * y - d * y;
    end
    else if (k * d - n * c) / (a * d - b * c) < 0 then
    begin
      x1 := 0;
      y1 := min(k div c, n div d);
      r1 := k + n - a * x1 - b * x1 - c * y1 - d * y1;

      x2 := 1;
      y2 := min((k - a * x2) div c, (n - b * x2) div d);
      r2 := k + n - a * x1 - b * x1 - c * y1 - d * y1;

      if r1 < r2 then
        while (r1 < r2) do
        begin
          x2 := x1;
          y2 := y1;
          r2 := r1;

          x1 := x1 + 1;
          y1 := min((k - a * x1) div c, (n - b * x1) div d);
          r1 := k + n - a * x1 - b * x1 - c * y1 - d * y1;
        end

      else
        while (r2 < r1) do
        begin
          x2 := x1;
          y2 := y1;
          r2 := r1;

          x1 := x1 + 1;
          y1 := min((k - a * x1) div c, (n - b * x1) div d);
          r1 := k + n - a * x1 - b * x1 - c * y1 - d * y1;
        end;

      if r1 < r2 then
      begin
        x := x1;
        y := y1;
        r := r1;
      end
      else
      begin
        x := x2;
        y := y2;
        r := r2;
      end;
      partial_search.x := x;
      partial_search.y := y;
      partial_search.r := r;
    end
    else
    if (a * n - b * k) / (a * d - b * c) < 0 then
    begin
      y1 := 0;
      x1 := min(k div a, n div b);
      r1 := k + n - a * x1 - b * x1 - c * y1 - d * y1;

      y2 := 1;
      x2 := min((k - c * y2) div a, (n - d * y2) div b);
      r2 := k + n - a * x2 - b * x2 - c * y2 - d * y2;

      if r1 < r2 then
        while (r1 < r2) do
        begin
          x2 := x1;
          y2 := y1;
          r2 := r1;

          y1 := y1 + 1;
          x1 := min((k - c * y1) div a, (n - d * y1) div b);
          r1 := k + n - a * x1 - b * x1 - c * y1 - d * y1;
        end

      else
        while (r2 < r1) do
        begin
          x2 := x1;
          y2 := y1;
          r2 := r1;

          y1 := y1 + 1;
          x1 := min((k - c * y1) div a, (n - d * y1) div b);
          r1 := k + n - a * x1 - b * x1 - c * y1 - d * y1;
        end;

      if r1 < r2 then
      begin
        x := x1;
        y := y1;
        r := r1;
      end
      else
      begin
        x := x2;
        y := y2;
        r := r2;
      end;
      partial_search.x := x;
      partial_search.y := y;
      partial_search.r := r;
    end
    else
    begin
      xp := (k * d - n * c) / (a * d - b * c);

      x1 := floor(xp);
      y1 := min((k - a * x1) div c, (n - b * x1) div d);
      r1 := k + n - a * x1 - b * x1 - c * y1 - d * y1;

      x2 := ceil(xp);
      y2 := min((k - a * x2) div c, (n - b * x2) div d);
      r2 := k + n - a * x2 - b * x2 - c * y2 - d * y2;

      if (r1 < r2) then
        while r1 < r2 do
        begin
          x2 := x1;
          y2 := y1;
          r2 := r1;

          x1 := x1 - 1;
          y1 := min((k - a * x1) div c, (n - b * x1) div d);
          r1 := k + n - a * x1 - b * x1 - c * y1 - d * y1;
        end

      else
        while r1 >= r2 do
        begin
          x2 := x1;
          y2 := y1;
          r2 := r1;

          x1 := x1 + 1;
          y1 := min((k - a * x1) div c, (n - b * x1) div d);
          r1 := k + n - a * x1 - b * x1 - c * y1 - d * y1;
        end;

      if (r1 < r2) then
      begin
        x := x1;
        y := y1;
        r := r1;
      end
      else
      begin
        x := x2;
        y := y2;
        r := r2;
      end;
    end;
    partial_search.x := x;
    partial_search.y := y;
    partial_search.r := r;
  end;

begin
  randomize();
  for i := 1 to MaxT do
  begin
    init();
    r1 := full_search(a, b, c, d, k, n);
    r2 := full_search(b, a, d, c, n, k);
    r3 := partial_search(a, b, c, d, k, n);
    if (r1.r <> r2.r) or (r1.r <> r3.r) then
    begin
      writeln(a, ' ', b, ' ', c, ' ', d, ' ', k, ' ', n);
      writeln(r1.r, ' ', r2.r, ' ', r3.r);
      writeln('Error');
    end;
  end;
  //a := 50;
  //b := 4;
  //c := 60;
  //d := 41;
  //k := 935;
  //n := 80;
  //writeln(full_search(a, b, c, d, k, n).r, ' ', full_search(a, b, c, d, k, n).x,
  //  ' ', full_search(a, b, c, d, k, n).y);
  //writeln(partial_search(a, b, c, d, k, n).r, ' ', partial_search(a, b, c, d, k, n).x,
  //  ' ', partial_search(a, b, c, d, k, n).y);
  writeln('Done');
  readln();
end.
