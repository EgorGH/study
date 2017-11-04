program answer;

uses
  SysUtils;

type
  TRes = record
    a: shortstring;
    b: shortstring;
  end;

var
  N: longint;
  r: TRes;

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

  function optimal_search(N: longint): TRes;
  var
    a, b, c: shortstring;
    i: longint;
  begin
    a := '1';
    b := '1';
    for i := 3 to N + 2 do
    begin
      c := b;
      b := add(a, b);
      a := c;
    end;
    optimal_search.a := a;
    optimal_search.b := b;
    exit(optimal_search);
  end;

begin
  readln(N);
  r := optimal_search(N);
  writeln(r.a, ' ', r.b);
end.
