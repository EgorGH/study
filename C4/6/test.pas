program test;

const
  Lim = 10000;
  MaxR = 1000;
  MaxT = 10000;

type
  TMin = record
    minA: longint;
    minB: longint;
    minC: longint;
    minD: longint;
    iA: integer;
    iB: integer;
    iC: integer;
    iD: integer;
    fA: boolean;
    fB: boolean;
    fC: boolean;
    fD: boolean;
  end;

var
  a: array[1..Lim] of integer;
  N, t: integer;

  function update_min(a: TMin; b: longint): TMin;
  begin
    if not a.fA or (b <= a.minA) then
    begin
      a.fB := a.fA;
      a.minB := a.minA;
      a.fA := True;
      a.minA := b;
    end
    else if not a.fB or (b <= a.minB) then
    begin
      a.fB := True;
      a.minB := B;
    end;
    exit(a);
  end;

  procedure init();
  var
    i: integer;
  begin
    randomize;
    N := 5 + random(10);
    for i := 1 to N do
      a[i] := random(MaxR + 1);
  end;

  procedure print();
  var
    i: integer;
  begin
    writeln(N);
    for i := 1 to N do
      Write(a[i], ' ');
    writeln();
  end;

  function get_4min(): TMin;
  var
    i: integer;
  begin
    get_4min.fA := False;
    get_4min.fB := False;
    get_4min.fC := False;
    get_4min.fD := False;

    for i := 1 to N do
    begin
      if (a[i] < get_4min.minA) or not get_4min.fA then
      begin
        if get_4min.fA then
        begin
          get_4min.minD := get_4min.minC;
          get_4min.minC := get_4min.minB;
          get_4min.minB := get_4min.minA;
        end;
        get_4min.minA := a[i];
        get_4min.iA := i;
        get_4min.fA := True;
      end
      else if (a[i] < get_4min.minB) or not get_4min.fB  then
      begin
        if get_4min.fB then
        begin
          get_4min.minD := get_4min.minC;
          get_4min.minC := get_4min.minB;
        end;
        get_4min.minB := a[i];
        get_4min.iB := i;
        get_4min.fB := True;
      end
      else if (a[i] < get_4min.minC) or not get_4min.fC  then
      begin
        if get_4min.fC then
          get_4min.minD := get_4min.minC;
        get_4min.minC := a[i];
        get_4min.iC := i;
        get_4min.fC := True;
      end
      else if (a[i] < get_4min.minD) or not get_4min.fD  then
      begin
        get_4min.minD := a[i];
        get_4min.iD := i;
        get_4min.fD := True;
      end;
    end;
  end;

  function solveA(): integer;
  var
    i, j: integer;
    res: TMin;
  begin
    for i := 1 to N - 4 do
      for j := i + 4 to N do
        res := update_min(res, a[i] + a[j]);

    exit(res.minA);
  end;

  function solveB(): longint;

  begin
    if abs(get_4min.iA - get_4min.iB) > 3 then
      exit(get_4min.minA + get_4min.minB)
    else if abs(get_4min.iA - get_4min.iC) > 3 then
      exit(get_4min.minA + get_4min.minC)
    else if abs(get_4min.iA - get_4min.iD) > 3 then
      exit(get_4min.minA + get_4min.minD)


  end;

begin
  for t := 1 to MaxT do
  begin
    init();
    if solveA() <> solveB() then
    begin
      print();
      writeln(solveA());
      writeln(solveB());
    end;
  end;

  writeln('Done');
  readln();
end.
