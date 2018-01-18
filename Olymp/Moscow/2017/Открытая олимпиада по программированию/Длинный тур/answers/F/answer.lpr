program answer;

uses
  SysUtils,
  Math,
  strutils;

var
  n: ansistring;

  function compare(a, b: ansistring): longint;
  var
    i: longint;
  begin
    if length(a) > length(b) then
      exit(1)
    else if length(a) < length(b) then
      exit(-1)
    else
      for i := 1 to length(a) do
        if a[i] > b[i] then
          exit(1)
        else if a[i] < b[i] then
          exit(-1);
    exit(0);
  end;

  function add(a, b: ansistring): ansistring;
  var
    i, x, y, rem, dsum: longint;
    sum: ansistring;
  begin
    while length(a) <> length(b) do
    begin
      if length(a) > length(b) then
        b := '0' + b
      else
        a := '0' + a;
    end;

    sum := '';
    rem := 0;

    for i := length(a) downto 1 do
    begin
      x := StrToInt(a[i]);
      y := StrToInt(b[i]);

      dsum := x + y + rem;

      rem := dsum div 10;
      dsum := dsum mod 10;

      sum := IntToStr(dsum) + sum;
    end;

    if rem > 0 then
      sum := IntToStr(rem) + sum;

    exit(sum);
  end;

  function subtract(a, b: ansistring): ansistring;
  var
    i, x, y, rem, ddiff: longint;
    diff: ansistring;
  begin
    while length(a) <> length(b) do
    begin
      if length(a) > length(b) then
        b := '0' + b
      else
        a := '0' + a;
    end;

    if a = b then
      exit('0');

    diff := '';
    rem := 0;

    for i := length(a) downto 1 do
    begin
      x := StrToInt(a[i]);
      y := StrToInt(b[i]);

      ddiff := 10 + x - y - rem;

      rem := IfThen(ddiff div 10 = 1, 0, 1);
      ddiff := ddiff mod 10;

      diff := IntToStr(ddiff) + diff;
    end;

    exit(TrimLeftSet(diff, ['0']));
  end;

  function mul(a, b: ansistring): ansistring;
  var
    i, j, x, y, z, rem, k: longint;
    res: shortstring;
  begin
    while length(a) <> length(b) do
    begin
      if length(a) > length(b) then
        b := '0' + b
      else
        a := '0' + a;
    end;

    res := '';
    mul := '0';

    for i := length(b) downto 1 do
    begin
      rem := 0;
      for j := length(a) downto 1 do
      begin
        x := StrToInt(a[j]);
        y := StrToInt(b[i]);
        z := x * y + rem;
        rem := z div 10;
        z := z mod 10;
        res := IntToStr(z) + res;
      end;

      if rem > 0 then
        res := IntToStr(rem) + res;

      mul := add(res, mul);
      res := '';

      for k := length(b) downto i do
        res := '0' + res;
    end;

    exit(TrimLeftSet(mul, ['0']));
  end;

  function div_by_2(a: ansistring): ansistring;
  var
    rem: shortstring;
    i, x: longint;
  begin
    rem := '';
    div_by_2 := '';

    for i := 1 to length(a) do
    begin
      x := StrToInt(rem + a[i]);
      if x >= 2 then
      begin
        div_by_2 := div_by_2 + IntToStr(x div 2);
        rem := IntToStr(x mod 2);
      end
      else
        rem := IntToStr(x);
    end;
    exit(div_by_2);
  end;

  function optimal_search(): ansistring;
  var
    i: ansistring;
  begin
    i := '1';
    while compare(i, n) < 0 do
    begin
      n := subtract(n, i);
      i := add(i, '2');
    end;

    if compare(n, div_by_2(add(i, '1'))) <= 0 then
      exit(n)
    else
      exit(add(subtract(i, n), '1'));
  end;

begin
  readln(n);
  writeln(optimal_search());
  readln();
end.
