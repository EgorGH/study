program test;

uses
  SysUtils;

const
  Lim = 30;
  MaxT = 1000;
  MaxLength = 50;

var
  Source_generated, destination, source_decrypted: TextFile;
  t: longint;

  procedure generate_source(var Source: TextFile);
  var
    i: longint;
  begin
    for i := 1 to random(MaxLength) + 1 do
      Write(Source, chr(random(26) + 65));
  end;

  procedure crypt(var Source, destination: TextFile);
  var
    word: shortstring;
    temp: shortstring = '';
    dictionary, t: array of shortstring;
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
      j := 1;
      while j <= q do
      begin
        if dictionary[j] = temp then
        begin
          found := True;
          prev_num := num;
          num := j;
          break;
        end;
        j := j + 1;
      end;

      if not found then
      begin
        q := q + 1;
        if q > Lim * n - 1 then
        begin
          n := n + 1;
          SetLength(t, Lim * n);
          for j := 0 to Lim * (n - 1) - 1 do
            t[j] := dictionary[j];
          dictionary := nil;
          dictionary := t;
        end;
        dictionary[q] := temp;
        Writeln(destination, num, chr(9), temp[length(temp)]);
        temp := '';
      end;

      if i = length(word) then
        if length(temp) = 1 then
          writeln(destination, 0, chr(9), temp)
        else if found then
          writeln(destination, prev_num, chr(9), temp[length(temp)]);

      found := False;
    end;
  end;

  procedure decrypt(var Source, destination: TextFile);
  var
    i, q, num, n: longint;
    letter: char;
    str: shortstring;
    dictionary, t: array of shortstring;
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
        SetLength(t, Lim * n);
        for i := 0 to Lim * (n - 1) - 1 do
          t[i] := dictionary[i];
        dictionary := nil;
        dictionary := t;
      end;
      dictionary[q] := dictionary[num] + letter;
      Write(destination, dictionary[q]);
    end;
  end;

  function compare(var textA, textB: TextFile): boolean;
  var
    wordA, wordB: shortstring;
    i: longint;
  begin
    Read(textA, wordA);
    Read(textB, wordB);

    if length(wordA) <> length(wordB) then
      exit(False);

    for i := 1 to length(wordA) do
      if wordA[i] <> wordB[i] then
        exit(False);

    exit(True);
  end;

begin
  randomize;
  for t := 1 to MaxT do
  begin
    Assign(Source_generated, 'Source_generated.txt');
    Assign(destination, 'destination.txt');
    Assign(Source_decrypted, 'Source_decrypted.txt');

    Rewrite(Source_generated);
    generate_source(Source_generated);

    Reset(Source_generated);
    Rewrite(destination);
    crypt(Source_generated, destination);

    Reset(destination);
    Rewrite(Source_decrypted);
    decrypt(destination, Source_decrypted);

    Reset(Source_generated);
    Reset(Source_decrypted);
    if not compare(Source_generated, Source_decrypted) then
      writeln('Error');

    Close(Source_generated);
    Close(destination);
    Close(Source_decrypted);
    Erase(Source_generated);
    Erase(destination);
    Erase(Source_decrypted);
  end;
  writeln('Done');
end.
