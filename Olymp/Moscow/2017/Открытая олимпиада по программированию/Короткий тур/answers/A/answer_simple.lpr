program answer_simple;

const
  Lim = 1000000;

var
  n, m, t, k, i, j, a, b: longint;
  serA, serB: array of byte;
  ta, tb: longint;

  procedure full_search();
  var
    i: longint;
    chan: byte = 0;
    flag: boolean;
  begin
    for i := 0 to t - 1 do
    begin
      if (chan = 0) and (serA[i] = 0) then
      begin
        flag := False;
        ta += 1;
      end
      else
      if (chan = 0) and (serA[i] = 1) and not flag then
      begin
        chan := 1;
        if serB[i] = 0 then
          tb += 1
        else
          flag := True;
      end

      else
      if (chan = 1) and (serB[i] = 0) then
      begin
        flag := False;
        tb += 1;
      end
      else
      if (chan = 1) and (serB[i] = 1) and not flag then
      begin
        chan := 0;
        if serA[i] = 0 then
          ta += 1
        else
          flag := True;
      end;
    end;
  end;

begin
  readln(n, m, t, k);

  setlength(serA, t);
  setlength(serB, t);

  for i := 0 to n - 1 do
  begin
    Read(a);
    for j := a to a + k - 1 do
      if j < t then
        serA[j] := 1;
  end;
  readln();

  for i := 0 to m - 1 do
  begin
    Read(b);
    for j := b to b + k - 1 do
      if j < t then
        serB[j] := 1;
  end;
  readln();

  full_search();
  writeln(ta, ' ', tb);
  //readln();
end.

