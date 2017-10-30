program answer_slow;

uses
  Math;

type
  TRes = record
    x: longint;
    y: longint;
    r: longint;
  end;

var
  a, b, c, d, k, n: longint;

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

begin
  readln(a, b, c, d);
  readln(k, n);
  writeln(full_search(a, b, c, d, k, n).x, ' ', full_search(a, b, c, d, k, n).y);
end.
