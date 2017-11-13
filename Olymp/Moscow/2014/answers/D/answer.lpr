program answer;

uses
  SysUtils;

type
  TPair = record
    a: ansistring;
    b: ansistring;
  end;

var
  N, i: longint;
  c: ansistring;
  res, pair: TPair;

  function optimal_search(pair: TPair; c: ansistring): TPair;
  var
    a, b, t, savea, saveb: ansistring;
    k: array[0..1000] of longint;
    j, y, i, s: longint;
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

    for i := 0 to length(c) + 1 do
      k[i] := 0;

    for i := length(c) downto 1 do
    begin
      if (a[i] <> '?') then
      begin
        if (StrToInt(a[i]) + k[i] > StrToInt(c[i])) then
          k[i - 1] := 1;
        if (b[i] <> '?') then
        begin
          if ((StrToInt(a[i]) + StrToInt(b[i])) mod 10 < StrToInt(c[i])) then
            k[i] := 1;
          if StrToInt(a[i]) + StrToInt(b[i]) > 9 then
            k[i - 1] := 1;
        end;
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

    for i := length(c) downto 1 do
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
          s := ((10 + StrToInt(c[i]) - k[i] - StrToInt(a[i])) mod 10);
          b[i] := chr(s + Ord('0'));
        end;

        if k[i - 1] = 1 then
        begin
          for j := 0 to 9 do
            for y := 9 downto 0 do
              if (j + y) mod 10 = StrToInt(c[i]) then
              begin
                a[i] := chr(j + Ord('0'));
                b[i] := chr(y + Ord('0'));
              end;
        end;

        if (k[i] = 1) and (i > 1) then
        begin
          a[i] := '0';
          b[i] := '9';
        end;
        continue;
      end;

      if a[i] <> '?' then
      begin
        s := ((10 + StrToInt(c[i]) - k[i] - StrToInt(a[i])) mod 10);
        b[i] := chr(s + Ord('0'));
      end;

      if a[i] = '?' then
      begin
        s := ((10 + StrToInt(c[i]) - k[i] - StrToInt(b[i])) mod 10);
        a[i] := chr(s + Ord('0'));
      end;
    end;

    if length(c) > length(savea) then
    begin
      Delete(a, 1, 1);
      Delete(b, 1, 1);
    end;

    if length(saveb) < length(c) then
      Delete(b, length(saveb) + 1, length(c) - length(saveb));

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
  readln();
end.
