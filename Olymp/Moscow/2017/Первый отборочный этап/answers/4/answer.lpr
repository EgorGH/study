program answer;

uses
  Math;

const
  Lim = 100000;

var
  i: longint;
  k, n: longint;
  Data: array[0..Lim] of qword;

  function optimal_search(): qword;
  var
    i: longint;
    time: qword = 0;
  begin
    for i := n downto 1 do
    begin
      time += 2 * i * (Data[i] div k);
      Data[i - 1] += Data[i] mod k;
      time += IfThen(Data[i] mod k > 0, 2, 0);
    end;
    exit(time);
  end;

begin
  readln(k);
  readln(n);
  for i := 1 to n do
    readln(Data[i]);

  writeln(optimal_search());
end.
