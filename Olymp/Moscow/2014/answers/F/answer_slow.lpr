program answer_slow;

type
  twords = ^shortstring;
  tvisits = ^byte;

var
  N, i: longint;
  words: twords;
  visits: tvisits;
  phrase, maxPhrase: shortstring;
  phraseSize, maxSize: longint;
  check: longint;
  use_save: boolean = true;
  first_word: boolean;

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

    if visits[pos] = 1 then
    begin
      use_save := false;
      exit();
    end;

    x := words[pos];
    letters := 0;

    for i := 1 to length(x) do
    begin
      d := (1 shl (Ord(x[i]) - 97));
      if letters and d = 1 then
      begin
        use_save := false;
        exit();
      end;
      letters := letters or d;
    end;

    if check and letters <> 0 then
    begin
      use_save := false;
      exit();
    end;

    check := check or letters;

    visits[pos] := 1;
    check_save := check;
    phrase_save := phrase;
    phraseSize_save := phraseSize;

    if not first_word then
    begin
      phrase := phrase + ' ' + x;
      phraseSize := phraseSize + length(x);
    end;
    first_word := False;

    for i := 0 to N - 1 do
      if i <> pos then
      begin
        full_search(words, i);
        if use_save then
        begin
          check := check_save;
          phrase := phrase_save;
          phraseSize := phraseSize_save;
          visits[i] := 0;
        end;
        use_save := true;
      end;
  end;

begin
  readln(N);

  words := GetMem(N * sizeof(shortstring));
  visits := GetMem(N * sizeof(byte));
  FillByte(visits[0], N * sizeof(byte), 0);

  for i := 0 to N - 1 do
    readln(words[i]);

  for i := 0 to N - 1 do
  begin
    first_word := True;
    phrase := words[i];
    phraseSize := length(words[i]);
    check := 0;
    full_search(words, i);
  end;

  writeln(maxSize);
  writeln(maxPhrase);
end.
