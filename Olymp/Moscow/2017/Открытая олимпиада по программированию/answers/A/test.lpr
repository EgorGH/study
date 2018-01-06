program test;

uses
  SysUtils, math;

const
  MaxT = 100000;

var
  t: longint;
  w, h: int64;

  function optimal_search(): int64;
  var
    a, b, c: int64;
  begin
    if w = h then
      exit(w * w);

    a := max(w, h);
    b := min(w, h);
    c := min(a - b, b);

    exit(b * b + c * c);
  end;

  function full_search(): int64;
  var
    i, j: longint;
    smax: int64;
  begin
    smax := 0;
    for i := 1 to min(w, h) do
      for j := 0 to min(i, max(w, h) - i) do
        if i * i + j * j > smax then
          smax := i * i + j * j;
    exit(smax);
  end;

  function process_test(maxw, maxh: int64; t: longint): boolean;
  begin
    w := random(maxw) + 1;
    h := random(maxh) + 1;
    exit(full_search() = optimal_search());
  end;

begin
  randomize();

  for t := 1 to MaxT do
    process_test(100, 100, t);

  writeln('Done');
end.
