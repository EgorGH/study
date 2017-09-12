program answer;

uses
  Math;

var
  a, b, N, i, sum, maxE, minE, diff, diff_min: longint;
  found: boolean;

begin
  sum := 0;
  found := False;

  readln(N);

  for i := 1 to N do
  begin
    Read(a);
    readln(b);

    maxE := max(a, b);
    minE := min(a, b);

    sum := sum + maxE;

    diff := maxE - minE;

    if (diff mod 3 <> 0) and (not found or (diff < diff_min)) then
    begin
      found := True;
      diff_min := diff;
    end;
  end;

  if found and (sum mod 3 = 0) then
    sum := sum - diff_min;

  if not found and (sum mod 3 = 0) then
    sum := 0;

  writeln(sum);
  readln();
end.
