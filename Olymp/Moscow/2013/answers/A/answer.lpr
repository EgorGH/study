program answer;

uses
  Math;

var
  Source, Destination: array of string;
  T: array[0..25] of longword;
  Cypher: array[0..25] of char;
  N, i: integer;

  procedure mark(a, b: char);
  var
    x, y: word;
  begin
    x := Ord(a) - 97;
    y := Ord(b) - 97;
    if (x >= 0) and (y >= 0) and (x <= 25) and (y <= 25) then
      T[y] := T[y] or (1 shl x);
  end;

  procedure p(a, b, c: integer);
  var
    x, y: integer;
  begin
    if a = b then
      exit();
    x := a;
    for y := a to b do
    begin
      if Source[x][c] <> Source[y][c] then
      begin
        mark(Source[x][c], Source[y][c]);
        p(x, y - 1, c + 1);
        x := y;
      end;
    end;
    p(x, b, c + 1);
  end;

  procedure print_table();
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
        if (T[i] shr j) mod 2 = 1 then
          Write(1: 2)
        else
          Write('': 2);
      writeln();
    end;
  end;

  procedure fill_cypher();
  var
    i, j, k: integer;
    c: byte = 0;
  begin
    for i := 0 to 25 do
    begin
      for j := 0 to 25 do
        if T[j] = 0 then
          break;
      for k := 0 to 25 do
        if (T[k] <> 1 shl 26) then
          T[k] := T[k] and not (1 shl j);
      T[j] := 1 shl 26;
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

  p(0, N - 1, 1);

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
