program answer;

const
  Lim = 10000;
var
  i, j, a, b, q, N, c, temp: longword;
begin
  readln(N);

  for i := 1 to Lim do
    for j := 1 to Lim do
    begin
      a := i;
      b := j;
      q := 0;

      if a < b then
      begin
        temp := a;
        a := b;
        b := temp;
      end;

      while b > 0 do
      begin
        c := a mod b;
        a := b;
        b := c;
        q := q + 1;
      end;

      if q = N then
      begin
        Write(i, ' ', j);
        readln();
      end;
    end;

  readln();
end.
