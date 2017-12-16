program answer_slow;

uses
  SysUtils;

const
  Lim = 10;

type
  tpoint = record
    x, y: longint;
  end;

var
  infile: Text;
  i, n, m, k: longint;
  Data: array[0..Lim + 1, 0..Lim + 1] of longint;
  walls: array[1..Lim * Lim] of tpoint;
  moves: array[1..4, 1..2] of longint = ((-1, 0), (0, 1), (1, 0), (0, -1));

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
      print_data();
      Data[walls[i].x, walls[i].y] := 0;
      if is_possible() then
        exit(i);
    end;
  end;

begin
  //Assign(infile, 'tests/00.in');
  //reset(infile);

  readln(n, m, k);
  for i := 1 to k do
    readln(walls[i].x, walls[i].y);

  //Close(infile);

  prepare_data();
  print_data();
  writeln(full_search());
end.
