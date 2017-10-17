program answer;

uses
  Math;

const
  Lim = 260;
var
  Source, Destination: array[1..Lim] of string;
  T: array[0..25] of longword;
  Cypher: array[0..25] of char;
  N, i: integer;

  procedure process_data();
  var
    i, j, ltr, a, b: integer;
  begin
    for i := 0 to 25 do
      T[i] := 0;

    for i := 1 to N - 1 do
      for j := i + 1 to N do
      begin
        ltr := 1;
        while Source[i][ltr] = Source[j][ltr] do
          ltr := ltr + 1;
        a := Ord(Source[i][ltr]) - 97;
        b := Ord(Source[j][ltr]) - 97;
        if (a >= 0) and (b >= 0) then
          T[b] := T[b] or (1 shl a);
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
        if (T[k] <> 1 shl 26) and ((T[k] shr j) mod 2 = 1) then
          T[k] := T[k] xor (1 shl j);
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
  fill_cypher();

  for i := 1 to N do
    Destination[i] := decode(Source[i]);

  if check_result() then
    for i := 1 to N do
      writeln(Destination[i])
  else
    writeln('Error');

  readln();
end.
