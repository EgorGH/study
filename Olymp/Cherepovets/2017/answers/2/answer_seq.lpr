program answer_seq;

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
    while (k <> src.size - start) do
    begin
      if k = 0 then
      begin
        for i := 0 to src.size - start - 1 do
          dst.Data[q + i] := src.Data[start + i];
        exit();
      end;

      dmax := 0;
      for i := start to start + k do
      begin
        d := src.Data[i];

        if d > dmax then
        begin
          dmax := d;
          imax := i;
        end;

        if d = 9 then
          break;
      end;

      dst.Data[q] := dmax;

      k := k - imax + start;
      start := imax + 1;
      q := q + 1;
    end;
  end;

begin
  src.Data := GetMem(Lim * sizeof(byte));
  dst.Data := GetMem(Lim * sizeof(byte));

  i := -1;
  repeat
    i += 1;
    Read(c);
    src.Data[i] := Ord(c) - 48;
  until (Ord(c) < 48) or (Ord(c) > 57);
  readln(k);

  src.size := i;
  dst.size := src.size - k;

  optimal_search(src, dst, k, 0, 0);

  for i := 0 to dst.size - 1 do
    Write(dst.Data[i]);
  writeln();
end.
