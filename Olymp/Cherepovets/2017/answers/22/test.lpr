program test;

uses
  SysUtils;

const
  MaxT = 10000;
  MaxNum = 100000000;

var
  num: shortstring;
  t, k: longint;

  function sum(x: longint): longint;
  begin
    sum := 0;
    while x <> 0 do
    begin
      sum += x mod 2;
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
      if sum(v) = length(num) - k then
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

  function optimal_search(start, index: longint): shortstring;
  var
    i, imax: longint;
    nmax: char;
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

    optimal_search := nmax + optimal_search(imax + 1, index + 1);
  end;

begin
  randomize;
  for t := 1 to MaxT do
  begin
    num := IntToStr(random(MaxNum) + 10);
    k := random(length(num) - 1) + 1;
    if full_search() <> optimal_search(1, 1) then
      writeln('Error');
  end;
  writeln('Done');
end.

