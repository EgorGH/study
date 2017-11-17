program answer;

uses
  SysUtils;

const
  Lim = 1000;

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
  decrypt(input, output);
end.
