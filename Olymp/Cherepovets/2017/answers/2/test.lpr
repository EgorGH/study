program test;

uses
  SysUtils;

const
  MaxT = 100000;
  MaxStr = 100000000;

type
  longstring = record
    Data: ^char;
    size: longint;
  end;

var
  src, dst_full, dst_optimal: longstring;
  str: shortstring;
  i, t, k, Lim: longint;

  function binary_digits_sum(x: longint): longint;
  begin
    binary_digits_sum := 0;
    while x > 0 do
    begin
      binary_digits_sum += x mod 2;
      x := x div 2;
    end;
  end;

  function eval(var src: longstring; v: longint): longint;
  var
    str: shortstring;
    i: longint;
  begin
    str := '';
    for i := src.size - 1 downto 0 do
    begin
      if v mod 2 <> 0 then
        str := src.Data[i] + str;
      v := v div 2;
    end;

    exit(StrToInt(str));
  end;

  procedure full_search(var src, dst: longstring);
  var
    str: shortstring;
    i, num, nmax: longint;
    found: boolean = False;
  begin
    for i := 0 to (1 shl src.size) - 1 do
      if binary_digits_sum(i) = dst.size then
      begin
        num := eval(src, i);
        if not found or (num > nmax) then
        begin
          found := True;
          nmax := num;
        end;
      end;

    str := IntToStr(nmax);
    for i := 0 to length(str) - 1 do
      dst.Data[i] := str[i + 1];
  end;

  procedure optimal_search(src, dst: longstring; k, start, q: longint);
  var
    i, imax: longint;
    dmax: char;
    found: boolean = False;
  begin
    if k = src.size - start then
      exit();

    if k = 0 then
    begin
      for i := start to src.size - 1 do
      begin
        dst.Data[q] := src.Data[i];
        q := q + 1;
      end;
      exit();
    end;

    for i := start to start + k do
      if not found or (src.Data[i] > dmax) then
      begin
        found := True;
        dmax := src.Data[i];
        imax := i;
      end;

    dst.Data[q] := dmax;
    optimal_search(src, dst, k - imax + start, imax + 1, q + 1);
  end;

begin
  randomize;
  Lim := length(IntToStr(MaxStr));
  src.Data := GetMem(Lim * sizeof(char));
  dst_full.Data := GetMem(Lim * sizeof(char));
  dst_optimal.Data := GetMem(Lim * sizeof(char));

  for t := 1 to MaxT do
  begin
    str := IntToStr(random(MaxStr) + 1);
    src.size := length(str);
    k := random(src.size);

    dst_full.size := src.size - k;
    dst_optimal.size := src.size - k;

    for i := 0 to src.size - 1 do
      src.Data[i] := str[i + 1];

    full_search(src, dst_full);
    optimal_search(src, dst_optimal, k, 0, 0);

    for i := 0 to src.size - k - 1 do
      if dst_full.Data[i] <> dst_optimal.Data[i] then
        writeln('Error');
  end;
  writeln('Done');
end.
