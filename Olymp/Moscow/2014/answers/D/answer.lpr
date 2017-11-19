program answer;

uses
  SysUtils,
  Math;

type
  TPair = record
    a: shortstring;
    b: shortstring;
  end;

var
  N, i: longint;
  c: shortstring;
  res, pair: TPair;

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
          a[i] := '0';
          b[i] := chr(Ord(c[i]) - k[i + 1] + Ord('0') - Ord(a[i]));
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
  readln(N);
  readln();
  for i := 1 to N do
  begin
    readln(pair.a);
    readln(pair.b);
    readln(c);
    readln();
    res := optimal_search(pair, c);
    writeln(res.a);
    writeln(res.b);
    writeln();
  end;
end.
