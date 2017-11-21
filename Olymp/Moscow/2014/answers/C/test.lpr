program test;

uses
  SysUtils;

const
  Lim = 30;
  MaxT = 1000;
  MaxLength = 500;

var
  Source, destination, decrypted_destination: TextFile;
  t: longint;

  procedure generate_word(var Source: TextFile);
  var
    i: longint;
  begin
    for i := 1 to random(MaxLength) + 1 do
      Write(Source, chr(random(26) + 65));
  end;

  procedure crypt(var Source, destination: TextFile);
  var
    word: ansistring;
    temp: shortstring = '';
    dictionary: array of shortstring;
    n, i, j, q, num, prev_num: longint;
    found: boolean = False;
    Lim: longint = 100;

  begin
    n := 1;
    SetLength(dictionary, Lim * n);
    dictionary[0] := '';
    for i := 1 to 26 do
      dictionary[i] := chr(i + 64);

    readln(Source, word);

    q := 26;
    for i := 1 to length(word) do
    begin
      temp := temp + word[i];

      found := False;
      for j := 1 to q do
        if dictionary[j] = temp then
        begin
          found := True;
          prev_num := num;
          num := j;
          break;
        end;

      if not found then
      begin
        q := q + 1;
        if q > Lim * n - 1 then
        begin
          n := n + 1;
          SetLength(dictionary, Lim * n);
        end;
        dictionary[q] := temp;
        Writeln(destination, num, chr(9), temp[length(temp)]);
        temp := '';
      end;
    end;

    if length(temp) = 1 then
      prev_num := 0;

    if found then
      writeln(destination, prev_num, chr(9), temp[length(temp)]);
  end;

  procedure decrypt(var Source, destination: TextFile);
  var
    i, q, num, n: longint;
    letter: char;
    str: shortstring;
    dictionary: array of shortstring;
  begin
    n := 1;
    SetLength(dictionary, Lim * n);
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

      if q > Lim * n - 1 then
      begin
        n := n + 1;
        SetLength(dictionary, Lim * n);
      end;
      dictionary[q] := dictionary[num] + letter;
      Write(destination, dictionary[q]);
    end;
  end;

  function compare(var textA, textB: TextFile): boolean;
  var
    wordA, wordB: ansistring;
  begin
    Read(textA, wordA);
    Read(textB, wordB);

    if wordA <> wordB then
      exit(False);

    exit(True);
  end;

begin
  randomize;
  Assign(Source, 'source.txt');
  Assign(destination, 'destination.txt');
  Assign(decrypted_destination, 'decrypted_destination.txt');
  for t := 1 to MaxT do
  begin
    Rewrite(Source);
    generate_word(Source);

    Reset(Source);
    Rewrite(destination);
    crypt(Source, destination);

    Reset(destination);
    Rewrite(decrypted_destination);
    decrypt(destination, decrypted_destination);

    Reset(Source);
    Reset(decrypted_destination);
    if not compare(Source, decrypted_destination) then
      writeln('Error');
  end;
  Close(Source);
  Close(destination);
  Close(decrypted_destination);
  Erase(Source);
  Erase(destination);
  Erase(decrypted_destination);
  writeln('Done');
end.
