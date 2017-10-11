program answer_slow;

const
  Lim = 10000;
var
  m: array of longint;
  a, b, i, k, s1, s2: longint;
  s: longint = 0;
  N: longint = 0;

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
  while not eof(input) do
  begin
    readln(input, a, b);
    N := N + 1;
    SetLength(m, N + 1);
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
        m[N] := k;
        break;
      end;
    end;
  end;

  for i := 1 to N do
    writeln(m[i]);

  readln();
end.
