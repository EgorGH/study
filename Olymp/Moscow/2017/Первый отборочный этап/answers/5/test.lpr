program test;

uses
  SysUtils,
  strutils,
  Math;

const
  MaxT = 10000;

var
  t: longint;
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

  function digit_sum(s: ansistring): longint;
  var
    i: longint;
  begin
    digit_sum := 0;
    for i := 1 to length(s) do
      digit_sum += Ord(s[i]) - Ord('0');
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

  function get_leftstr(s: ansistring): ansistring;
  begin
    exit(copy(s, 1, length(s) div 2));
  end;

  function get_rightstr(s: ansistring): ansistring;
  begin
    exit(copy(s, length(s) div 2 + 1, length(s) div 2));
  end;

  procedure increase(var s: ansistring; var a, b: longint);
  var
    i: longint;
  begin
    i := length(s) + 1;
    repeat
      i -= 1;
      b += ord('9') - ord(s[i]);
      s[i] := '9';
    until a <= b;
    s[i] := chr(ord(s[i]) + a - b);
    b := a;
  end;

  procedure decrease(var s: ansistring; var a, b: longint);
  var
    i: longint;
  begin
    i := length(s) + 1;
    repeat
      i -= 1;
      b -= Ord(s[i]) - Ord('0');
      s[i] := '0';
    until a > b;

    repeat
      i -= 1;
      s[i] := chr((Ord(s[i]) - Ord('0') + 1) mod 10 + Ord('0'));
    until s[i] > '0';

    a := digit_sum(get_leftstr(s));
    b := digit_sum(get_rightstr(s));
  end;

  function optimal_search(s: ansistring): ansistring;
  var
    w, leftsum, rightsum: longint;
  begin
    w := length(s) div 2;
    if s = dupestring('9', w * 2) then
      exit(format('%.*d%.*d', [w + 1, 1, w + 1, 1]));

    leftsum := digit_sum(get_leftstr(s));
    rightsum := digit_sum(get_rightstr(s));

    if leftsum = rightsum then
      decrease(s, leftsum, rightsum);

    while leftsum <> rightsum do
      if leftsum < rightsum then
        decrease(s, leftsum, rightsum)
      else
        increase(s, leftsum, rightsum);

    exit(s);
  end;

  function process_test(): boolean;
  var
    d: longint;
  begin
    d := power_10(4) - 1;
    s := format('%.*d%.*d', [4, random(d) + 1, 4, random(d) + 1]);
    exit(full_search(s) = optimal_search(s));
  end;

begin
  randomize();
  for t := 1 to MaxT do
    if not process_test() then
      writeln('error');
  writeln('done!');
end.
