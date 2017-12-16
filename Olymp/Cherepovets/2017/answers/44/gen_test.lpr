program gen_test;

uses
  SysUtils;

const
  Lim = 500;

type
  tpoint = record
    x, y: longint;
  end;

var
  t, ans, n, m, k: longint;
  Data: array[0..Lim + 1, 0..Lim + 1] of longint;
  walls: array[1..Lim * Lim] of tpoint;

  procedure randomize_walls();
  var
    i, j: longint;
    t: tpoint;
  begin
    for i := 1 to n do
      for j := 1 to m do
      begin
        walls[(i - 1) * m + j].x := i;
        walls[(i - 1) * m + j].y := j;
      end;

    for i := n * m downto 2 do
    begin
      j := random(i) + 1;
      t := walls[i];
      walls[i] := walls[j];
      walls[j] := t;
    end;
  end;

  procedure prepare_data();
  var
    i, j: longint;
  begin
    for i := 1 to n do
      for j := 1 to m do
        Data[i, j] := 0;

    for i := 0 to n + 1 do
    begin
      Data[i, m + 1] := k + 1;
      Data[i, 0] := k + 1;
    end;

    for i := 0 to m + 1 do
    begin
      Data[n + 1, i] := k + 1;
      Data[0, i] := k + 1;
    end;

    for i := 1 to k do
      Data[walls[i].x, walls[i].y] := i;
  end;

  procedure print_data();
  var
    i, j: longint;
  begin
    writeln(n, ' ', m, ' ', k);

    for i := 0 to n + 1 do
    begin
      for j := 0 to m + 1 do
        Write(Data[i, j]: 3);
      writeln();
    end;
    writeln();
  end;

  procedure write_test(t, ans: longint);
  var
    infile, afile: Text;
    i: longint;
  begin
    Assign(infile, format('tests/%.2d.in', [t]));
    Assign(afile, format('tests/%.2d.a', [t]));
    rewrite(infile);
    rewrite(afile);

    writeln(infile, n, ' ', m, ' ', k);
    for i := 1 to k do
      writeln(infile, walls[i].x, ' ', walls[i].y);

    writeln(afile, ans);

    Close(infile);
    Close(afile);
  end;

begin
  randomize;

  for t := 1 to 9 do
  begin
    m := random(10) + 1;
    n := random(10) + 1;
    k := random(m * n) + 1;

    randomize_walls();
    prepare_data();
    print_data();
    readln(ans);
    write_test(t, ans);
  end;
  writeln('Done');
  readln();
end.
