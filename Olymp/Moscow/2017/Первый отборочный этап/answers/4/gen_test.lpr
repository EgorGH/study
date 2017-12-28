program gen_test;

uses
  SysUtils, math;

const
  Lim = 100000;

var
  k, n, t: longint;
  Data: array[0..Lim] of qword;

  function optimal_search(): qword;
  var
    i: longint;
    time: qword = 0;
  begin
    for i := n downto 1 do
    begin
      time += 2 * i * (Data[i] div k);
      Data[i - 1] += Data[i] mod k;
      time += IfThen(Data[i] mod k > 0, 2, 0);
    end;
    exit(time);
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

    writeln(infile, k);
    writeln(infile, n);
    for i := 1 to n do
      writeln(infile, Data[i]);

    writeln(afile, optimal_search());

    Close(infile);
    Close(afile);
  end;

  procedure process_test(maxk, maxn, maxdata, t: longint);
  var
    i: longint;
  begin
    k := maxk;
    n := maxn;
    for i := 1 to n do
      Data[i] := random(maxdata + 1);
    write_test(t);
  end;

begin
  randomize();

  for t := 10 to 12 do
    process_test(1000000000, 100, 100, t);

  for t := 20 to 22 do
    process_test(1000000000, 100, 1000000000, t);

  for t := 30 to 32 do
    process_test(1000000000, Lim, 1000000000, t);

  for t := 40 to 42 do
    process_test(1, Lim, 1000000000, t);

  writeln('done!');
end.
