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

  function evaluate(v: longint): ShortString;
  var
    i: longint = 0;
  begin
    evaluate := '';
    while v > 0 do
    begin
      if v mod 2 > 0 then
        evaluate := evaluate + IntToStr(src[i]);
      i += 1;
      v := v div 2;
    end;
  end;

  function full_search(): ShortString;
  var
    i: longint;
    str, strmax: ShortString;
    found: boolean = False;
  begin
    for i := 0 to (1 shl src_size) - 1 do
      if binary_digits_sum(i) = src_size - k then
      begin
        str := evaluate(i);
        if not found or (str > strmax) then
        begin
          found := True;
          strmax := str;
        end;
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
