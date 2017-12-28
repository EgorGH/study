program gen_test;

uses
  SysUtils;

const
  Lim = 2000000000;

var
  t, a, b, c: longint;

  function flights_count(x: longint; include: boolean): longint;
  begin
    flights_count := x div c;
    if not include and (x mod c = 0) then
      flights_count -= 1;
  end;

  function optimal_search(): longint;
  begin
    exit(flights_count(b, True) - flights_count(a, False));
  end;

  procedure write_test(t: longint);
  var
    infile, afile: Text;
  begin
    Assign(infile, format('tests/%.2d.', [t]));
    Assign(afile, format('tests/%.2d.a', [t]));
    rewrite(infile);
    rewrite(afile);

    writeln(infile, a);
    writeln(infile, b);
    writeln(infile, c);
    writeln(afile, optimal_search());

    Close(infile);
    Close(afile);
  end;

  procedure process_test(maxa, maxb, maxc, t: longint);
  begin
    a := maxa;
    b := maxb;
    c := random(maxc) + 1;
    write_test(t);
  end;

begin
  randomize();

  for t := 1 to 5 do
    process_test(100, 200, 50, t);

  for t := 10 to 12 do
    process_test(5000, 10000, 100, t);

  for t := 20 to 22 do
    process_test(Lim div 2, Lim, 10000, t);

  writeln('Done');
end.
