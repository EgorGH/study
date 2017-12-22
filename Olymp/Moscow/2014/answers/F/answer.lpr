program answer;

uses
  strutils;

const
  Lim = 850;

var
  words: array[1..Lim] of shortstring;
  codes, visits, max_phrase: array[1..Lim] of longint;
  i, max_size, n: longint;

  function bits_count(x: longint): longint;
  begin
    bits_count := 0;
    while x > 0 do
    begin
      bits_count += x mod 2;
      x := x div 2;
    end;
  end;

  procedure full_search(start, used_letters: longint);
  var
    i: longint;
  begin
    if codes[start] shr 26 = 1 then
      exit();

    visits[start] := 1;

    if bits_count(used_letters) > max_size then
    begin
      max_size := bits_count(used_letters);
      max_phrase := visits;
    end;

    for i := start + 1 to n do
      if codes[i] and used_letters = 0 then
        full_search(i, used_letters or codes[i]);

    visits[start] := 0;
  end;

  procedure fill_codes();
  var
    i, j, code: longint;
    w: shortstring;
  begin
    for i := 1 to n do
    begin
      code := 0;
      w := words[i];
      for j := 1 to length(w) do
        if pos(w[j], w) = rpos(w[j], w) then
          code := code or (1 shl (Ord(w[j]) - Ord('a')))
        else
          code := 1 shl 26;
      codes[i] := code;
    end;
  end;

begin
  readln(n);
  for i := 1 to n do
    readln(words[i]);

  fill_codes();
  for i := 1 to n do
    full_search(i, codes[i]);

  writeln(max_size);
  for i := 1 to n do
    if max_phrase[i] = 1 then
      Write(words[i], ' ');
end.

