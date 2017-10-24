program test;

const
  MaxT = 30;
  Max = 15;
  Lim = 10000;
var
  i, N: integer;

type
  TRes = record
    a: qword;
    b: qword;
  end;

  procedure init();
  begin
    N := random(Max) + 1;
  end;

  function f(n: integer): TRes;
  var
    a, b, temp: qword;
    i, j: integer;
    q: integer = 0;
  begin
    for i := 1 to Lim do
      for j := 1 to Lim do
      begin
        a := i;
        b := j;
        q := 0;

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

        if q = N then
        begin
          f.a := i;
          f.b := j;
          exit(f);
        end;
      end;
  end;

  function g(n: integer): TRes;
  var
    a, b, c: qword;
    i: integer;
  begin
    a := 1;
    b := 1;
    for i := 3 to N + 2 do
    begin
      c := b;
      b := a + b;
      a := c;
    end;
    g.a := a;
    g.b := b;
    exit(g);
  end;

  function check(x: TRes): boolean;
  var
    temp: qword;
    q: integer = 0;
  begin
    if x.a < x.b then
    begin
      temp := x.a;
      x.a := x.b;
      x.b := temp;
    end;

    while x.b > 0 do
    begin
      temp := x.a mod x.b;
      x.a := x.b;
      x.b := temp;
      q := q + 1;
    end;

    if q = N then
      exit(True)
    else
      exit(False);
  end;

begin
  randomize();
  for i := 1 to MaxT do
  begin
    init();
    if not check(f(N)) or not check(g(N)) then
      writeln('Error!');
  end;
  writeln('All tests passed');
end.
