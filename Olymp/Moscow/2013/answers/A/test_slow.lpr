program test_slow;

const
  HMax = 20;
  WMax = 8;
  TMax = 1;
type
  tdata = ^shortstring;
  tcypher = ^char;

var
  Source, Destination: tdata;
  Cypher: tcypher;
  T: array[0..25, 0..26] of boolean;
  N, tt: integer;

  procedure randomize_text(Source: tdata);
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

  procedure sort_text(Source: tdata);
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

  procedure print_text(Source: tdata);
  var
    i: integer;
  begin
    writeln(N);
    for i := 0 to N - 1 do
      writeln(Source[i]);
  end;

  function check_text(Source: tdata): boolean;
  var
    i: integer;
  begin
    for i := 0 to N - 2 do
      if Source[i] > Source[i + 1] then
        exit(False);
    exit(True);
  end;

  function decode(s: shortstring; cypher: tcypher): shortstring;
  var
    d: shortstring;
    i: integer;
  begin
    d := '';
    for i := 1 to Length(s) do
      d := d + cypher[Ord(s[i]) - 97];
    exit(d);
  end;

  procedure decode(Source, Destination: tdata; cypher: tcypher);
  var
    i: integer;
  begin
    for i := 0 to N - 1 do
      Destination[i] := decode(Source[i], Cypher);
  end;

  procedure randomize_cypher(cypher: tcypher);
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

  procedure print_cypher(Cypher: tcypher);
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

  procedure process_data(Source: tdata);
  var
    i, j, ltr, a, b: integer;
  begin
    for i := 0 to N - 2 do
      for j := i + 1 to N - 1 do
      begin
        ltr := 1;
        while Source[i][ltr] = Source[j][ltr] do
          ltr := ltr + 1;
        a := Ord(Source[i][ltr]) - 97;
        b := Ord(Source[j][ltr]) - 97;
        if (a >= 0) and (b >= 0) then
          T[b, a] := True;
      end;
  end;

  procedure generate_cypher(Cypher: tcypher);
  var
    i, j, k, s: integer;
    c: byte = 0;
  begin
    process_data(Destination);
    for i := 0 to 25 do
    begin
      for j := 0 to 25 do
      begin
        s := 0;
        for k := 0 to 26 do
          if T[j, k] then
            s := s + 1;
        if s = 0 then
          break;
      end;
      for k := 0 to 25 do
        T[k, j] := False;
      T[j, 26] := True;
      Cypher[j] := chr(c + 97);
      c := c + 1;
    end;
  end;

begin
  Source := GetMem(HMax * sizeof(shortstring));
  Destination := GetMem(HMax * sizeof(shortstring));
  Cypher := GetMem(26 * sizeof(char));
  randomize();

  for tt := 1 to TMax do
  begin
    randomize_text(Source);
    sort_text(Source);
    if not check_text(Source) then
      print_text(Source);
    randomize_cypher(Cypher);
    decode(Source, Destination, Cypher);
    generate_cypher(Cypher);
    decode(Destination, Source, Cypher);
    if not check_text(Source) then
    begin
      print_text(Destination);
      print_cypher(Cypher);
      print_text(Source);
    end;
  end;
  writeln('Done');
  readln();
end.
