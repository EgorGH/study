program answer_slow;

const
  Lim = 100000;

var
  i, k, n: longint;
  Data: array[1..Lim] of longint;

  function full_search(): longint;
  var
    i, j, free_space: longint;
    ans: longint;
  begin
    ans := 0;
    i := n;
    while i >= 1 do
    begin
      if Data[i] = 0 then
      begin
        i -= 1;
        continue;
      end;

      free_space := k;
      if Data[i] > free_space then
      begin
        Data[i] -= free_space;
        ans += i * 2;
      end
      else
      begin
        for j := i downto 1 do
          if Data[j] <= free_space then
          begin
            free_space -= Data[j];
            Data[j] := 0;
          end
          else
          begin
            Data[j] -= free_space;
            break;
          end;

        ans += i * 2;
        i -= 1;
      end;
    end;
    exit(ans);
  end;

begin
  readln(k);
  readln(n);
  for i := 1 to n do
    readln(Data[i]);

  writeln(full_search());
end.
