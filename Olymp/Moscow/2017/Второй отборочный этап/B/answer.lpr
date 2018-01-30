program answer;

var
  i, j, n, k: longint;
  a, b, c, x: int64;

begin
  Assign(input, 'tests\02.');
  reset(input);

  assign(output, 'tests\02.a');
  rewrite(output);

  readln(n);
  writeln(n);
  for i := 1 to n do
  begin
    readln();
    writeln();
    readln(k);
    writeln(k);
    if k >= 3 then
    begin
      Read(a);
      Read(b);
      Read(c);

      if (a = b) or (b = c) then
      begin
        j := 4;
        Read(x);
        while (x = a) and (j < k) do
        begin
          Write(x, ' ');
          Read(x);
          j += 1;
        end;
        write(x, ' ');
        Write(a, ' ');
        Write(b, ' ');
        Write(c, ' ');
        while j < k do
        begin
          j += 1;
          Read(x);
          Write(x, ' ');
        end;
        continue;
      end;

      if ((a > b) and (b > c)) or ((a < b) and (b < c)) then
      begin
        Write(b, ' ');
        Write(a, ' ');
        Write(c, ' ');
      end
      else
      begin
        Write(a, ' ');
        Write(b, ' ');
        Write(c, ' ');
      end;

      for j := 4 to k do
      begin
        Read(x);
        Write(x, ' ');
      end;
    end;

    if k < 3 then
      for j := 1 to k do
      begin
        Read(x);
        Write(x, ' ');
      end;

    writeln();
    readln();
  end;
end.

