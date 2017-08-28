program answer1;

const
  M = 4;
  K = 2 * M;
var
  N, a, i, j, r, min: integer;
  mins: array[1..K, 1..2] of integer;
  found: boolean;
begin
  found := False;

  readln(N);

  for i := 1 to K do
    mins[i, 1] := 10001;

  for i := 1 to N do
  begin
    readln(a);
    for j := 1 to K do
      if a <= mins[j, 1] then
      begin
        for r := K downto (j + 1) do
          mins[r] := mins[r - 1];
        mins[j, 1] := a;
        mins[j, 2] := i;
        break;
      end;
  end;

  for i := 1 to K - 1 do
    for j := i + 1 to K do
      if (abs(mins[i, 2] - mins[j, 2]) > M - 1) and
        ((mins[i, 1] + mins[j, 1] < min) or not found) then
      begin
        found := True;
        min := mins[i, 1] + mins[j, 1];
      end;

  writeln(min);
  readln();
end.
