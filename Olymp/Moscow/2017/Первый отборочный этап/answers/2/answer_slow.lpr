program answer_slow;

const
  MaxT = 100000;
  MaxN = 100000;

var
  n, m, k, i: longint;
  t: array[1..MaxT] of longint;

  function full_search(): longint;
  var
    mas: array[1..MaxN] of longint;
    i, j, temp: longint;
  begin
    for i := 1 to n do
      mas[i] := i;

    for i := 1 to k do
    begin
      temp := mas[t[i] mod n + 1];
      for j := t[i] mod n downto 1 do
        mas[j + 1] := mas[j];
      mas[1] := temp;
    end;

    for i := 1 to n do
      if mas[i] = m then
        exit(i);
  end;

begin
  readln(n);
  readln(m);
  readln(k);
  for i := 1 to k do
    readln(t[i]);
  writeln(full_search());
end.

