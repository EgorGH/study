program test;

uses
  SysUtils;

const
  MaxT = 10000;
  MaxNum = 100000000;

var
  num: shortstring;
  t, k: longint;

  function binary_digit_sum(x: longint): longint;
  begin
    binary_digit_sum := 0;
    while x <> 0 do
    begin
      binary_digit_sum += x mod 2;
      x := x div 2;
    end;
  end;

  function eval(v: longint): longint;
  var
    i: longint;
    newnum: shortstring;
  begin
    newnum := '';

    for i := length(num) downto 1 do
    begin
      if v mod 2 <> 0 then
        newnum := num[i] + newnum;

      v := v div 2;
    end;

    exit(StrToInt(newnum));
  end;

  function full_search(): shortstring;
  var
    v, t, tmax: longint;
    found: boolean = False;
  begin
    for v := 0 to 1 shl (length(num)) - 1 do
    begin
      if binary_digit_sum(v) = length(num) - k then
      begin
        t := eval(v);
        if not found or (t > tmax) then
        begin
          found := True;
          tmax := t;
        end;
      end;
    end;
    exit(IntToStr(tmax));
  end;

  function p(start, index: longint): shortstring;
  var
    i, imax: longint;
    nmax: shortstring;
    found: boolean = False;
  begin
    if index > length(num) - k then
      exit('');

    for i := start to k + index do
    begin
      if not found or (num[i] > nmax) then
      begin
        found := True;
        nmax := num[i];
        imax := i;
      end;
    end;

    p := nmax + p(imax + 1, index + 1);
  end;

  function optimal_search(): shortstring;
  begin
    exit(p(1, 1));
  end;

begin
  for t := 1 to MaxT do
  begin
    num := IntToStr(random(MaxNum) + 10);
    k := random(length(num) - 1) + 1;
    if full_search() <> optimal_search() then
      writeln('Error');
  end;
  writeln('Done');
end.

