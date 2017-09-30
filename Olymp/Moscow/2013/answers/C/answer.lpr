program answer;

uses
  Math;

var
  N, p, i, diff: longword;
begin
  readln(N);

  p := 0;
  i := 2;

  while i <= N do
  begin
    i := 2 * i;
    p := p + 1;
  end;

  k := round(power(2,p));
  diff := N - k;
  t := k;

  while N < k + t do
  begin
    t := t div 2;
    q := q + 1;
  end;

  readln();
end.

