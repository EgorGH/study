program gen_test;

uses
  SysUtils, strutils;

const
  Lim = 100000;

var
  t: longint;
  s: ansistring;

  function digit_sum(s: ansistring): longint;
  var
    i: longint;
  begin
    digit_sum := 0;
    for i := 1 to length(s) do
      digit_sum += Ord(s[i]) - Ord('0');
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

  procedure write_test(t: longint);
  var
    infile, afile: Text;
  begin
    Assign(infile, format('tests/%.2d.', [t]));
    Assign(afile, format('tests/%.2d.a', [t]));
    rewrite(infile);
    rewrite(afile);

    writeln(infile, s);
    writeln(afile, optimal_search(s));

    Close(infile);
    Close(afile);
  end;

  procedure process_test(maxsize, t: longint);
  var
    i: longint;
  begin
    SetLength(s, maxsize);
    for i := 1 to maxsize do
      s[i] := chr(random(10) + ord('0'));
    write_test(t);
  end;

begin
  randomize();

  for t := 10 to 12 do
    process_test(8, t);

  for t := 20 to 22 do
    process_test(16, t);

  for t := 30 to 32 do
    process_test(Lim, t);

  writeln('done!');
end.
