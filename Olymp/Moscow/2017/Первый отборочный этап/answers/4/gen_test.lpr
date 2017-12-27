program gen_test;

uses
  SysUtils;

const
  Lim = 100;

var
  k, n, t, ans: longint;
  Data: array[1..Lim] of longint;

  procedure write_test(t, ans: longint);
  var
    infile, afile: Text;
    i: longint;
  begin
    Assign(infile, format('tests/%.2d.', [t]));
    Assign(afile, format('tests/%.2d.a', [t]));
    rewrite(infile);
    rewrite(afile);

    writeln(infile, k);
    writeln(infile, n);
    for i := 1 to n do
      writeln(infile, data[i]);

    writeln(afile, ans);

    Close(infile);
    Close(afile);
  end;

  procedure process_test(maxk, maxn, maxdata, t: longint);
  var
    i: longint;
  begin
    k := maxk;
    n := maxn;
    writeln(k, ' ', n);
    for i:= 1 to n do
    begin
      data[i] := random(maxdata + 1);
      writeln(data[i]);
    end;
    readln(ans);
    write_test(t, ans);
    writeln('=============');
  end;

begin
  randomize();

  for t := 1 to 5 do
    process_test(3, 5, 5, t);

  //for t := 20 to 22 do
  //  process_test(100, 100, 300, t);

  //for t := 30 to 32 do
  //  process_test(Lim, Lim, Lim, t);

  writeln('Done');
end.
