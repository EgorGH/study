program answer_slow;

type
  twords = ^shortstring;

var
  N, i: longint;
  words: twords;
  phrase, maxPhrase: shortstring;
  phraseSize, maxSize: longint;
  check: longint;
  flag: boolean = False;
  First: boolean;

  procedure p(words: twords; pos: longint);
  var
    i, j, letters, phraseSize_save, check_save: longint;
    phrase_save: shortstring;
  begin
    if phraseSize > maxSize then
    begin
      maxSize := phraseSize;
      maxPhrase := phrase;
    end;

    letters := 0;

    for i := 1 to length(words[pos]) - 1 do
      for j := i + 1 to length(words[pos]) do
        if words[pos][i] = words[pos][j] then
        begin
          flag := True;
          exit();
        end;

    for i := 1 to length(words[pos]) do
      letters := letters or (1 shl (Ord(words[pos][i]) - 97));

    if check and letters <> 0 then
    begin
      flag := True;
      exit();
    end;

    check := check or letters;
    check_save := check;
    phrase_save := phrase;
    phraseSize_save := phraseSize;
    if not First then
    begin
      phrase := phrase + words[pos] + ' ';
      phraseSize := phraseSize + length(words[pos]);
    end;
    First := False;

    for i := 0 to N - 1 do
    begin
      p(words, i);
      if not flag then
      begin
        check := check_save;
        phrase := phrase_save;
        phraseSize := phraseSize_save;
      end;
      flag := False;
    end;
  end;

begin
  readln(N);

  words := GetMem(N * sizeof(shortstring));

  for i := 0 to N - 1 do
    readln(words[i]);

  for i := 0 to N - 1 do
  begin
    first := true;
    phrase := words[i] + ' ';
    phraseSize := length(words[i]);
    check := 0;
    p(words, i);
  end;

  writeln(maxSize);
  writeln(maxPhrase);
end.

