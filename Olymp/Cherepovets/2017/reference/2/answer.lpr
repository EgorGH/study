program answer;

const
  Lim = 1000000;

var
  src, dst: array[0..Lim] of byte;
  src_size, dst_size: longint;
  c: char;
  i, k, d: longint;

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
  i := 0;
  repeat
    Read(c);
    d := Ord(c) - 48;
    src[i] := d;
    i += 1;
  until (d < 0) or (d > 9);
  readln(k);

  src_size := i - 1;
  dst_size := 0;

  optimal_search(0, k);

  for i := 0 to dst_size - 1 do
    Write(dst[i]);
  writeln();
end.
