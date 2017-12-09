program answer;

const
  Lim = 1000000;

var
  src, dst: array[0..Lim] of byte;
  c: char;
  d, i, k, src_size, dst_size: longint;

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

  optimal_search(k, 0);

  for i := 0 to dst_size - 1 do
    Write(dst[i]);
  writeln();
end.
