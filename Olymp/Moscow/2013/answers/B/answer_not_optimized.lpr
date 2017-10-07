program answer_not_optimized;

uses
  Math;

var
  a, b, c, d, k, n, x, y, r, xmin, ymin, rmin: longint;
begin
  readln(a, b, c, d);
  readln(k, n);

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

  writeln(xmin, ' ', ymin);
  readln();
end.
