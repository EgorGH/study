program answer_slow;

uses
  SysUtils;

const
  Lim = 30;

var
  src: array[0..Lim] of byte;
  c: char;
  d, i, k, src_size: longint;

  function binary_digits_sum(x: longint): longint;
  begin
    binary_digits_sum := 0;
    while x > 0 do
    begin
      binary_digits_sum += x mod 2;
      x := x div 2;
    end;
  end;

  function eval(v: longint): shortstring;
  var
    str: shortstring = '';
    i: longint = 0;
  begin
    while v > 0 do
    begin
      if v mod 2 <> 0 then
        str := str + IntToStr(src[i]);
      v := v div 2;
      i += 1;
    end;
    exit(str);
  end;

  function full_search(): shortstring;
  var
    str, strmax: shortstring;
    i: longint;
    found: boolean = False;
  begin
    i := 0;
    while i < (1 shl src_size) do
    begin
      if binary_digits_sum(i) = src_size - k then
      begin
        str := eval(i);
        if not found or (str > strmax) then
        begin
          found := True;
          strmax := str;
        end;
      end;
      i += 1;
    end;
    exit(strmax);
  end;

begin
  i := 0;
  repeat
    Read(c);
    d := Ord(c) - 48;
    src[i] := d;
    i += 1;
  until (d < 0) or (d > 9);
  readln(k);

  src_size := i - 1;

  writeln(full_search());
end.
