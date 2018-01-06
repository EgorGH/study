program answer;

uses
  SysUtils,
  strutils, math;

type
  toptions = (left, right);

var
  s: ansistring;

  function digits_sum(var s: ansistring; side: toptions): longint;
  var
    i, n, start, finish: longint;
  begin
    n := length(s);
    start := IfThen(side = left, 1, n div 2 + 1);
    finish := IfThen(side = left, n div 2, n);

    digits_sum := 0;
    for i := start to finish do
      digits_sum += Ord(s[i]) - Ord('0');
  end;

  procedure increase(var s: ansistring; var a, b: longint);
  var
    i: longint;
  begin
    i := length(s) + 1;
    repeat
      i -= 1;
      b += Ord('9') - Ord(s[i]);
      s[i] := '9';
    until a <= b;
    s[i] := chr(Ord(s[i]) + a - b);
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

    a := digits_sum(s, left);
    b := digits_sum(s, right);
  end;

  function optimal_search(s: ansistring): ansistring;
  var
    w, leftsum, rightsum: longint;
  begin
    w := length(s) div 2;
    if s = dupestring('9', w * 2) then
      exit(format('%.*d%.*d', [w + 1, 1, w + 1, 1]));

    leftsum := digits_sum(s, left);
    rightsum := digits_sum(s, right);

    if leftsum = rightsum then
      decrease(s, leftsum, rightsum);

    while leftsum <> rightsum do
      if leftsum < rightsum then
        decrease(s, leftsum, rightsum)
      else
        increase(s, leftsum, rightsum);

    exit(s);
  end;

begin
  readln(s);
  writeln(optimal_search(s));
end.
