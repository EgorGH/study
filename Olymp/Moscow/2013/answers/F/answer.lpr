program answer;

uses
  SysUtils;

var
  a, b, c: shortstring;
  i, N: longint;

  function add(a, b: shortstring): shortstring;
  var
    i, x, y, rem, dsum: longint;
    sum: shortstring;
  begin
    while length(a) <> length(b) do
    begin
      if length(a) > length(b) then
        b := '0' + b
      else
        a := '0' + a;
    end;

    sum := '';
    rem := 0;

    for i := length(a) downto 1 do
    begin
      x := StrToInt(a[i]);
      y := StrToInt(b[i]);

      dsum := x + y + rem;

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
    b := add(a, b);
    a := c;
  end;
  writeln(a, ' ', b);
end.
