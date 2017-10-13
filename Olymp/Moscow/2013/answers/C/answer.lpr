program answer;

uses
  Math;
var
  N, ans, k, p: qword;

  procedure f(m, v: qword);
  var
    d: qword;
  begin
    d := (v - m) div 2 + m;

    if (N = d) or (v - d = 1) then
      exit();

    if N > d then
    begin
      ans := ans * 2;
      f(d, v);
    end;

    if N < d then
      f(m, d);
  end;

begin
  readln(N);

  k := 1;
  p := 0;
  ans := 1;

  while k < N / 2 do
  begin
    k := 2 * k;
    p := p + 1;
  end;

  if N = 2 * k then
    ans := 1
  else
  begin
    ans := ans * 2;
    f(k, k * 2);
  end;

  writeln(ans);
  readln();
end.

