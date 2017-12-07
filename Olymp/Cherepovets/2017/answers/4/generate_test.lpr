program generate_test;

uses
  SysUtils;

const
  Lim = 500;

type
  tpoint = record
    x, y: longint;
  end;

var
  Data: array[0..Lim + 1, 0..Lim + 1] of smallint;
  walls: array[1..Lim * Lim] of tpoint;
  i, t, m, n, k, ans: longint;

  procedure randomize_walls();
  var
    i, j: longint;
    t: tpoint;
  begin
    for i := 0 to n - 1 do
      for j := 0 to m - 1 do
      begin
        walls[i * m + j + 1].x := i + 1;
        walls[i * m + j + 1].y := j + 1;
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
    i: longint;
  begin
    for i := 1 to k do
      data[walls[i].x, walls[i].y] := i;

    for i := 0 to n + 1 do
    begin
      Data[i, 0] := k + 1;
      Data[i, m + 1] := k + 1;
    end;

    for i := 0 to m + 1 do
    begin
      Data[0, i] := k + 1;
      Data[n + 1, i] := k + 1;
    end;
  end;

  procedure print_data();
  var
    i, j: longint;
  begin
    for i := 0 to n + 1 do
    begin
      for j := 0 to m + 1 do
        Write(Data[i, j]: 3);
      writeln();
    end;
  end;

  procedure write_test(t, ans: longint);
  var
    infile, afile: Text;
    i: longint;
  begin
    Assign(infile, 'tests/' + format('%.2d', [t]) + '.in');
    Assign(afile, 'tests/' + format('%.2d', [t]) + '.a');

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
  for t := 1 to 2 do
  begin
    n := random(10) + 1;
    m := random(10) + 1;
    k := random(n * m) + 1;
    randomize_walls();
    prepare_data();
    print_data();
    readln(ans);
    write_test(t, ans);
  end;
  readln();
end.
