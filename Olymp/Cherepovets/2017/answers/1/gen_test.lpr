program gen_test;

uses
  SysUtils;

var
  m, n, p, q, t: longint;
  ans: int64;

  procedure write_test(t: longint);
  var
    infile, afile: Text;
  begin
    Assign(infile, format('tests/%.2d.in', [t]));
    Assign(afile, format('tests/%.2d.a', [t]));
    Rewrite(infile);
    Rewrite(afile);
    writeln(infile, m, ' ', n, ' ', p, ' ', q);
    Writeln(afile, ans);
    Close(infile);
    Close(afile);
  end;

  function optimal_search(m, n, p, q: int64): int64;
  begin
    exit(p * q * (m - p + 1) * (n - q + 1));
  end;

begin
  randomize();
  for t := 1 to 9 do
  begin
    m := random(100) + 1;
    n := random(100) + 1;
    p := random(m) + 1;
    q := random(n) + 1;
    ans := optimal_search(m, n, p, q);
    write_test(t);
  end;

  for t := 10 to 19 do
  begin
    m := 10000;
    n := 10000;
    p := random(m) + 1;
    q := random(n) + 1;
    ans := optimal_search(m, n, p, q);
    write_test(t);
  end;
  writeln('Done');
end.
