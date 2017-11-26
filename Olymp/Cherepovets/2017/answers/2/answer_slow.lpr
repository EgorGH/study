program answer_slow;

uses
  SysUtils;

const
  Lim = 1000000;

type
  longstring = record
    Data: ^char;
    size: longint;
  end;

var
  src, dst: longstring;
  i, k: longint;

  function binary_digits_sum(x: longint): longint;
  begin
    binary_digits_sum := 0;
    while x > 0 do
    begin
      binary_digits_sum += x mod 2;
      x := x div 2;
    end;
  end;

  function eval(var src: longstring; v: longint): longint;
  var
    str: shortstring;
    i: longint;
  begin
    str := '';
    for i := src.size - 1 downto 0 do
    begin
      if v mod 2 <> 0 then
        str := src.Data[i] + str;
      v := v div 2;
    end;

    exit(StrToInt(str));
  end;

  procedure full_search(var src, dst: longstring);
  var
    str: shortstring;
    i, num, nmax: longint;
    found: boolean = False;
  begin
    for i := 0 to (1 shl src.size) - 1 do
      if binary_digits_sum(i) = dst.size then
      begin
        num := eval(src, i);
        if not found or (num > nmax) then
        begin
          found := True;
          nmax := num;
        end;
      end;

    str := IntToStr(nmax);
    for i := 0 to length(str) - 1 do
      dst.Data[i] := str[i + 1];
  end;

begin
  src.Data := GetMem(Lim * sizeof(char));
  dst.Data := GetMem(Lim * sizeof(char));

  i := -1;
  repeat
    i += 1;
    Read(src.Data[i]);
  until (Ord(src.Data[i]) < 48) or (Ord(src.Data[i]) > 57);
  readln(k);

  src.size := i;
  dst.size := src.size - k;

  full_search(src, dst);

  for i := 0 to dst.size - 1 do
    Write(dst.Data[i]);
  writeln();
end.


