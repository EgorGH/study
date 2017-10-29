program test;

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
    optimal_search.a := a;
    optimal_search.b := b;
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
