program answer_slow;

const
  Lim = 10000;
var
  m: array of longint;
  N, a, b, i, k, s1, s2: longint;
  s: longint = 0;

  procedure get_sum(x, y: longint);
  begin
    while (x div y) > 0 do
    begin
      get_sum(x div y, y);
      x := x mod y;
    end;
    s := s + x;
  end;

begin
  readln(N);

  SetLength(m, N);

  for i := 0 to N - 1 do
  begin
    readln(a, b);
    for k := 10 to Lim do
    begin
      get_sum(k, a);
      s1 := s;
      s := 0;
      get_sum(k, b);
      s2 := s;
      s := 0;
      if s1 = s2 then
      begin
        m[i] := k;
        break;
      end;
    end;
  end;

  for i := 0 to N - 1 do
    writeln(m[i]);

  readln();
end.
