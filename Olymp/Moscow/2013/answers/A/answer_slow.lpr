program answer_slow;


var
  Source, Destination: array of string;
  T: array[0..25, 0..26] of boolean;
  Cypher: array[0..25] of char;
  N, i: integer;

  procedure process_data();
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

  procedure print_table();
  var
    i, j: integer;
  begin
    Write('': 3);
    for i := 0 to 25 do
      Write(chr(i + 97): 3);
    writeln();
    for i := 0 to 25 do
    begin
      Write(chr(i + 97): 3);
      for j := 0 to 25 do
        if T[i, j] then
          Write(1: 3)
        else
          Write('': 3);
      writeln();
    end;
  end;

  procedure fill_cypher();
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

  procedure print_cypher();
  var
    i: integer;
  begin
    for i := 0 to 25 do
      Write(chr(i + 97): 3);
    writeln();
    for i := 0 to 25 do
      Write(Cypher[i]: 3);
    writeln();
  end;

  function decode(s: string): string;
  var
    i, j: integer;
  begin
    decode := '';
    for i := 1 to length(s) do
    begin
      j := Ord(s[i]) - 97;
      decode := decode + Cypher[j];
    end;
  end;

  function check_result(): boolean;
  var
    i: integer;
  begin
    for i := 0 to N - 2 do
      if Destination[i] > Destination[i + 1] then
        exit(False);
    exit(True);
  end;

begin
  readln(N);

  SetLength(Source, N);
  SetLength(Destination, N);

  for i := 0 to N - 1 do
    readln(Source[i]);

  process_data();
  fill_cypher();

  for i := 0 to N - 1 do
    Destination[i] := decode(Source[i]);

  if check_result() then
    for i := 0 to N - 1 do
      writeln(Destination[i])
  else
    writeln('Error');

  readln();
end.
