program answer;

const
  MaxT = 100000;

var
  n, m, k, i: longint;
  t: array[1..MaxT] of longint;

  function optimal_search(): longint;
  var
    i, len, pos: longint;
  begin
    pos := m;
    for i := 1 to k do
    begin
      len := t[i] mod n;
      if len + 1 > pos then
        pos += 1
      else if len + 1 = pos then
        pos := 1;
    end;
    exit(pos);
  end;

begin
  readln(n);
  readln(m);
  readln(k);
  for i := 1 to k do
    readln(t[i]);
  writeln(optimal_search());
end.

