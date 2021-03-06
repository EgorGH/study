program answer;

const
  MaxT = 100000;

var
  n, m, k, i: longint;
  data: array[1..MaxT] of longint;

  function optimal_search(): longint;
  var
    i, idx, pos: longint;
  begin
    pos := m;
    for i := 1 to k do
    begin
      idx := data[i] mod n + 1;
      if idx > pos then
        pos += 1
      else if idx = pos then
        pos := 1;
    end;
    exit(pos);
  end;

begin
  readln(n);
  readln(m);
  readln(k);
  for i := 1 to k do
    readln(data[i]);
  writeln(optimal_search());
end.

