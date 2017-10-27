program answer;

uses
  SysUtils;

var
  a, b, c: shortstring;
  i, N: integer;

  function sum_of_str(s1, s2: shortstring): shortstring;
  var
    i, d1, d2, rem, dsum: integer;
    sum: shortstring;
  begin
    while length(s1) <> length(s2) do
    begin
      if length(s1) > length(s2) then
        s2 := '0' + s2
      else
        s1 := '0' + s1;
    end;

    sum := '';
    rem := 0;

    for i := length(s1) downto 1 do
    begin
      d1 := StrToInt(s1[i]);
      d2 := StrToInt(s2[i]);

      dsum := d1 + d2 + rem;

      rem := dsum div 10;
      dsum := dsum mod 10;

      sum := IntToStr(dsum) + sum;
    end;

    if rem > 0 then
      sum := IntToStr(rem) + sum;

    exit(sum);
  end;

begin
  readln(N);
  a := '1';
  b := '1';
  for i := 3 to N + 2 do
  begin
    c := b;
    b := sum_of_str(a, b);
    a := c;
  end;
  writeln(a, ' ', b);
end.
