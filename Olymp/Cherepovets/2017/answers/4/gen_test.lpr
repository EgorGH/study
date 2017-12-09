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
  Data: array[0..Lim + 1, 0..Lim + 1] of smallint;
  moves: array[1..4, 1..2] of shortint = ((1, 0), (-1, 0), (0, -1), (0, 1));
  walls: array[1..Lim * Lim] of tpoint;
  k, m, n, t: longint;

  procedure randomize_walls();
  var
    i, j: longint;
    t: tpoint;
  begin
    for i := 0 to m - 1 do
      for j := 0 to n - 1 do
      begin
        walls[i * n + j + 1].y := i + 1;
        walls[i * n + j + 1].x := j + 1;
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
    for i := 0 to m + 1 do
      for j := 0 to n + 1 do
        data[i, j] := 0;

    for i := 0 to m + 1 do
    begin
      Data[i, 0] := -1;
      Data[i, n + 1] := -1;
    end;

    for i := 0 to n + 1 do
    begin
      Data[0, i] := -1;
      Data[m + 1, i] := -1;
    end;

    for i := 1 to k do
      data[walls[i].y, walls[i].x] := -1;
  end;

  function is_possible(): boolean;
  var
    q, i, j, k: longint;
    f: boolean;
  begin
    if Data[1, 1] = 0 then
      Data[1, 1] := 1;
    repeat
      q := 0;
      for i := 1 to m do
        for j := 1 to n do
          if Data[i, j] = 0 then
          begin
            f := False;
            for k := 1 to 4 do
              if Data[i + moves[k, 1], j + moves[k, 2]] = 1 then
                f := True;
            if f then
            begin
              q += 1;
              Data[i, j] := 1;
            end;
          end;
    until (q = 0) or (Data[m, n] = 1);
    exit(Data[m, n] = 1);
  end;

  function full_search(): longint;
  var
    d: longint;
  begin
    d := k;
    while not is_possible() and (d > 0) do
    begin
      Data[walls[d].y, walls[d].x] := 0;
      d := d - 1;
    end;
    if d = k then
      exit(0)
    else
      exit(d + 1);
  end;

  procedure write_test(t: longint);
  var
    infile, afile: Text;
    i: longint;
  begin
    Assign(infile, format('tests/%.2d.in', [t]));
    Assign(afile, format('tests/%.2d.a', [t]));
    Rewrite(infile);
    Rewrite(afile);

    writeln(infile, m, ' ', n, ' ', k);
    for i := 1 to k do
      writeln(infile, walls[i].y, ' ', walls[i].x);

    writeln(afile, full_search());

    Close(infile);
    Close(afile);
  end;

begin
  randomize;

  for t := 1 to 9 do
  begin
    m := random(20) + 1;
    n := random(20) + 1;
    k := random(m * n) + 1;

    randomize_walls();
    prepare_data();

    write_test(t);
  end;

  for t := 10 to 19 do
  begin
    m := 20;
    n := 20;
    k := random(m * n) + 1;

    randomize_walls();
    prepare_data();

    write_test(t);
  end;

  for t := 20 to 23 do
  begin
    m := random(500) + 1;
    n := random(500) + 1;
    k := random(100) + 1;

    randomize_walls();
    prepare_data();

    write_test(t);
  end;

  writeln('Done');
end.

