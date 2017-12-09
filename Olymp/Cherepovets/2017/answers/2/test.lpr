program test;

uses
  SysUtils;

const
  MaxT = 10000;
  Lim = 10;

var
  src, dst: array[0..Lim] of byte;
  str: shortstring;
  i, k, t, src_size, dst_size: longint;

  function binary_digits_sum(x: longint): longint;
  begin
    binary_digits_sum := 0;
    while x > 0 do
    begin
      binary_digits_sum += x mod 2;
      x := x div 2;
    end;
  end;

  function eval(v: longint): shortstring;
  var
    str: shortstring = '';
    i: longint = 0;
  begin
    while v > 0 do
    begin
      if v mod 2 <> 0 then
        str := str + IntToStr(src[i]);
      v := v div 2;
      i += 1;
    end;
    exit(str);
  end;

  function full_search(): shortstring;
  var
    str, strmax: shortstring;
    i: longint;
    found: boolean = False;
  begin
    i := 0;
    while i < (1 shl src_size) do
    begin
      if binary_digits_sum(i) = src_size - k then
      begin
        str := eval(i);
        if not found or (str > strmax) then
        begin
          found := True;
          strmax := str;
        end;
      end;
      i += 1;
    end;
    exit(strmax);
  end;

  procedure optimal_search(k, start: longint);
  var
    i, imax: longint;
    dmax, d: byte;
    found: boolean = False;
  begin
    if k = src_size - start then
      exit();

    if k = 0 then
    begin
      for i := 0 to src_size - start - 1 do
        dst[dst_size + i] := src[start + i];
      dst_size += src_size - start;
      exit();
    end;

    for i := start to start + k do
    begin
      d := src[i];

      if not found or (d > dmax) then
      begin
        found := True;
        dmax := d;
        imax := i;
      end;

      if d = 9 then
        break;
    end;

    dst[dst_size] := dmax;
    dst_size += 1;
    optimal_search(k - imax + start, imax + 1);
  end;

begin
  randomize;

  for t := 1 to MaxT do
  begin
    src_size := random(Lim) + 1;
    src[0] := random(9) + 1;
    for i := 1 to src_size - 1 do
      src[i] := random(10);
    k := random(src_size);

    str := full_search();

    dst_size := 0;
    optimal_search(k, 0);

    for i := 0 to src_size - k - 1 do
      if str[i + 1] <> IntToStr(dst[i]) then
        writeln('Error');
  end;
  writeln('Done');
end.
