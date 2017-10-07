program answer_optimized;

const
  Lim = 260;
var
  Source, Destination: array[1..Lim] of string;
  T: array[0..26, 0..26] of boolean;
  Cypher: array[0..25] of char;
  i, N: integer;

  procedure p(a, b, c: integer);
  var
    i: integer;
    let1, let2: integer;
  begin
    i := a;

    if a >= b then
      exit();

    while (i < b) and (Source[i][c] = Source[i + 1][c]) do
    begin
      i := i + 1;
    end;

    if i <> a then
    begin
      if (c = 1) and (i < N) then
      begin
        let1 := Ord(Source[i][c]) - 97;
        let2 := Ord(Source[i + 1][c]) - 97;
        if (let1 >= 0) and (let2 >= 0) then
          T[let1, let2] := True;
      end;
      p(a, i, c + 1);
    end;

    if (i = a) then
    begin
      let1 := Ord(Source[i][c]) - 97;
      let2 := Ord(Source[i + 1][c]) - 97;
      if (let1 >= 0) and (let2 >= 0) then
        T[let1, let2] := True;
      if (c <> 1) and (i = b) then
        exit();
    end;

    if (i < N) and (i <> a) then
    begin
      p(i, b, c);
      while (i < b) and (c <> 1) do
      begin
        p(i + 1, b, c);
        i := i + 1;
      end;
    end;

    if (i < N) and (i = a) then
      p(i + 1, b, c);
  end;

  procedure process_data();
  var
    i, j: integer;
  begin
    for i := 0 to 25 do
      for j := 0 to 25 do
        T[i, j] := False;

    p(1, N, 1);
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
          if T[k, j] then
            s := s + 1;
        if s = 0 then
          break;
      end;
      for k := 0 to 25 do
        T[j, k] := False;
      T[26, j] := True;
      Cypher[j] := chr(c + 97);
      c := c + 1;
    end;
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
    for i := 1 to N - 1 do
      if Destination[i] > Destination[i + 1] then
        exit(False);
    exit(True);
  end;

begin
  readln(N);

  for i := 1 to N do
    readln(Source[i]);

  process_data();
  print_table();
  fill_cypher();
  print_cypher();

  for i := 1 to N do
    Destination[i] := decode(Source[i]);

  if check_result() then
    for i := 1 to N do
      writeln(Destination[i])
  else
    writeln('Error');

  writeln();
  writeln('DONE!');
  readln();
end.
