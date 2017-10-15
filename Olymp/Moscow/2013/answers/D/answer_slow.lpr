program answer_slow;

const
  Lim = 10000;
var
  m: array of longword;
  a, b, i, k: longword;
  N: longword = 0;

  function get_sum(x, y: longword): longword;
  var
    sum: longword = 0;
  begin
    while x > 0 do
    begin
      sum := sum + (x mod y);
      x := x div y;
    end;
    exit(sum);
  end;

begin
  while not EOF(input) do
  begin
    readln(input, a, b);
    N := N + 1;
    SetLength(m, N + 1);
    for k := 10 to Lim do
    begin
      if get_sum(k, a) = get_sum(k, b) then
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
