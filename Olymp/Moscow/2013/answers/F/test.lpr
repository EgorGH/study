program test;

uses
  SysUtils;

const
  MaxT = 100;
  MaxN = 15;

type
  TRes = record
    a: longint;
    b: longint;
  end;

var
  t, N: longint;
  r1, r2: TRes;

  function euclid(a, b: longint): longint;
  var
    temp: longint;
    q: longint = 0;
  begin
    if a < b then
    begin
      temp := a;
      a := b;
      b := temp;
    end;

    while b > 0 do
    begin
      temp := a mod b;
      a := b;
      b := temp;
      q := q + 1;
    end;

    exit(q);
  end;

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

  function full_search(N: longint): TRes;
  var
    d, i: longint;
    found: boolean = False;
  begin
    d := 2;
    while not found do
    begin
      for i := 1 to d - 1 do
        if euclid(i, d - i) = N then
        begin
          full_search.a := i;
          full_search.b := d - i;
          exit(full_search);
        end;
      d := d + 1;
    end;
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
    optimal_search.a := StrToInt(a);
    optimal_search.b := StrToInt(b);
    exit(optimal_search);
  end;

begin
  randomize();
  for t := 1 to MaxT do
  begin
    N := random(MaxN) + 1;
    r1 := full_search(N);
    r2 := optimal_search(N);
    if (euclid(r1.a, r1.b) <> N) or (euclid(r2.a, r2.b) <> N) then
      writeln('Error!');
  end;
  writeln('Done');
end.
