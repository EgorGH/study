program answer;

const
  Lim = 1000000;

type
  longstring = record
    Data: ^byte;
    size: longint;
  end;

var
  src, dst: longstring;
  c: char;
  i, k: longint;

  procedure optimal_search(var src, dst: longstring; k, start, q: longint);
  var
    i, imax: longint;
    dmax, d: byte;
  begin
    if k = src.size - start then
      exit();

    if k = 0 then
    begin
      for i := 0 to src.size - start - 1 do
        dst.data[q + i] := src.data[start + i];
      exit();
    end;

    dmax := 0;
    for i := start to start + k do
    begin
      d := src.data[i];

      if d > dmax then
      begin
        dmax := d;
        imax := i;
      end;

      if d = 9 then
        break;
    end;

    dst.Data[q] := dmax;
    optimal_search(src, dst, k - imax + start, imax + 1, q + 1);
  end;

begin
  src.Data := GetMem(Lim * sizeof(byte));
  dst.Data := GetMem(Lim * sizeof(byte));

  i := -1;
  repeat
    i += 1;
    Read(c);
    src.data[i] := ord(c) - 48;
  until (Ord(c) < 48) or (Ord(c) > 57);
  readln(k);

  src.size := i;
  dst.size := src.size - k;

  optimal_search(src, dst, k, 0, 0);

  for i := 0 to dst.size - 1 do
    Write(dst.Data[i]);
  writeln();
end.
