program generate_test;

var
  i, n, m: longint;

  function power_10(x: longint): int64;
  begin
    power_10 := 1;
    while x > 0 do
    begin
      power_10 *= 10;
      x -= 1;
    end;
  end;

begin
  randomize;

  readln(N, M);
  writeln(N, ' ', M);
  for i := 1 to M do
    Write(random(power_10(N)) + 1, ' ');
end.

