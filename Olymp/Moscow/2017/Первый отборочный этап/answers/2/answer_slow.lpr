program answer_slow;

const
  MaxT = 100000;
  MaxN = 100000;

var
  n, m, k, i: longint;
  data: array[1..MaxT] of longint;

  function full_search(): longint;
  var
    w: array[1..MaxN] of longint;
    i, j, temp: longint;
  begin
    for i := 1 to n do
      w[i] := i;

    for i := 1 to k do
    begin
      temp := w[data[i] mod n + 1];
      for j := data[i] mod n downto 1 do
        w[j + 1] := w[j];
      w[1] := temp;
    end;

    for i := 1 to n do
      if w[i] = m then
        exit(i);
  end;

begin
  readln(n);
  readln(m);
  readln(k);
  for i := 1 to k do
    readln(data[i]);
  writeln(full_search());
end.

