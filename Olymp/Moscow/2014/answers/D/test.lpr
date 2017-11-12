program test;

uses
  SysUtils;

const
  MaxT = 100;
  MaxA = 100;
  MaxB = 100;
  MaxNull = 3;
  MaxProb = 20;

type
  TPair = record
    a: shortstring;
    b: shortstring;
  end;

var
  t: longint;
  r: shortstring;
  res, save, pair: TPair;

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
    a, b, t, savea, saveb: shortstring;
    k: array[0..255] of longint;
    lena, lenb, lenc, i, s: longint;
  begin
    a := pair.a;
    b := pair.b;

    if length(a) < length(b) then
    begin
      t := a;
      a := b;
      b := t;
    end;

    savea := a;
    saveb := b;

    for i := 1 to length(c) - length(a) do
    begin
      a := '0' + a;
      b := '0' + b;
    end;

    for i := length(b) + 1 to length(c) do
      b := b + '0';

    lena := length(a);
    lenb := length(b);
    lenc := length(c);

    for i := 0 to lena + 1 do
      k[i] := 0;

    for i := lena downto 1 do
    begin
      if (a[i] <> '?') then
      begin
        if (StrToInt(a[i]) + k[i] > StrToInt(c[i])) then
          k[i - 1] := 1;
      end
      else
      if (b[i] <> '?') then
      begin
        if (StrToInt(b[i]) + k[i] > StrToInt(c[i])) then
          k[i - 1] := 1;
      end
      else
      if (a[i] = '?') and (b[i] = '?') and (c[i] = '0') and (k[i] = 1) then
        k[i - 1] := 1
      else
        k[i - 1] := 0;
    end;

    for i := lenb downto 1 do
    begin
      if (a[i] <> '?') and (b[i] <> '?') then
      begin
        k[i - 1] := (StrToInt(a[i]) + StrToInt(b[i])) div 10;
        continue;
      end;

      if (a[i] = '?') and (b[i] = '?') then
      begin
        if k[i - 1] = 0 then
        begin
          a[i] := '0';
          s := ((10 + StrToInt(c[i]) - k[i] - StrToInt(a[i])) mod
            10);
          b[i] := chr(s + Ord('0'));
        end;

        if k[i - 1] = 1 then
        begin
          a[i] := '1';
          b[i] := '9';
        end;
        continue;
      end;

      if a[i] <> '?' then
      begin
        s := ((10 + StrToInt(c[i]) - k[i] - StrToInt(a[i])) mod
          10);
        b[i] := chr(s + Ord('0'));
      end;

      if a[i] = '?' then
      begin
        s := ((10 + StrToInt(c[i]) - k[i] - StrToInt(b[i])) mod
          10);
        a[i] := chr(s + Ord('0'));
      end;
    end;

    if lenc > length(savea) then
    begin
      Delete(a, 1, 1);
      Delete(b, 1, 1);
    end;

    if length(saveb) < lenc then
      delete(b, length(saveb) + 1, lenc - length(saveb));

    if length(pair.a) < length(pair.b) then
    begin
      t := a;
      a := b;
      b := t;
    end;

    optimal_search.a := a;
    optimal_search.b := b;
  end;

begin
  //randomize;
  //for t := 1 to MaxT do
  //begin
  //  randomize_numbers(pair);
  //  save := pair;
  //  r := f(pair);
  //  replace_with_questionmarks(pair);
  //  res := optimal_search(pair, r);
  //  if (save.a <> res.a) or (save.b <> res.b) then
  //    writeln('Error');
  //end;
  pair.a := '??';
  pair.b := '?';
  r := '100';
  writeln(optimal_search(pair, r).a);
  writeln(optimal_search(pair, r).b);
  writeln('Done');
  readln();
end.
