program answer2;

const
  M = 4;
var
  N, a, i, min_sum, min_left: integer;
  w: array[0..M - 1] of integer;
  fA, fB: boolean;
begin
  fA := False;
  fB := False;

  readln(N);

  for i := 1 to M do
  begin
    readln(a);
    w[i mod M] := a;
  end;

  for i := M + 1 to N do
  begin
    readln(a);

    if (w[i mod M] < min_left) or not fA then
    begin
      fA := True;
      min_left := w[i mod M];
    end;

    if (min_left + a < min_sum) or not fB then
    begin
      fB := True;
      min_sum := min_left + a;
    end;

    w[i mod M] := a;
  end;

  writeln(min_sum);
  readln();
end.
