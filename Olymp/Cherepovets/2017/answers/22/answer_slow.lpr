program answer_slow;

uses
  SysUtils;

var
  k: longint;
  num: shortstring;

  function sum(x: longint): longint;
  begin
    sum := 0;
    while x <> 0 do
    begin
      sum += x mod 2;
      x := x div 2;
    end;
  end;

  function eval(v: longint): longint;
  var
    i: longint;
    newnum: shortstring;
  begin
    newnum := '';
    for i := length(num) downto 1 do
    begin
      if v mod 2 <> 0 then
        newnum := num[i] + newnum;
      v := v div 2;
    end;

    exit(StrToInt(newnum));
  end;

  function full_search(): shortstring;
  var
    v, t, tmax: longint;
    found: boolean = False;
  begin
    for v := 0 to 1 shl (length(num)) - 1 do
    begin
      if sum(v) = length(num) - k then
      begin
        t := eval(v);
        if not found or (t > tmax) then
        begin
          found := True;
          tmax := t;
        end;
      end;
    end;

    exit(IntToStr(tmax));
  end;

begin
  readln(num);
  readln(k);

  writeln(full_search());
end.

