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

  procedure full_search(words: twords; pos: longint);
  var
    i, d, letters, phraseSize_save, check_save: longint;
    x, phrase_save: shortstring;
  begin
    if phraseSize > maxSize then
    begin
      maxSize := phraseSize;
      maxPhrase := phrase;
    end;

    x := words[pos];
    letters := 0;

    for i := 1 to length(x) do
    begin
      d := (1 shl (Ord(x[i]) - 97));
      if letters and d = 1 then
      begin
        flag := true;
        exit();
      end;
      letters := letters or (1 shl (Ord(x[i]) - 97));
    end;

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
      phrase := phrase + x + ' ';
      phraseSize := phraseSize + length(x);
    end;
    First := False;

    for i := 0 to N - 1 do
    begin
      full_search(words, i);
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
    full_search(words, i);
  end;

  writeln(maxSize);
  writeln(maxPhrase);
end.
