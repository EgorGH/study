program answer_slow;

const
  Lim = 10000;
var
  a, b, k: longword;

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
    for k := 10 to Lim do
    begin
      if get_sum(k, a) = get_sum(k, b) then
      begin
        writeln(k);
        break;
      end;
    end;
  end;
end.
