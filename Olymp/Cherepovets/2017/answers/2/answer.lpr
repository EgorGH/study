program answer;

uses
  crt;

type
  TNum = ^char;

var
  num: TNum;
  i, k, length: longint;

  procedure optimal_search(start, index: longint);
  var
    i, imax: longint;
    nmax: char;
    found: boolean = False;
  begin
    if index > length - k then
      exit();

    for i := start to k + index - 1 do
    begin
      if not found or (num[i] > nmax) then
      begin
        found := True;
        nmax := num[i];
        imax := i;
      end;
    end;

    Write(nmax);
    optimal_search(imax + 1, index + 1);
  end;

begin
  num := GetMem(1000000 * sizeof(char));

  i := 0;
  Read(num[i]);
  while num[i] <> chr(13) do
  begin
    i := i + 1;
    Read(num[i]);
  end;
  length := i;
  readln(k);

  optimal_search(0, 1);
  writeln();
end.
