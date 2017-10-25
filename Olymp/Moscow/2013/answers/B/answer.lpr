program answer;

uses
  Math;

var
  a, b, c, d, k, n, x, y: qword;
begin
  readln(a, b, c, d);
  readln(k, n);

  x := (n * c - d * k) div (b * c - d * a);

  if (k - a * x) div c > (n - b * x) div d then
    y := (n - b * x) div d
  else
    y := (k - a * x) div c;

  writeln(x, ' ', y);
end.
