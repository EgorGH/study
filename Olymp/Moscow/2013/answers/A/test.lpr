program test;

const
  HMax = 500;
  WMax = 10;
  TMax = 1000;
type
  tdata = ^shortstring;
  tcypher = ^char;
  tpred = ^longint;

var
  Source, Destination: tdata;
  Cypher: tcypher;
  Predecessors: tpred;
  N, tt: longint;

  procedure randomize_text(Source: tdata);
  var
    i, w, j: longint;
  begin
    N := random(HMax) + 1;
    for i := 0 to N - 1 do
    begin
      Source[i] := '';
      w := random(WMax) + 1;
      for j := 1 to w do
        Source[i] := Source[i] + chr(random(26) + 97);
    end;
  end;

  procedure sort_text(Source: tdata);
  var
    i, m, j: longint;
    t: string;
  begin
    for i := 0 to N - 2 do
    begin
      m := i;
      for j := i + 1 to N - 1 do
        if Source[j] < Source[m] then
          m := j;
      t := Source[m];
      Source[m] := Source[i];
      Source[i] := t;
    end;
  end;

  procedure print_text(Source: tdata);
  var
    i: longint;
  begin
    writeln(N);
    for i := 0 to N - 1 do
      writeln(Source[i]);
  end;

  function check_text(Source: tdata): boolean;
  var
    i: longint;
  begin
    for i := 0 to N - 2 do
      if Source[i] > Source[i + 1] then
        exit(False);
    exit(True);
  end;

  function decode(s: shortstring; cypher: tcypher): shortstring;
  var
    d: shortstring;
    i: longint;
  begin
    d := '';
    for i := 1 to Length(s) do
      d := d + cypher[Ord(s[i]) - 97];
    exit(d);
  end;

  procedure decode(Source, Destination: tdata; cypher: tcypher);
  var
    i: longint;
  begin
    for i := 0 to N - 1 do
      Destination[i] := decode(Source[i], Cypher);
  end;

  procedure randomize_cypher(cypher: tcypher);
  var
    i: longint;
    r: qword;
    t: qword = 0;
  begin
    for i := 0 to 25 do
    begin
      r := random(26);
      while (1 shl r) and t > 0 do
        r := (r + 1) mod 26;
      cypher[i] := chr(r + 97);
      t := t or (1 shl r);
    end;
  end;

  procedure print_cypher(Cypher: tcypher);
  var
    i: longint;
  begin
    for i := 0 to 25 do
      Write(chr(i + 97): 2);
    writeln();
    for i := 0 to 25 do
      Write(Cypher[i]: 2);
    writeln();
  end;

  procedure print_table(Predecessors: tpred);
  var
    i, j: longword;
  begin
    Write('': 2);
    for i := 0 to 25 do
      Write(char(i + 97): 2);
    writeln();
    for i := 0 to 25 do
    begin
      Write(char(i + 97): 2);
      for j := 0 to 25 do
        if (Predecessors[i] shr j) mod 2 = 1 then
          Write(1: 2)
        else
          Write('': 2);
      writeln();
    end;
  end;

  procedure mark(a, b: char; Predecessors: tpred);
  var
    x, y: longint;
  begin
    x := Ord(a) - 97;
    y := Ord(b) - 97;
    if (x >= 0) and (y >= 0) and (x <= 25) and (y <= 25) then
      Predecessors[y] := Predecessors[y] or (1 shl x);
  end;

  procedure fill_predecessors(Destination: tdata; a, b, c: longint; Predecessors: tpred);
  var
    x, y: longint;
  begin
    while (a < b) and (length(Destination[a]) < c) do
      a := a + 1;

    if a = b then
      exit();
    x := a;

    for y := a to b do
    begin
      if (Destination[x][c] <> Destination[y][c]) then
      begin
        mark(Destination[x][c], Destination[y][c], Predecessors);
        fill_predecessors(Destination, x, y - 1, c + 1, Predecessors);
        x := y;
      end;
    end;
    fill_predecessors(Destination, x, b, c + 1, Predecessors);
  end;

  procedure generate_cypher(Predecessors: tpred; Cypher: tcypher);
  var
    i, j, c, k: longint;
  begin
    c := 0;
    for i := 0 to 25 do
    begin
      for j := 0 to 25 do
        if Predecessors[j] = 0 then
          break;
      for k := 0 to 25 do
        Predecessors[k] := Predecessors[k] and not (1 shl j);
      Predecessors[j] := 1 shl 26;
      Cypher[j] := chr(c + 97);
      c := c + 1;
    end;
  end;

begin
  Source := GetMem(HMax * sizeof(shortstring));
  Destination := GetMem(HMax * sizeof(shortstring));
  Cypher := GetMem(26 * sizeof(char));
  Predecessors := GetMem(26 * sizeof(longint));
  randomize();

  for tt := 1 to TMax do
  begin
    randomize_text(Source);
    sort_text(Source);
    randomize_cypher(Cypher);
    decode(Source, Destination, Cypher);
    FillByte(Predecessors[0], 26 * sizeof(longint), 0);

    fill_predecessors(Destination, 0, N - 1, 1, Predecessors);
    generate_cypher(Predecessors, Cypher);
    decode(Destination, Source, Cypher);

    if not check_text(Source) then
    begin
      print_text(Destination);
      print_table(Predecessors);
      print_cypher(Cypher);
      print_text(Source);
      writeln('Test failed');
    end;
  end;
  writeln('Done');
end.
