program gen_test;

uses
  SysUtils,
  StrUtils;

const
  Lim = 100;

var
  n, m, t: longint;
  Data: array[1..Lim, 1..Lim] of longint;

  procedure randomize_data();
  var
    i, j: longint;
  begin
    for i := 1 to n + 1 do
      for j := 1 to m do
        Data[i, j] := random(2);
  end;

  procedure print_data(var dst: Text; to_file: boolean);
  var
    i, j: longint;
  begin
    writeln(dst, n);
    if not to_file then
    begin
      write('': 3);
      for i := 1 to m do
        write(i: 3);
      writeln();
    end;
    for i := 1 to n + 1 do
    begin
      if not to_file then
        write(i: 3);
      for j := 1 to m do
        if to_file then
          Write(dst, IfThen(data[i, j] = 1, IntToStr(j) + ' ', ''))
        else
          write(IfThen(data[i, j] = 1, '1', ''): 3);
      writeln(dst);
    end;
  end;

  procedure write_test(test: longint; var always, often: ansistring);
  var
    infile, afile: Text;
  begin
    Assign(infile, format('tests/%.2d.', [test]));
    Assign(afile, format('tests/%.2d.a', [test]));
    rewrite(infile);
    rewrite(afile);

    print_data(infile, true);

    writeln(afile, always);
    writeln(afile, often);

    Close(infile);
    Close(afile);
  end;

  procedure process_test(maxn, maxm, t: longint);
  var
    always, often: ansistring;
  begin
    n := maxn;
    m := maxm;
    randomize_data();
    print_data(output, false);
    readln(always);
    readln(often);
    write_test(t, always, often);
    writeln('=============');
  end;

begin
  randomize();

  for t := 10 to 14 do
    process_test(30, 30, t);

  //for t := 20 to 22 do
  //  process_test(100, 100, 300, t);

  //for t := 30 to 32 do
  //  process_test(Lim, Lim, Lim, t);

  writeln('Done');
end.
