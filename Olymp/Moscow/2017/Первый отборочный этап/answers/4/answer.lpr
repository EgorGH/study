program answer;

const
  Lim = 100000;

var
  i, k, n: longint;
  Data: array[1..Lim] of longint;

  function optimal_search(): int64;
  var
    i, j, free_space: longint;
    ans: int64;
  begin
    ans := 0;
    for i := n downto 1 do
    begin

    end;
    exit(ans);
  end;

begin
  readln(k);
  readln(n);
  for i := 1 to n do
    readln(Data[i]);

  writeln(optimal_search());
  readln();
end.
