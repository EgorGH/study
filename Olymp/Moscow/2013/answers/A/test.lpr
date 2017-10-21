program test;

const
  Max = 100;
  qmax = 8;
  MaxT = 1;

var
  Source, Destination1, Destination2: array[1..Max] of string;
  T1: array[0..25, 0..26] of boolean;
  T2: array[0..25] of longword;
  Cypher1, Cypher2: array[0..25] of char;
  N, t: integer;

  procedure init();
  var
    i, q, j, d: integer;
  begin
    N := random(Max) + 1;
    for i := 1 to N do
    begin
      Source[i] := '';
      q := random(qmax) + 1;
      for j := 1 to q do
      begin
        d := random(26) + 97;
        Source[i] := Source[i] + chr(d);
      end;
    end;
  end;

  procedure sort();
  var
    i, m, j: integer;
    temp: string;
  begin
    for i := 1 to N - 1 do
    begin
      m := i;
      for j := i + 1 to N do
        if Source[j] < Source[m] then
          m := j;
      temp := Source[m];
      Source[m] := Source[i];
      Source[i] := temp;
    end;
  end;

  procedure code();
  var
    i, j: integer;
    cypher: array[0..25] of char;
  begin
    cypher[1] := chr(random(26) + 97);
    for i := 1 to 25 do
    begin
      cypher[i] := chr(random(26) + 97);
      for j := 0 to i - 1 do
        while cypher[j] = cypher[i] do
          cypher[i] := chr(random(26) + 97);
    end;

    for i := 1 to N do
      for j := 1 to length(Source[i]) do
        Source[i][j] := cypher[ord(Source[i][j]) - 97];

    for i := 1 to N do
      writeln(Source[i]);
  end;

  procedure process_data();
  var
    i, j, ltr, a, b: integer;
  begin
    for i := 1 to N - 1 do
      for j := i + 1 to N do
      begin
        ltr := 1;
        while Source[i][ltr] = Source[j][ltr] do
          ltr := ltr + 1;
        a := Ord(Source[i][ltr]) - 97;
        b := Ord(Source[j][ltr]) - 97;
        if (a >= 0) and (b >= 0) then
          T1[b, a] := True;
      end;
  end;

  procedure fill_cypher1();
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
          if T1[j, k] then
            s := s + 1;
        if s = 0 then
          break;
      end;
      for k := 0 to 25 do
        T1[k, j] := False;
      T1[j, 26] := True;
      Cypher1[j] := chr(c + 97);
      c := c + 1;
    end;
  end;

  function decode1(s: string): string;
  var
    i, j: integer;
  begin
    decode1 := '';
    for i := 1 to length(s) do
    begin
      j := Ord(s[i]) - 97;
      decode1 := decode1 + Cypher1[j];
    end;
  end;

  function check_result1(): boolean;
  var
    i: integer;
  begin
    for i := 1 to N - 1 do
      if Destination1[i] > Destination1[i + 1] then
        exit(False);
    exit(True);
  end;

  function f(): boolean;
  var
    i: integer;
  begin
    process_data();
    fill_cypher1();
    for i := 1 to N do
      Destination1[i] := decode1(Source[i]);
    f := check_result1();
  end;

  procedure mark(a, b: char);
  var
    x, y: word;
  begin
    x := Ord(a) - 97;
    y := Ord(b) - 97;
    if (x >= 0) and (y >= 0) and (x <= 25) and (y <= 25) then
      T2[y] := T2[y] or (1 shl x);
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

  procedure fill_cypher2();
  var
    i, j, k: integer;
    c: byte = 0;
  begin
    for i := 0 to 25 do
    begin
      for j := 0 to 25 do
        if T2[j] = 0 then
          break;
      for k := 0 to 25 do
        T2[k] := T2[k] and not (1 shl j);
      T2[j] := 1 shl 26;
      Cypher2[j] := chr(c + 97);
      c := c + 1;
    end;
  end;

  function decode2(s: string): string;
  var
    i, j: integer;
  begin
    decode2 := '';
    for i := 1 to length(s) do
    begin
      j := Ord(s[i]) - 97;
      decode2 := decode2 + Cypher2[j];
    end;
  end;

  function check_result2(): boolean;
  var
    i: integer;
  begin
    for i := 1 to N - 1 do
      if Destination2[i] > Destination2[i + 1] then
        exit(False);
    exit(True);
  end;

  function g(): boolean;
  var
    i: integer;
  begin
    p(1, N, 1);
    fill_cypher2();
    for i := 1 to N do
      Destination2[i] := decode2(Source[i]);
    g := check_result2();
  end;

begin
  randomize;
  for t := 1 to MaxT do
  begin
    init();
    sort();
    code();
    if (not f()) or (not g()) then
      writeln('Error!');
  end;
  writeln('All Tests Passed');
  readln();
end.
