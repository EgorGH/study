program answer;

const
  Lim = 1000000;

type
  longstring = record
    Data: ^char;
    size: longint;
  end;

var
  src, dst: longstring;
  i, k: longint;

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
        dst.data[q] := src.data[i];
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
  src.Data := GetMem(Lim * sizeof(char));
  dst.Data := GetMem(Lim * sizeof(char));

  i := -1;
  repeat
    i += 1;
    Read(src.Data[i]);
  until (Ord(src.Data[i]) < 48) or (Ord(src.Data[i]) > 57);
  readln(k);

  src.size := i;
  dst.size := src.size - k;

  optimal_search(src, dst, k, 0, 0);

  for i := 0 to dst.size - 1 do
    Write(dst.Data[i]);
  writeln();
end.
