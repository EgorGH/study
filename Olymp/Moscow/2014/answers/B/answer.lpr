program answer;

var
  i: longint;

  function eq(x1, x2: longint): longint;
  begin
    if x1 = x2 then
      exit(1)
    else
      exit(0);
  end;

  function imp(x1, x2: longint): longint;
  begin
    if (x1 = 1) and (x2 = 0) then
      exit(0)
    else
      exit(1);
  end;

  function N(x1, x2, x3: longint): longint;
  begin
    exit(imp(x1, eq(x2, x3)));
  end;

  function B(x1, x2, x3: longint): longint;
  begin
    exit((((x1 or x2) or x3) and (N(x1, x2, x3))) and
      ((N(x2, x1, x3)) and (N(x3, x1, x2))));
  end;

  function P(x1, x2, x3: longint): longint;
  begin
    exit(((x1 and x2) or (x1 and x3)) or (x2 and x3));
  end;

  procedure F();
  var
    i, x, z1, z2, z3: longint;
  begin
    Read(x);
    Write(x, ' ');
    z1 := x;
    z2 := 0;
    z3 := x;
    for i := 2 to 32 do
    begin
      Read(x);
      Write(B(z1, x, z2), ' ');
      z1 := x;
      z2 := P(z3, x, z2);
      z3 := x;
    end;
    readln();
    writeln();
  end;

begin
  for i := 1 to 7 do
    F();
end.
