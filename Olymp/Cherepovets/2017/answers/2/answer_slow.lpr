program answer_slow;

uses
  SysUtils;

type
  tdata = ^char;

var
  Data: tdata;
  i, k, size: longint;

  function binary_digits_sum(x: longint): longint;
  begin
    binary_digits_sum := 0;
    while x > 0 do
    begin
      binary_digits_sum += x mod 2;
      x := x div 2;
    end;
  end;

  function eval(Data: tdata; size, v: longint): longint;
  var
    i: longint;
    newstr: shortstring;
  begin
    newstr := '';
    for i := size downto 1 do
    begin
      if v mod 2 <> 0 then
        newstr := Data[i] + newstr;
      v := v div 2;
    end;

    exit(StrToInt(newstr));
  end;

  function full_search(Data: tdata; size, k: longint): shortstring;
  var
    v, num, nmax: longint;
    found: boolean = False;
  begin
    for v := 0 to 1 shl size - 1 do
      if binary_digits_sum(v) = size - k then
      begin
        num := eval(Data, size, v);
        if not found or (num > nmax) then
        begin
          found := True;
          nmax := num;
        end;
      end;

    exit(IntToStr(nmax));
  end;

begin
  Data := GetMem(1000000 * sizeof(char));

  i := 1;
  Read(Data[i]);
  while Data[i] <> chr(13) do
  begin
    i := i + 1;
    Read(Data[i]);
  end;

  size := i - 1;

  readln(k);

  writeln(full_search(Data, size, k));
end.

