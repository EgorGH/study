program test;

uses
  SysUtils;

const
  MaxT = 100000;
  MaxStr = 100000000;

type
  tdata = ^char;

var
  Data: tdata;
  str: shortstring;
  size, i, t, k, Lim: longint;

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
    for i := size - 1 downto 0 do
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

  function optimal_search(Data: tdata; size, k, start: longint): shortstring;
  var
    i, imax: longint;
    dmax: char;
    found: boolean = False;
  begin
    if k = size - start then
      exit('');

    if k = 0 then
    begin
      optimal_search := '';
      for i := start to size - 1 do
        optimal_search += Data[i];
      exit(optimal_search);
    end;

    for i := start to start + k do
      if not found or (Data[i] > dmax) then
      begin
        found := True;
        dmax := Data[i];
        imax := i;
      end;

    optimal_search := dmax + optimal_search(Data, size, k - imax + start, imax + 1);
  end;

begin
  randomize;
  Lim := length(IntToStr(MaxStr));
  Data := GetMem(Lim * sizeof(char));

  for t := 1 to MaxT do
  begin
    str := IntToStr(random(MaxStr) + 1);
    size := length(str);
    k := random(size);

    for i := 0 to size - 1 do
      Data[i] := str[i + 1];

    if full_search(Data, size, k) <> optimal_search(Data, size, k, 0) then
      writeln('Error');
  end;
  writeln('Done');
end.
