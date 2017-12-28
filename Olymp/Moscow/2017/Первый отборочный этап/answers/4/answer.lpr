program answer;

const
  Lim = 100000;

var
  i: longint;
  k, n: longint;
  Data: array[1..Lim] of longint;

  function optimal_search(): qword;
  var
    i: longint;
    free_space, x: qword;
  begin
    free_space := 0;
    optimal_search := 0;

    for i := n downto 1 do
    begin
      if data[i] > free_space then
      begin
        data[i] -= free_space;
        if data[i] mod k <> 0 then
          x := data[i] div k + 1
        else
          x := data[i] div k;
        optimal_search += 2 * i * x;
        free_space := x * k - data[i];
      end
      else
        free_space -= data[i];
    end;
  end;

begin
  readln(k);
  readln(n);
  for i := 1 to n do
    readln(Data[i]);

  writeln(optimal_search());
end.
