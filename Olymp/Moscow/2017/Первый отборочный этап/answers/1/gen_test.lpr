program gen_test;

uses
  SysUtils;

const
  Lim = 2000000000;

var
  t, a, b, c, ans: longint;

  procedure write_test(t, ans: longint);
  var
    infile, afile: Text;
  begin
    Assign(infile, format('tests/%.2d.in', [t]));
    Assign(afile, format('tests/%.2d.a', [t]));
    rewrite(infile);
    rewrite(afile);

    writeln(infile, a);
    writeln(infile, b);
    writeln(infile, c);
    writeln(afile, ans);

    Close(infile);
    Close(afile);
  end;

begin
  randomize();
  for t := 1 to 9 do
  begin
    c := random(10) + 1;
    b := random(100) + 1;
    a := random(b) + 1;

    writeln(a, ' ', b, ' ', c);
    readln(ans);
    write_test(t, ans);
  end;
end.
