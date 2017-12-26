program gen_test;

uses
  SysUtils;

const Lim = 100000;

var
  n, m, k, i, t: longint;
  data: array[1..Lim] of longint;

  function optimal_search(): longint;
  var
    i, idx, pos: longint;
  begin
    pos := m;
    for i := 1 to k do
    begin
      idx := data[i] mod n + 1;
      if idx > pos then
        pos += 1
      else if idx = pos then
        pos := 1;
    end;
    exit(pos);
  end;

  procedure write_test(test: longint);
  var
    infile, afile: Text;
  begin
    Assign(infile, format('tests/%.2d.', [test]));
    Assign(afile, format('tests/%.2d.a', [test]));
    rewrite(infile);
    rewrite(afile);

    writeln(infile, n);
    writeln(infile, m);
    writeln(infile, k);
    for i := 1 to k do
      writeln(infile, data[i]);
    writeln(afile, optimal_search());

    Close(infile);
    Close(afile);
  end;

  procedure process_test(maxn, maxk, maxt, t:longint);
  begin
    n := maxn;
    m := random(n) + 1;
    k := maxk;
    for i := 1 to k do
      data[i] := random(maxt) + 1;
    write_test(t);
  end;

begin
  randomize();

  for t := 10 to 12 do
    process_test(3, 3, 2, t);

  for t := 20 to 22 do
    process_test(100, 100, 300, t);

  for t := 30 to 32 do
    process_test(Lim, Lim, Lim, t);

  writeln('Done');
end.
