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

    writeln(infile, n, ' ', m);
    for i := 1 to m do
      writeln(infile, random(n) + 1, ' ', random(n) + 1, ' ', random(15) + 1);
    writeln(infile, q);
    for i := 1 to q do
    begin
      a := random(3) + 1;
      write(infile, a, ' ');
      if a = 1 then
        writeln(infile, random(n) + 1, ' ', random(n) + 1, ' ', random(15) + 1)
      else
        writeln(infile, random(n) + 1, ' ', random(n) + 1, ' ');
    end;

    writeln(afile, 0);

    Close(infile);
    Close(afile);
  end;

  procedure process_test(maxn, maxm, maxq: int64; t: longint);
  begin
    n := maxn;
    m := maxm;
    q := maxq;
    write_test(t);
  end;

begin
  randomize();

  for t := 2 to 5 do
    process_test(7, 10, 25, t);

  writeln('Done');
end.
