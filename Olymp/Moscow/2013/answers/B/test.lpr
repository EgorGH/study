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
  a, b, c, d, n, k, i: longint;

  procedure init();
  begin
    a := random(Max) + 1;
    b := random(Max) + 1;
    c := random(Max) + 1;
    d := random(Max) + 1;
    k := random(RMax) + 1;
    n := random(RMax) + 1;
  end;

  function f(): TRes;
  var
    x1, y1, r1, x2, y2, r2, xmin1, ymin1, rmin1, xmin2, ymin2, rmin2: longint;
  begin
    x1 := 0;
    y1 := min(k div c, n div d);
    xmin1 := x1;
    ymin1 := y1;
    rmin1 := k + n - c * ymin1 - d * ymin1;

    while x1 < min(k div a, n div b) do
    begin
      x1 := x1 + 1;
      y1 := min((k - a * x1) div c, (n - b * x1) div d);
      r1 := k + n - a * x1 - b * x1 - c * y1 - d * y1;
      if r1 < rmin1 then
      begin
        rmin1 := r1;
        xmin1 := x1;
        ymin1 := y1;
      end;
    end;

    y2 := 0;
    x2 := min(k div a, n div b);
    xmin2 := x2;
    ymin2 := y2;
    rmin2 := k + n - a * xmin2 - b * xmin2;

    while y2 < min(k div c, n div d) do
    begin
      y2 := y2 + 1;
      x2 := min((k - c * y2) div a, (n - d * y2) div b);
      r2 := k + n - a * x2 - b * x2 - c * y2 - d * y2;
      if r2 < rmin2 then
      begin
        rmin2 := r2;
        xmin2 := x2;
        ymin2 := y2;
      end;
    end;

    if rmin1 < rmin2 then
    begin
      f.x := xmin1;
      f.y := ymin1;
      f.r := rmin1;
    end
    else
    begin
      f.x := xmin2;
      f.y := ymin2;
      f.r := rmin2;
    end;
  end;

  function g(): TRes;
  var
    x, y, r: longint;
  begin
    if ((a * d - b * c) = 0) or ((d * k - c * n) div (a * d - b * c) <= 0) then
    begin
      x := 0;
      y := min(k div c, n div d);
    end
    else
    if (a * n - b * k) div (a * d - b * c) < 0 then
    begin
      x := min(k div a, n div b);
      y := 0;
    end
    else
    begin
      x := (n * c - d * k) div (b * c - a * d);
      y := min((k - a * x) div c, (n - b * x) div d);
    end;
    r := k + n - a * x - b * x - c * y - d * y;
    g.x := x;
    g.y := y;
    g.r := r;
  end;

begin
  randomize;
  for i := 1 to MaxT do
  begin
    init();
    if f().r <> g().r then
    begin
      writeln(a, ' ', b, ' ', c, ' ', d, ' ', k, ' ', n);
      writeln(f().r, ' ', g().r);
      writeln('Error');
    end;
  end;
  //a := 82;
  //b := 14;
  //c := 73;
  //d := 17;
  //k := 944;
  //n := 206;
  //writeln(f().x, ' ', f().y, ' ', f().r);
  //writeln(g().x, ' ', g().y, ' ', g().r);
  writeln('Done');
  readln();
end.
