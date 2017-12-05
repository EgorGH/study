program test;

uses
  SysUtils;

const
  Lim = 10;
  MaxT = 10000;

var
  src, dst: array[0..Lim] of byte;
  src_size, dst_size: longint;
  str: ShortString;
  i, k, t: longint;

  function binary_digits_sum(x: longint): longint;
  begin
    binary_digits_sum := 0;
    while x > 0 do
    begin
      binary_digits_sum += x mod 2;
      x := x div 2;
    end;
  end;

  function evaluate(v: longint): ShortString;
  var
    i: longint = 0;
  begin
    evaluate := '';
    while v > 0 do
    begin
      if v mod 2 > 0 then
        evaluate := evaluate + IntToStr(src[i]);
      i += 1;
      v := v div 2;
    end;
  end;

  function full_search(): ShortString;
  var
    i: longint;
    str, strmax: ShortString;
    found: boolean = False;
  begin
    for i := 0 to (1 shl src_size) - 1 do
      if binary_digits_sum(i) = src_size - k then
      begin
        str := evaluate(i);
        if not found or (str > strmax) then
        begin
          found := True;
          strmax := str;
        end;
      end;
    exit(strmax);
  end;

  procedure optimal_search(start, k: longint);
  var
    i, imax: longint;
    dmax, d: byte;
  begin
    if start + k = src_size then
      exit();

    if k = 0 then
    begin
      for i := 0 to src_size - start - 1 do
        dst[dst_size + i] := src[start + i];
      dst_size += src_size - start;
      exit();
    end;

    dmax := 0;
    imax := start;
    for i := start to start + k do
    begin
      d := src[i];

      if d > dmax then
      begin
        dmax := d;
        imax := i;
      end;

      if d = 9 then
        break;
    end;

    dst[dst_size] := dmax;
    dst_size += 1;
    optimal_search(imax + 1, k - imax + start);
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
    optimal_search(0, k);

    for i := 0 to src_size - k - 1 do
      if str[i + 1] <> IntToStr(dst[i]) then
        writeln('Error');
  end;
  writeln('Done');
end.
