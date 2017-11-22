program answer_slow;

const
  Lim = 100;

var
  m, n, k, i, y, x, step: longint;
  labyrinth: array[0..Lim, 0..Lim] of byte;

  procedure make_borders();
  var
    i: longint;
  begin
    for i := 0 to m + 1 do
    begin
      labyrinth[i, 0] := 1;
      labyrinth[i, n + 1] := 1;
    end;

    for i := 0 to n + 1 do
    begin
      labyrinth[0, i] := 1;
      labyrinth[m + 1, i] := 1;
    end;
  end;

  function check_passability(): boolean;
  var
    a, b: longint;
  begin
    a := 1;
    b := 1;

    repeat
      if labyrinth[a, b + 1] <> 1 then
        b := b + 1
      else if labyrinth[a + 1, b] <> 1 then
        a := a + 1
      else
      begin
        repeat
          if labyrinth[a, b - 1] <> 1 then
            b := b - 1
          else if labyrinth[a - 1, b] <> 1 then
            a := a - 1;
        until (labyrinth[a, b + 1] <> 1) and (labyrinth[a + 1, b] <> 1) or
          (a = m) and (b = n) or (a = 1) and (b = 1);

        if (a <> m) and (b <> n) and (a <> 1) and (b <> 1) or (a = m) and
          (b <> n) or (a <> m) and (b = n) or (a = 1) and (b <> 1) or
          (a <> 1) and (b = 1) then
          a := a + 1;
      end;
    until (a = m) and (b = n) or (a = 1) and (b = 1);

    if (a = m) and (b = n) then
      exit(True)
    else
      exit(False);
  end;

begin
  step := 0;

  readln(m, n, k);

  make_borders();

  for i := 1 to k do
  begin
    readln(y, x);
    labyrinth[y, x] := 1;
    if (step = 0) and not check_passability() then
      step := i;
  end;

  writeln(step);
  readln();
end.
