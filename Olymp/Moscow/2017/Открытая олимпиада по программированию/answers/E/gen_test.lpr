program gen_test;

uses
  SysUtils;

const
  Lim = 100000;

var
  t, n, k: longint;
  data: array[1..Lim] of int64;

  procedure optimal_search();
  var
    i: longint;
  begin
    for i := 2 to n do
      if data[i] - data[i - 1] < k then
        data[i] := data[i - 1] + k;
  end;

  procedure write_test(t: longint);
  var
    infile, afile: Text;
    i: longint;
  begin
    Assign(infile, format('tests/%.2d.', [t]));
    Assign(afile, format('tests/%.2d.a', [t]));
    rewrite(infile);
    rewrite(afile);

    writeln(infile, n, ' ', k);
    for i := 1 to n do
      write(infile, data[i], ' ');
    writeln(infile);
    optimal_search();
    for i := 1 to n do
      write(afile, data[i], ' ');

    Close(infile);
    Close(afile);
  end;

  procedure process_test(maxn, maxk: longint; maxdata: int64; t: longint);
  var
    i: longint;
  begin
    n := maxn;
    k := maxk;
    data[n] := random(maxdata) + 1;
    for i := n - 1 downto 1 do
      data[i] := random(data[i + 1]) + 1;
    write_test(t);
  end;

begin
  randomize();

  for t := 1 to 5 do
    process_test(100, 100, 100, t);

  for t := 10 to 12 do
    process_test(100000, 1000000000, 1000000000000000000, t);

  writeln('Done');
end.
