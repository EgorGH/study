program answer;

const
  Lim = 1000000;

var
  n, m, k, i, j: longint;
  t, a, b: longint;
  serA, serB: longint;
  ta, tb: longint;

  procedure optimal_search();
  var
    i: longint;
    chan: byte = 0;
    flag: boolean;
  begin
    for i := 1 to t do
    begin
      if (chan = 0) and (serA mod 2 = 0) then
      begin
        flag := False;
        ta += 1;
      end
      else
      if (chan = 0) and (serA mod 2 = 1) and not flag then
      begin
        chan := 1;
        if serB mod 2 = 0 then
          tb += 1
        else
          flag := True;
      end

      else
      if (chan = 1) and (serB mod 2 = 0) then
      begin
        flag := False;
        tb += 1;
      end
      else
      if (chan = 1) and (serB mod 2 = 1) and not flag then
      begin
        chan := 0;
        if serA mod 2 = 0 then
          ta += 1
        else
          flag := True;
      end;

      serA := serA div 2;
      serB := serB div 2;
    end;
  end;

begin
  //Assign(input, 'tests\00.');
  //reset(input);

  readln(n, m, t, k);

  serA := 0;
  serB := 0;

  for i := 1 to n do
  begin
    Read(a);
    for j := a to a + k - 1 do
      if j <= t then
        serA := serA or (1 shl j);
  end;
  readln();

  for i := 1 to m do
  begin
    Read(b);
    for j := b to b + k - 1 do
      if j <= t then
        serB := serB or (1 shl j);
  end;
  readln();

  optimal_search();
  writeln(ta, ' ', tb);
  //readln();
end.

