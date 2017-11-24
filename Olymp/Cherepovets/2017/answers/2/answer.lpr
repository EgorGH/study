program answer;

const
  Lim = 1000000;

type
  tdata = ^char;

var
  Data: tdata;
  i, k, size: longint;

  procedure optimal_search(Data: tdata; size, k, start: longint);
  var
    i, imax: longint;
    dmax: char;
    found: boolean = False;
  begin
    if k = size - start then
      exit();

    if k = 0 then
    begin
      for i := start to size - 1 do
        Write(Data[i]);
      exit();
    end;

    for i := start to start + k do
      if not found or (Data[i] > dmax) then
      begin
        found := True;
        dmax := Data[i];
        imax := i;
      end;

    Write(dmax);
    optimal_search(Data, size, k - imax + start, imax + 1);
  end;

begin
  Data := GetMem(Lim * sizeof(char));

  i := -1;
  repeat
    i += 1;
    Read(Data[i]);
  until (Ord(Data[i]) < 48) or (Ord(Data[i]) > 57);

  size := i;

  readln(k);

  optimal_search(Data, size, k, 0);
  writeln();
end.
