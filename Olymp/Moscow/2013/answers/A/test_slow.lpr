program test_slow;

uses
  Math;

const
  HMax = 2000;
  WMax = 10;
  TMax = 1000;

type
  tdata = ^shortstring;
  tcypher = ^char;
  ttpredecessors = ^boolean;
  tpredecessors = ^ttpredecessors;

var
  Source, Destination: tdata;
  Cypher: tcypher;
  Predecessors: tpredecessors;
  N, i, j, tt: longint;

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

  procedure quicksort_text(data: tdata; lo, hi: longint);
  var
    i, j: longint;
    pivot, t: shortstring;
  begin
    i := lo;
    j := hi;
    pivot := data[(lo + hi) div 2];
    while i <= j do
    begin
      while data[i] < pivot do
        i := i + 1;
      while data[j] > pivot do
        j := j - 1;
      if i <= j then
      begin
        t := data[i];
        data[i] := data[j];
        data[j] := t;
        i := i + 1;
        j := j - 1;
      end;
    end;
    if lo < j then
      quicksort_text(data, lo, j);
    if hi > i then
      quicksort_text(data, i, hi);
  end;

  procedure print_text(var Source: tdata);
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
    i, j: longint;
  begin
    Write('': 2);
    for i := 0 to 25 do
      Write(chr(i + 97): 2);
    writeln();
    for i := 0 to 25 do
    begin
      Write(chr(i + 97): 2);
      for j := 0 to 25 do
        if Predecessors[i, j] then
          Write(1: 2)
        else
          Write('': 2);
      writeln();
    end;
  end;

  procedure full_search(data: tdata; Predecessors: tpredecessors);
  var
    i, j, ltr, a, b, min_len: longint;
  begin
    for i := 0 to N - 2 do
      for j := i + 1 to N - 1 do
      begin
        min_len := min(length(data[i]), length(data[j]));
        ltr := 1;

        while (data[i][ltr] = data[j][ltr]) and (ltr <= min_len) do
          ltr := ltr + 1;

        if ltr <= min_len then
        begin
          a := Ord(data[i][ltr]) - 97;
          b := Ord(data[j][ltr]) - 97;
          Predecessors[b, a] := True;
        end;
      end;
  end;

  procedure generate_cypher(Predecessors: tpredecessors; Cypher: tcypher);
  var
    i, j, k, s: longint;
    c: byte = 0;
  begin
    for i := 0 to 25 do
    begin
      for j := 0 to 25 do
      begin
        s := 0;
        for k := 0 to 26 do
          if Predecessors[j, k] then
            s := s + 1;
        if s = 0 then
          break;
      end;
      for k := 0 to 25 do
        Predecessors[k, j] := False;
      Predecessors[j, 26] := True;
      Cypher[j] := chr(c + 97);
      c := c + 1;
    end;
  end;

begin
  Source := GetMem(HMax * sizeof(shortstring));
  Destination := GetMem(HMax * sizeof(shortstring));
  Cypher := GetMem(26 * sizeof(char));
  Predecessors := GetMem(26 * sizeof(ttpredecessors));
  for i := 0 to 25 do
    Predecessors[i] := GetMem(27 * sizeof(boolean));
  randomize();

  for tt := 1 to TMax do
  begin
    randomize_text(Source);
    quicksort_text(Source, 0, N - 1);
    randomize_cypher(Cypher);
    decode(Source, Destination, Cypher);
    for i := 0 to 25 do
      FillByte(Predecessors[i, 0], 27, 0);

    full_search(Destination, Predecessors);
    generate_cypher(Predecessors, Cypher);
    decode(Destination, Source, Cypher);

    if not check_text(Source) then
    begin
      print_text(Destination);
      print_table(Predecessors);
      print_cypher(Cypher);
      print_text(Source);
      writeln('Error!');
    end;
  end;
  writeln('Done');
end.
