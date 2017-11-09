program answer_slow;

var
  x1, x2, x3, i: longint;

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

begin
  for i := 1 to 8 do
  begin
    readln(x1, x2, x3);
    writeln(B(x1, x2, x3));
  end;
end.

