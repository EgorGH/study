program answer;

type
  tdata = ^shortstring;
  tcypher = ^char;
  tpredecessors = ^longint;

var
  Source, Destination: tdata;
  Cypher: tcypher;
  Predecessors: tpredecessors;
  N, i: longint;

  procedure print_text(Source: tdata);
  var
    i: longint;
  begin
    for i := 0 to N - 1 do
      writeln(Source[i]);
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

  procedure mark(a, b: char; Predecessors: tpredecessors);
  var
    x, y: longint;
  begin
    x := Ord(a) - 97;
    y := Ord(b) - 97;
    Predecessors[y] := Predecessors[y] or (1 shl x);
  end;

  procedure optimal_search(data: tdata; a, b, c: longint; Predecessors: tpredecessors);
  var
    x, y: longint;
  begin
    while (a < b) and (length(data[a]) < c) do
      a := a + 1;

    if a = b then
      exit();
    x := a;

    for y := a to b do
    begin
      if data[x][c] <> data[y][c] then
      begin
        mark(data[x][c], data[y][c], Predecessors);
        optimal_search(data, x, y - 1, c + 1, Predecessors);
        x := y;
      end;
    end;
    optimal_search(data, x, b, c + 1, Predecessors);
  end;

  procedure generate_cypher(Predecessors: tpredecessors; Cypher: tcypher);
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

  optimal_search(Destination, 0, N - 1, 1, Predecessors);
  generate_cypher(Predecessors, Cypher);
  decode(Destination, Source, Cypher);
  print_text(Source);
end.
