program answer_slow;

uses
  SysUtils;

var
  num, j: longint;
  q: longint = 26;
  letter: char;
  str, numstr: ansistring;
  word: ansistring = '';
  dictionary: array[1..1000] of ansistring;

  procedure init();
  var
    i: longint;
  begin
    for i := 1 to 26 do
      dictionary[i] := chr(i + 64);
  end;

  procedure add_to_dictionary(num: longint; letter: char);
  begin
    dictionary[q] := dictionary[num] + letter;
    word := word + dictionary[q];
  end;

begin
  init();
  while not eof(input) do
  begin
    q := q + 1;
    readln(input, str);
    j := 1;
    numstr := '';

    while str[j] <> chr(9) do
    begin
      numstr := numstr + str[j];
      j := j + 1;
    end;

    num := StrToInt(numstr);
    letter := str[length(str)];

    add_to_dictionary(num, letter);
  end;
  writeln(word);
end.

