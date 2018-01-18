program answer;

const
  Lim = 100000;

var
  n, k, i: longint;
  data: array[1..Lim] of int64;

  procedure optimal_search();
  var
    i: longint;
  begin
    for i := 2 to n do
      if Data[i] - Data[i - 1] < k then
        Data[i] := Data[i - 1] + k;
  end;

begin
  readln(n, k);
  for i := 1 to n do
    Read(data[i]);

  optimal_search();

  for i := 1 to n do
    Write(data[i], ' ');
end.

