program answer_slow;

uses
  Math;

const
  Lim = 100000;

var
  i, k, n: longint;
  Data: array[0..Lim] of qword;

  function full_search(): qword;
  var
    i, p: longint;
    time: qword = 0;
  begin
    for i := n downto 1 do
      while Data[i] > 0 do
      begin
        p := min(Data[i], k);
        Data[i] -= p;
        Data[i - 1] += p;
        time += 2;
      end;
    exit(time);
  end;

begin
  readln(k);
  readln(n);
  for i := 1 to n do
    readln(Data[i]);

  writeln(full_search());
end.
