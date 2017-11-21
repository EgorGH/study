program answer;

type
  tdata = ^char;

var
  Data: tdata;
  i, k, size: longint;

  procedure optimal_search(Data: tdata; size, k, start, index: longint);
  var
    i, imax: longint;
    nmax: char;
    found: boolean = False;
  begin
    if k + index = start then
    begin
      for i := start to size do
        Write(Data[i]);
      exit();
    end;

    if index > size - k then
      exit();

    for i := start to k + index do
      if not found or (Data[i] > nmax) then
      begin
        found := True;
        nmax := Data[i];
        imax := i;
      end;

    Write(nmax);
    optimal_search(Data, size, k, imax + 1, index + 1);
  end;

begin
  Data := GetMem(1000000 * sizeof(char));

  i := 1;
  Read(Data[i]);
  while Data[i] <> chr(13) do
  begin
    i := i + 1;
    Read(Data[i]);
  end;

  size := i - 1;

  readln(k);

  optimal_search(Data, size, k, 1, 1);
  writeln();
end.
