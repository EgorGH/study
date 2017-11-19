program test;

uses
  SysUtils,
  Math;

const
  MaxT = 1000000;
  MaxA = 1000;
  MaxB = 1000;
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
  Source, destination: TPair;

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
      end
      else if (a[i] <> '?') and (Ord(a[i]) + k[i + 1] > Ord(c[i])) then
        k[i] := 1
      else if (b[i] <> '?') and (Ord(b[i]) + k[i + 1] > Ord(c[i])) then
        k[i] := 1
      else if k[i + 1] > Ord(c[i]) - ord('0') then
        k[i] := 1;


    for i := 1 to length(c) do
    begin
      if (a[i] = '?') and (b[i] = '?') then
        if k[i] = 0 then
        begin
          b[i] := '0';
          a[i] := chr(Ord(c[i]) - k[i + 1] + Ord('0') - Ord(b[i]));
        end
        else
        begin
          b[i] := '9';
          a[i] := chr(10 + Ord(c[i]) - k[i + 1] + Ord('0') - Ord(b[i]));
        end;

      if (a[i] = '?') and (b[i] <> '?') then
        if k[i] = 0 then
          a[i] := chr(Ord(c[i]) - k[i + 1] + Ord('0') - Ord(b[i]))
        else
          a[i] := chr(10 + Ord(c[i]) - k[i + 1] + Ord('0') - Ord(b[i]));

      if (a[i] <> '?') and (b[i] = '?') then
        if k[i] = 0 then
          b[i] := chr(Ord(c[i]) - k[i + 1] + Ord('0') - Ord(a[i]))
        else
          b[i] := chr(10 + Ord(c[i]) - k[i + 1] + Ord('0') - Ord(a[i]));
    end;

    s := length(c) - max(length(pair.a), length(pair.b));
    Delete(a, 1, s);
    Delete(b, 1, s);

    s := abs(length(pair.a) - length(pair.b));
    Delete(a, length(pair.a) + 1, s);
    Delete(b, length(pair.b) + 1, s);

    optimal_search.a := a;
    optimal_search.b := b;

    FreeMem(k);
  end;

begin
  randomize;
  for t := 1 to MaxT do
  begin
    randomize_numbers(Source);
    r1 := f(Source);
    replace_with_questionmarks(Source);
    destination := optimal_search(Source, r1);
    r2 := f(destination);
    if (r1 <> r2) or (length(Source.a) <> length(destination.a)) or
      (length(Source.b) <> length(destination.b)) then
      writeln('Error');
  end;
  writeln('Done');
end.
