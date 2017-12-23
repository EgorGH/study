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
  t, n, m, k: longint;
  Data: array[0..Lim + 1, 0..Lim + 1] of longint;
  walls: array[1..Lim * Lim] of tpoint;
  moves: array[1..4, 1..2] of longint = ((-1, 0), (0, 1), (1, 0), (0, -1));

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

  function is_possible(): boolean;
  var
    i, j, k, q: longint;
    found: boolean;
  begin
    if Data[1, 1] > 0 then
      exit(False);

    Data[1, 1] := -1;

    repeat
      q := 0;
      for i := 1 to n do
        for j := 1 to m do
          if Data[i, j] = 0 then
          begin
            found := False;
            for k := 1 to 4 do
              if Data[i + moves[k, 1], j + moves[k, 2]] = -1 then
                found := True;
            if found then
            begin
              Data[i, j] := -1;
              q := q + 1;
            end;
          end;
    until (Data[n, m] = -1) or (q = 0);

    exit(Data[n, m] = -1);
  end;

  function full_search(): longint;
  var
    i: longint;
  begin
    if is_possible() then
      exit(0);

    for i := k downto 1 do
    begin
      Data[walls[i].x, walls[i].y] := 0;
      if is_possible() then
        exit(i);
    end;
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

    write_test(t, full_search());
  end;

  for t := 10 to 12 do
  begin
    m := 20;
    n := 20;
    k := 400;

    randomize_walls();
    prepare_data();

    write_test(t, full_search());
  end;

  for t := 20 to 22 do
  begin
    m := 500;
    n := 500;
    k := 100;

    randomize_walls();
    prepare_data();

    write_test(t, full_search());
  end;

  //for t := 30 to 32 do
  //begin
  //  m := 500;
  //  n := 500;
  //  k := 250000;
  //
  //  randomize_walls();
  //  prepare_data();
  //
  //  write_test(t, 0);
  //end;
  writeln('Done');
end.
