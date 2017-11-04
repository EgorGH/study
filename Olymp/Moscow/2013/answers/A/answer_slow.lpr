program answer_slow;

uses
  Math;

type
  tdata = ^shortstring;
  tcypher = ^char;
  ttpredecessors = ^boolean;
  tpredecessors = ^ttpredecessors;

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

  procedure full_search(Data: tdata; Predecessors: tpredecessors);
  var
    i, j, ltr, a, b, min_len: longint;
  begin
    for i := 0 to N - 2 do
      for j := i + 1 to N - 1 do
      begin
        min_len := min(length(Data[i]), length(Data[j]));
        ltr := 1;

        while (Data[i][ltr] = Data[j][ltr]) and (ltr <= min_len) do
          ltr := ltr + 1;

        if ltr <= min_len then
        begin
          a := Ord(Data[i][ltr]) - 97;
          b := Ord(Data[j][ltr]) - 97;
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
  readln(N);

  Source := GetMem(N * sizeof(shortstring));
  Destination := GetMem(N * sizeof(shortstring));
  Cypher := GetMem(26 * sizeof(char));
  Predecessors := GetMem(26 * sizeof(ttpredecessors));
  for i := 0 to 25 do
    Predecessors[i] := GetMem(27 * sizeof(boolean));
  for i := 0 to 25 do
    FillByte(Predecessors[i, 0], 27, 0);

  for i := 0 to N - 1 do
    readln(Destination[i]);

  full_search(Destination, Predecessors);
  generate_cypher(Predecessors, Cypher);
  decode(Destination, Source, Cypher);
  print_text(Source);
end.
