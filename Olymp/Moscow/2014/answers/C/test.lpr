program test;

uses
  SysUtils;

const
  Lim = 1000;
  MaxT = 10;
  MaxLength = 50;

var
  Source_generated, destination, source_decrypted: TextFile;
  t: longint;

  procedure generate_source(var Source: Text);
  begin
    for i := 1 to random(MaxLength) + 1 do
      Write(Source, chr(random(26) + 65));
  end;

  procedure crypt(var Source, destination: Text);
  var
    word: shortstring;
    temp: shortstring = '';
    dictionary: ^shortstring;
    n, i, j, q, num: longint;
    found: boolean = False;
    Lim: longint = 100;

  begin
    n := 1;
    dictionary := GetMem(Lim * n * sizeof(shortstring));
    dictionary[0] := '';
    for i := 1 to 26 do
      dictionary[i] := chr(i + 64);

    readln(Source, word);

    q := 26;
    for i := 1 to length(word) do
    begin
      temp := temp + word[i];
      j := 1;
      while j <= q do
      begin
        if dictionary[j] = temp then
        begin
          found := True;
          num := j;
          break;
        end;
        j := j + 1;
      end;
      if not found then
      begin
        q := q + 1;
        if q > Lim * n then
        begin
          n := n + 1;
          dictionary := GetMem(Lim * n * sizeof(shortstring));
        end;
        dictionary[q] := temp;
        Writeln(destination, num, chr(9), temp[length(temp)]);
        temp := '';
      end;
      found := False;
    end;

    FreeMem(dictionary);
  end;

  procedure decrypt(var Source, destination: Text);
  var
    i, q, num, n: longint;
    letter: char;
    str: shortstring;
    dictionary: ^shortstring;
  begin
    n := 1;
    dictionary := GetMem(Lim * n * sizeof(shortstring));
    dictionary[0] := '';
    for i := 1 to 26 do
      dictionary[i] := chr(i + 64);

    q := 26;
    while not EOF(Source) do
    begin
      q := q + 1;
      readln(Source, str);

      i := pos(chr(9), str);
      num := StrToInt(copy(str, 1, i - 1));
      letter := str[i + 1];

      if q > Lim * n then
      begin
        n := n + 1;
        dictionary := GetMem(Lim * n * sizeof(shortstring));
      end;
      dictionary[q] := dictionary[num] + letter;
      Write(destination, dictionary[q]);
    end;

    FreeMem(dictionary);
  end;

begin
  for t := 1 to MaxT do
  begin
    generate_source(Source_generated);
    crypt(Source_generated, destination);
    decrypt(destination, Source_decrypted);
  end;
end.