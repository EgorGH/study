program test;

const
  HMax = 2000;
  WMax = 10;
  TMax = 1000;
type
  tdata = ^shortstring;
  tcypher = ^char;
  tpredecessors = ^longint;

var
  Source, Destination: tdata;
  Cypher: tcypher;
  Predecessors: tpredecessors;
  N, t: longint;

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

  procedure quicksort_text(Source: tdata; lo, hi: longint);
  var
    i, j: longint;
    pivot, t: shortstring;
  begin
    i := lo;
    j := hi;
    pivot := Source[(lo + hi) div 2];
    while i <= j do
    begin
      while Source[i] < pivot do
        i := i + 1;
      while Source[j] > pivot do
        j := j - 1;
      if i <= j then
      begin
        t := Source[i];
        Source[i] := Source[j];
        Source[j] := t;
        i := i + 1;
        j := j - 1;
      end;
    end;
    if lo < j then
      quicksort_text(Source, lo, j);
    if hi > i then
      quicksort_text(Source, i, hi);
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

  procedure print_table(Predecessors: tpredecessors);
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

  procedure mark(a, b: char; Predecessors: tpredecessors);
  var
    x, y: longint;
  begin
    x := Ord(a) - 97;
    y := Ord(b) - 97;
    Predecessors[y] := Predecessors[y] or (1 shl x);
  end;

  procedure optimal_search(Data: tdata; a, b, c: longint; Predecessors: tpredecessors);
  var
    x, y: longint;
  begin
    while (a < b) and (length(Data[a]) < c) do
      a := a + 1;

    if a = b then
      exit();
    x := a;

    for y := a to b do
    begin
      if (Data[x][c] <> Data[y][c]) then
      begin
        mark(Data[x][c], Data[y][c], Predecessors);
        optimal_search(Data, x, y - 1, c + 1, Predecessors);
        x := y;
      end;
    end;
    optimal_search(Data, x, b, c + 1, Predecessors);
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
  Source := GetMem(HMax * sizeof(shortstring));
  Destination := GetMem(HMax * sizeof(shortstring));
  Cypher := GetMem(26 * sizeof(char));
  Predecessors := GetMem(26 * sizeof(longint));
  randomize();

  for t := 1 to TMax do
  begin
    randomize_text(Source);
    quicksort_text(Source, 0, N - 1);
    randomize_cypher(Cypher);
    decode(Source, Destination, Cypher);
    FillByte(Predecessors[0], 26 * sizeof(longint), 0);

    optimal_search(Destination, 0, N - 1, 1, Predecessors);
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
