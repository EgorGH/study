program answer;

type
  tdata = ^shortstring;
  tcypher = ^char;
  tpred = ^longint;

var
  Source, Destination: tdata;
  Cypher: tcypher;
  Predecessors: tpred;
  N, i: longint;

  procedure print_text(Source: tdata);
  var
    i: longint;
  begin
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
      if Destination[x][c] <> Destination[y][c] then
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
  readln(N);

  Source := GetMem(N * sizeof(shortstring));
  Destination := GetMem(N * sizeof(shortstring));
  Cypher := GetMem(26 * sizeof(char));
  Predecessors := GetMem(26 * sizeof(longint));
  FillByte(Predecessors[0], 26 * sizeof(longint), 0);

  for i := 0 to N - 1 do
    readln(Destination[i]);

  fill_predecessors(Destination, 0, N - 1, 1, Predecessors);
  generate_cypher(Predecessors, Cypher);
  decode(Destination, Source, Cypher);

  if not check_text(Source) then
    writeln('Error!')
  else
    print_text(Source);
end.
