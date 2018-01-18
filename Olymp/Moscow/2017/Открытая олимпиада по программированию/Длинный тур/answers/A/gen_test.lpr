program gen_test;

uses
  SysUtils;

const
  Lim = 1000000000;

var
  t: longint;
  w, h: int64;

  function max(a, b: int64): int64;
  begin
    if a > b then
      exit(a)
    else
      exit(b);
  end;

  function min(a, b: int64): int64;
  begin
    if a < b then
      exit(a)
    else
      exit(b);
  end;

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

  procedure write_test(t: longint);
  var
    infile, afile: Text;
  begin
    Assign(infile, format('tests/%.2d.', [t]));
    Assign(afile, format('tests/%.2d.a', [t]));
    rewrite(infile);
    rewrite(afile);

    writeln(infile, w, ' ', h);
    writeln(afile, optimal_search());

    Close(infile);
    Close(afile);
  end;

  procedure process_test(maxw, maxh: int64; t: longint);
  begin
    w := random(maxw) + 1;
    h := random(maxh) + 1;
    write_test(t);
  end;

begin
  randomize();

  for t := 2 to 5 do
    process_test(100, 100, t);

  for t := 10 to 12 do
    process_test(10000, 10000, t);

  for t := 20 to 22 do
    process_test(Lim, Lim, t);

  writeln('Done');
end.
