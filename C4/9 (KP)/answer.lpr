program answer;

var
  x, q, maxA, maxB, prod, k: longword;
  fA, fB: boolean;
begin
  q := 0;
  fA := False;
  fB := False;

  readln(x);
  repeat
    if (x mod 7 = 0) and (x mod 49 <> 0) and ((x > maxA) or not fA) then
    begin
      fA := True;
      maxA := x;
    end;
    if (x mod 7 <> 0) and ((x > maxB) or not fB) then
    begin
      fB := True;
      maxB := x;
    end;
    q := q + 1;
    readln(x);
  until x = 0;

  if fA and fB then
    prod := maxA * maxB
  else
    prod := 1;

  readln(k);

  writeln('Введено чисел: ', q);
  writeln('Контрольное значение', k);
  writeln('Вычисленное значение', prod);

  if prod = k then
    writeln('Значения совпали')
  else
    writeln('Значения не совпали');

  readln();
end.

