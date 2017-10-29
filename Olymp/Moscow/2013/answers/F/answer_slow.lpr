program answer_slow;

type
  TRes = record
    a: longint;
    b: longint;
  end;

var
  N: longint;
  r: TRes;

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

begin
  readln(N);
  r := full_search(N);
  writeln(r.a, ' ', r.b);
end.
