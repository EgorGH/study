program test;

uses
  SysUtils,
  Math;

const
  MaxT = 100000;
  MaxA = 10000000;
  MaxB = 10000000;
  MaxNull = 3;
  MaxProb = 20;

type
  TPair = record
    a: shortstring;
    b: shortstring;
  end;

var
  t: longint;
  r1, r2: shortstring;
  pair: TPair;

  procedure randomize_numbers(var pair: TPair);
  var
    i: longint;
  begin
    pair.a := IntToStr(random(MaxA));
    pair.b := IntToStr(random(MaxB));

    for i := 1 to random(MaxNull) do
      pair.a := '0' + pair.a;
    for i := 1 to random(MaxNull) do
      pair.b := '0' + pair.b;
  end;

  procedure replace_with_questionmarks(var pair: TPair);
  var
    i: longint;
  begin
    for i := 1 to length(pair.a) do
      if random(101) <= MaxProb then
        pair.a[i] := '?';
    for i := 1 to length(pair.b) do
      if random(101) <= MaxProb then
        pair.b[i] := '?';
  end;

  function f(pair: TPair): shortstring;
  var
    a, b, c: shortstring;
    i, k: longint;
  begin
    a := pair.a;
    b := pair.b;

    if length(b) > length(a) then
    begin
      c := a;
      a := b;
      b := c;
    end;

    for i := 1 to length(b) do
      a[i] := chr(Ord(a[i]) + Ord(b[i]) - Ord('0'));

    k := 0;
    for i := length(b) downto 1 do
    begin
      a[i] := chr(Ord(a[i]) + k);
      k := (Ord(a[i]) - Ord('0')) div 10;
      a[i] := chr((Ord(a[i]) - Ord('0')) mod 10 + Ord('0'));
    end;

    if k > 0 then
      a := '1' + a;

    exit(a);
  end;

  function optimal_search(pair: TPair; c: shortstring): TPair;
  var
    a, b, t: shortstring;
    k: ^longint;
    i, s: longint;
  begin
    a := pair.a;
    b := pair.b;

    t[0] := chr(abs(length(a) - length(b)));
    FillByte(t[1], Ord(t[0]), Ord('0'));
    if length(a) < length(b) then
      a := a + t
    else
      b := b + t;

    t[0] := chr(length(c) - length(a));
    FillByte(t[1], Ord(t[0]), Ord('0'));
    a := t + a;
    b := t + b;

    s := (length(c) + 2) * sizeof(longint);
    k := GetMem(s);
    FillByte(k[0], s, 0);

    for i := length(c) downto 1 do
      if (a[i] <> '?') and (b[i] <> '?') then
      begin
        k[i + 1] := (10 + Ord(c[i]) - Ord(a[i]) - Ord(b[i]) + Ord('0')) mod 10;
        k[i] := (Ord(a[i]) - Ord('0') + Ord(b[i]) - Ord('0') + k[i + 1]) div 10;
      end;

    for i := 1 to length(c) do
    begin
      s := Ord(c[i]) - k[i + 1] + Ord('0');

      if (a[i] = '?') and (b[i] = '?') then
        if k[i] = 0 then
        begin
          a[i] := '0';
          b[i] := chr(s - Ord(a[i]));
        end
        else
        begin
          a[i] := '9';
          b[i] := chr(10 + s - Ord(a[i]));
        end;

      if (a[i] = '?') and (b[i] <> '?') then
        if k[i] = 0 then
          a[i] := chr(s - Ord(b[i]))
        else
          a[i] := chr(10 + s - Ord(b[i]));

      if (a[i] <> '?') and (b[i] = '?') then
        if k[i] = 0 then
          b[i] := chr(s - Ord(a[i]))
        else
          b[i] := chr(10 + s - Ord(a[i]));
    end;

    s := length(c) - max(length(a), length(b));
    Delete(a, 1, s);
    Delete(b, 1, s);

    s := abs(length(a) - length(b));
    Delete(a, length(a) + 1, s);
    Delete(b, length(b) + 1, s);

    optimal_search.a := a;
    optimal_search.b := b;

    FreeMem(k);
  end;

begin
  randomize;
  for t := 1 to MaxT do
  begin
    randomize_numbers(pair);
    r1 := f(pair);
    replace_with_questionmarks(pair);
    r2 := f(optimal_search(pair, r1));
    if r1 <> r2 then
      writeln('Error');
  end;
  writeln('Done');
end.
