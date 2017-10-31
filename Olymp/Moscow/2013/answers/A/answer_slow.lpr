program answer_slow;

uses
  Math;

type
  tdata = array of shortstring;
  tcypher = array of char;
  tpred = array of array of boolean;

var
  Source, Destination: tdata;
  Cypher: tcypher;
  Predecessors: tpred;
  N, i, j: longint;

  procedure print_text(var Source: tdata);
  var
    i: longint;
  begin
    for i := 0 to N - 1 do
      writeln(Source[i]);
  end;

  function check_text(var Source: tdata): boolean;
  var
    i: longint;
  begin
    for i := 0 to N - 2 do
      if Source[i] > Source[i + 1] then
        exit(False);
    exit(True);
  end;

  function decode(s: shortstring; var cypher: tcypher): shortstring;
  var
    d: shortstring;
    i: longint;
  begin
    d := '';
    for i := 1 to Length(s) do
      d := d + cypher[Ord(s[i]) - 97];
    exit(d);
  end;

  procedure decode(var Source, Destination: tdata; cypher: tcypher);
  var
    i: longint;
  begin
    for i := 0 to N - 1 do
      Destination[i] := decode(Source[i], Cypher);
  end;

  procedure print_cypher(var Cypher: tcypher);
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

  procedure print_table(var Predecessors: tpred);
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

  procedure fill_predecessors(var Destination: tdata; Predecessors: tpred);
  var
    i, j, ltr, a, b, min_len: longint;
  begin
    for i := 0 to N - 2 do
      for j := i + 1 to N - 1 do
      begin
        min_len := min(length(Destination[i]), length(Destination[j]));
        ltr := 1;

        while (Destination[i][ltr] = Destination[j][ltr]) and (ltr <= min_len) do
          ltr := ltr + 1;

        if ltr <= min_len then
        begin
          a := Ord(Destination[i][ltr]) - 97;
          b := Ord(Destination[j][ltr]) - 97;
          Predecessors[b, a] := True;
        end;
      end;
  end;

  procedure generate_cypher(var Predecessors: tpred; Cypher: tcypher);
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

  SetLength(Source, N);
  SetLength(Destination, N);
  SetLength(Cypher, 26);
  SetLength(Predecessors, 26, 27);
  for i := 0 to 25 do
    for j := 0 to 26 do
      Predecessors[i, j] := False;

  for i := 0 to N - 1 do
    readln(Destination[i]);

  fill_predecessors(Destination, Predecessors);
  generate_cypher(Predecessors, Cypher);
  decode(Destination, Source, Cypher);

  if not check_text(Source) then
    writeln('Error!')
  else
    print_text(Source);
end.
