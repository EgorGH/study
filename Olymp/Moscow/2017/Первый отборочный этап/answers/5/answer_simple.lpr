program answer_simple;

uses
  SysUtils;

var
  s: ansistring;

  function digit_sum(x: longint): longint;
  begin
    digit_sum := 0;
    while x <> 0 do
    begin
      digit_sum += x mod 10;
      x := x div 10;
    end;
  end;

  function power_10(x: longint): longint;
  begin
    power_10 := 1;
    while x <> 0 do
    begin
      power_10 *= 10;
      x -= 1;
    end;
  end;

  function full_search(s: ansistring): ansistring;
  var
    d, n, w: longint;
  begin
    n := StrToInt(s);
    w := length(s) div 2;
    d := power_10(w);

    if n = d * d - 1 then
      exit(format('%.*d%.*d', [w + 1, 1, w + 1, 1]));

    repeat
      n += 1;
    until digit_sum(n div d) = digit_sum(n mod d);

    exit(format('%.*d%.*d', [w, n div d, w, n mod d]));
  end;

begin
  readln(s);
  writeln(full_search());
end.
