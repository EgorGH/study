program gen_test;

uses
  SysUtils;

var
  t: longint;
  n, m, q: longint;

  procedure write_test(t: longint);
  var
    infile, afile: Text;
    i, a: longint;
  begin
    Assign(infile, format('tests/%.2d.', [t]));
    Assign(afile, format('tests/%.2d.a', [t]));
    rewrite(infile);
    rewrite(afile);

    writeln(infile, n, ' ', m, ' ', q, ' ', k);
    for i := 1 to m do
      writeln(infile, random(k) + 1);
    for i := 1 to n do
      for j := 1 to m do
        write(infile,

    writeln(afile, 0);

    Close(infile);
    Close(afile);
  end;

  procedure process_test(maxn, maxm, maxq, maxk: longint; t: longint);
  begin
    n := maxn;
    m := maxm;
    q := maxq;
    k := maxk;
    write_test(t);
  end;

begin
  randomize();

  for t := 2 to 5 do
    process_test(7, 10, 25, t);

  writeln('Done');
end.
