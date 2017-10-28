program test_slow;

const
  HMax = 300;
  WMax = 10;
  TMax = 1000;

type
  tdata = array of shortstring;
  tcypher = array of char;
  tpred = array of array of boolean;

var
  Source, Destination: tdata;
  Cypher: tcypher;
  Predecessors: tpred;
  N, tt: integer;

  procedure randomize_text(var Source: tdata);
  var
    i, w, j: integer;
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

  procedure sort_text(var Source: tdata);
  var
    i, m, j: integer;
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

  procedure print_text(var Source: tdata);
  var
    i: integer;
  begin
    writeln(N);
    for i := 0 to N - 1 do
      writeln(Source[i]);
  end;

  function check_text(var Source: tdata): boolean;
  var
    i: integer;
  begin
    for i := 0 to N - 2 do
      if Source[i] > Source[i + 1] then
        exit(False);
    exit(True);
  end;

  function decode(s: shortstring; var cypher: tcypher): shortstring;
  var
    d: shortstring;
    i: integer;
  begin
    d := '';
    for i := 1 to Length(s) do
      d := d + cypher[Ord(s[i]) - 97];
    exit(d);
  end;

  procedure decode(var Source, Destination: tdata; cypher: tcypher);
  var
    i: integer;
  begin
    for i := 0 to N - 1 do
      Destination[i] := decode(Source[i], Cypher);
  end;

  procedure randomize_cypher(var cypher: tcypher);
  var
    i: integer;
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

  procedure print_cypher(var Cypher: tcypher);
  var
    i: integer;
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
    i, j: integer;
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
    i, j, ltr, a, b: integer;
    error: boolean;
  begin
    for i := 0 to 25 do
      for j := 0 to 26 do
        Predecessors[i, j] := False;

    for i := 0 to N - 2 do
      for j := i + 1 to N - 1 do
      begin
        error := False;
        ltr := 1;
        while (Destination[i][ltr] = Destination[j][ltr]) do
        begin
          ltr := ltr + 1;
          if (ltr > length(Destination[i])) or (ltr > length(Destination[j])) then
          begin
            error := true;
            break;
          end;
        end;
        if error then
          break;
        a := Ord(Destination[i][ltr]) - 97;
        b := Ord(Destination[j][ltr]) - 97;
        if (a >= 0) and (b >= 0) and (a <= 25) and (b <= 25) then
          Predecessors[b, a] := True;
      end;
  end;

  procedure generate_cypher(var Predecessors: tpred; Cypher: tcypher);
  var
    i, j, k, s: integer;
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
  SetLength(Source, HMax);
  SetLength(Destination, HMax);
  SetLength(Cypher, 26);
  SetLength(Predecessors, 26, 27);
  randomize();

  for tt := 1 to TMax do
  begin
    randomize_text(Source);

    sort_text(Source);

    randomize_cypher(Cypher);

    decode(Source, Destination, Cypher);

    fill_predecessors(Destination, Predecessors);

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
  readln();
end.
