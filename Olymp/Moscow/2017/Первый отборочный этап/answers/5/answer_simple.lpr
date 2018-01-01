program answer_simple;

uses
  SysUtils, strutils, math;

var
  t: shortstring;

  function digit_sum(x: longint): longint;
  begin
    digit_sum := 0;
    while x <> 0 do
    begin
      digit_sum += x mod 10;
      x := x div 10;
    end;
  end;

  function full_search(): shortstring;
  var
    t1, t2, s1, s2, len: longint;
  begin
    len := length(t) div 2;
    t1 := StrToInt(copy(t, 1, len));
    t2 := StrToInt(copy(t, len + 1, len));

    if t = DupeString('9', len * 2) then
      exit(DupeString(DupeString('0', len) + '1', 2));

    if t2 = round(power(10, len)) - 1 then
    begin
      t1 += 1;
      t2 := 0;
      s1 := digit_sum(t1) + 1;
      s2 := 0;
    end
    else
    begin
      t2 += 1;
      s1 := digit_sum(t1);
      s2 := digit_sum(t2);
    end;

    while s1 <> s2 do
    begin
      if t2 = round(power(10, len)) - 1 then
      begin
        t1 += 1;
        t2 := 0;
      end
      else
        t2 += 1;

      if t2 mod 10 = 0 then
      begin
        s1 := digit_sum(t1);
        s2 := digit_sum(t2);
        continue;
      end;

      s2 += 1;
    end;

    exit(format('%.*d%.*d', [len, t1, len, t2]));
  end;

begin
  readln(t);
  writeln(full_search());
end.
