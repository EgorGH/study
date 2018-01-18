program answer_simple;

const
  Lim = 100000000;

var
  data: array[1..Lim] of longint;
  n: longint;

  function full_search(): longint;
  var
    i, j, group: longint;
  begin
    group := 0;
    i := 0;
    while i <= n do
    begin
      group += 1;
      for j := 1 to group do
      begin
        i += 1;
        data[i] := j;
      end;
      for j := group - 1 downto 1 do
      begin
        i += 1;
        data[i] := j;
      end;
    end;
    exit(data[n]);
  end;

begin
  readln(n);
  writeln(full_search());
end.

