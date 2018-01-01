program gen_test;

uses
  SysUtils, math;

const
  Lim = 100000;

var
  t: longint;
  ticket, ans: shortstring;

  procedure write_test(t: longint);
  var
    infile, afile: Text;
  begin
    Assign(infile, format('tests/%.2d.', [t]));
    Assign(afile, format('tests/%.2d.a', [t]));
    rewrite(infile);
    rewrite(afile);

    writeln(infile, ticket);
    writeln(afile, ans);

    Close(infile);
    Close(afile);
  end;

  procedure process_test(maxsize, t: longint);
  var
    s: int64;
  begin
    s := round(power(10, maxsize)) div 2;
    ticket := format('%.*d%.*d', [maxsize, random(s) + 1, maxsize, random(s) + 1]);
    writeln(ticket);
    readln(ans);
    writeln('---');
    write_test(t);
  end;

begin
  randomize();

  for t := 5 to 8 do
    process_test(8, t);

  writeln('done!');
end.
