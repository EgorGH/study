program gen_test;

uses
  SysUtils;

const
  MaxN = 100000;
  MaxK = 100000;
  MaxT = 100000;

var
  n, m, k, i, test: longint;
  t: array[1..MaxT] of longint;

  function optimal_search(): longint;
  var
    i, len, pos: longint;
  begin
    pos := m;
    for i := 1 to k do
    begin
      len := t[i] mod n;
      if len + 1 > pos then
        pos += 1
      else if len + 1 = pos then
        pos := 1;
    end;
    exit(pos);
  end;

  procedure write_test(test: longint);
  var
    infile, afile: Text;
  begin
    Assign(infile, format('tests/%.2d.in', [test]));
    Assign(afile, format('tests/%.2d.a', [test]));
    rewrite(infile);
    rewrite(afile);

    writeln(infile, n);
    writeln(infile, m);
    writeln(infile, k);
    for i := 1 to k do
      writeln(infile, t[i]);
    writeln(afile, optimal_search());

    Close(infile);
    Close(afile);
  end;

begin
  randomize();
  for test := 1 to 9 do
  begin
    n := random(3) + 1;
    m := random(n) + 1;
    k := random(3) + 1;
    for i := 1 to k do
      t[i] := random(n - 1) + 1;

    write_test(test);
  end;

  for test := 10 to 19 do
  begin
    n := random(100) + 1;
    m := random(n) + 1;
    k := random(100) + 1;
    for i := 1 to k do
      t[i] := random(MaxT) + 1;

    write_test(test);
  end;

  for test := 20 to 22 do
  begin
    n := random(MaxN) + 1;
    m := random(n) + 1;
    k := random(MaxK) + 1;
    for i := 1 to k do
      t[i] := random(MaxT) + 1;

    write_test(test);
  end;
  writeln('Done');
end.
