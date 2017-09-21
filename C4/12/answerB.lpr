program answerB;

var
  N, i, a, q26, q2, q13, s1, s2: longword;
begin
  q26 := 0;
  q2 := 0;
  q13 := 0;
  s1 := 0;
  s2 := 0;

  readln(N);

  for i := 1 to N do
  begin
    readln(a);

    if a mod 26 = 0 then
      q26 := q26 + 1;

    if (a mod 13 = 0) and (a mod 2 <> 0) then
      q13 := q13 + 1;

    if (a mod 2 = 0) and (a mod 13 <> 0) then
      q2 := q2 + 1;
  end;

  s1 := round(q26 * (2 * N - q26 - 1) / 2);
  s2 := q2 * q13;

  writeln(s1 + s2);
  readln();
end.
