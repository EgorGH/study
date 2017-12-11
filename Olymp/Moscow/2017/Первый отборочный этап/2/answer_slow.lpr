program answer_slow;

const
  Lim = 100000;

var
  n, m, k: longint;
  i, j, temp, t: longint;
  mas: array[1..Lim] of longint;

begin
  readln(n);

  for i := 1 to n do
    mas[i] := i;

  readln(m);

  readln(k);
  for i := 1 to k do
  begin
    readln(t);
    temp := mas[(t + 1) mod n];
    for j := t mod n downto 1 do
      mas[j + 1] := mas[j];
    mas[1] := temp;
  end;

  for i := 1 to n do
    if mas[i] = m then
    begin
      writeln(i);
      break;
    end;
end.

