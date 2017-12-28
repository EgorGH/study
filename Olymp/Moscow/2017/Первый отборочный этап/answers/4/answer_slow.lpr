program answer_slow;

const
  Lim = 100000;

var
  i, k, n: longint;
  Data: array[1..Lim] of longint;

  function full_search(): qword;
  var
    i, j: longint;
    free_space: qword;
  begin
    full_search := 0;

    i := n;
    while i >= 1 do
    begin
      if data[i] = 0 then
      begin
        i -= 1;
        continue;
      end;

      free_space := k;
      full_search += i * 2;

      if Data[i] > free_space then
        Data[i] -= free_space
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

        i -= 1;
      end;
    end;
  end;

begin
  readln(k);
  readln(n);
  for i := 1 to n do
    readln(Data[i]);

  writeln(full_search());
end.
