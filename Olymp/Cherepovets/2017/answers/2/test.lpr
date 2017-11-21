program test;

uses
  SysUtils;

const
  MaxT = 10000;
  MaxStr = 100000000;

type
  tdata = ^char;

var
  Data: tdata;
  str: shortstring;
  size, i, t, k: longint;

  function binary_digits_sum(x: longint): longint;
  begin
    binary_digits_sum := 0;
    while x > 0 do
    begin
      binary_digits_sum += x mod 2;
      x := x div 2;
    end;
  end;

  function eval(Data: tdata; size, v: longint): longint;
  var
    i: longint;
    newstr: shortstring;
  begin
    newstr := '';
    for i := size downto 1 do
    begin
      if v mod 2 <> 0 then
        newstr := Data[i] + newstr;
      v := v div 2;
    end;

    exit(StrToInt(newstr));
  end;

  function full_search(Data: tdata; size, k: longint): shortstring;
  var
    v, num, nmax: longint;
    found: boolean = False;
  begin
    for v := 0 to 1 shl size - 1 do
      if binary_digits_sum(v) = size - k then
      begin
        num := eval(Data, size, v);
        if not found or (num > nmax) then
        begin
          found := True;
          nmax := num;
        end;
      end;

    exit(IntToStr(nmax));
  end;

  function optimal_search(Data: tdata; size, k, start, index: longint): shortstring;
  var
    i, imax: longint;
    nmax: char;
    found: boolean = False;
  begin
    if k + index = start then
    begin
      optimal_search := '';
      for i := start to size do
        optimal_search += data[i];
      exit(optimal_search);
    end;

    if index > size - k then
      exit('');

    for i := start to k + index do
      if not found or (data[i] > nmax) then
      begin
        found := True;
        nmax := data[i];
        imax := i;
      end;

    optimal_search := nmax + optimal_search(Data, size, k, imax + 1, index + 1);
  end;

begin
  randomize;
  Data := GetMem(1000000 * sizeof(char));
  for t := 1 to MaxT do
  begin
    str := IntToStr(random(MaxStr) + 1);
    size := length(str);
    for i := 1 to size do
      Data[i] := str[i];
    k := random(size - 1) + 1;
    if full_search(Data, size, k) <> optimal_search(Data, size, k, 1, 1) then
      writeln('Error');
  end;
  writeln('Done');
end.

