program test;

const
  Lim = 1000;
  MaxR = 999999;
  MaxT = 10000;

type
  TRes = record
    q: integer;
    min: double;
    prod: double;
  end;

var
  a: array[1..Lim] of double;
  N, t: integer;

  procedure init();
  var
    i: integer;
  begin
    N := 3 + random(13);
    for i := 1 to N do
      a[i] := random(MaxR + 1) / 10;
  end;

  procedure print();
  var
    i: integer;
  begin
    writeln(N);
    for i := 1 to N do
      Write(a[i]: 0: 1, ' ');
    writeln();
  end;

  function get_option(v: longword): TRes;
  var
    j, q: longword;
    prod, min: double;
    fMin: boolean;
  begin
    fMin := False;
    min := 1000001;
    q := 0;
    prod := 1;

    for j := 1 to N do
    begin
      if v mod 2 <> 0 then
      begin
        q := q + 1;
        prod := prod * a[j];
        if not fMin or (a[j] < min) then
        begin
          fMin := True;
          min := a[j];
        end;
      end;

      v := v div 2;

      get_option.q := q;
      get_option.prod := prod;
      get_option.min := min;
    end;
  end;

  function solveA(): TRes;
  var
    i: longword;
    res: TRes;
    fProd: boolean;

  begin
    fProd := False;

    for i := 1 to (1 shl N) - 1 do
    begin
      get_option(i);
      if not fProd or (get_option(i).prod > res.prod) then
      begin
        fProd := True;
        res.prod := get_option(i).prod;
        res.q := get_option(i).q;
        res.min := get_option(i).min;
      end;
    end;

    exit(res);
  end;

  function solveB(): TRes;
  var
    i, q: longint;
    found, fMin, fMax: boolean;
    res: TRes;
    min, max: double;

  begin
    q := 0;
    fMin := False;
    fMax := False;
    found := False;

    for i := 1 to N do
    begin
      if a[i] > 1 then
      begin
        found := True;
        q := q + 1;
        if not fMin or (a[i] < min) then
        begin
          fMin := True;
          min := a[i];
        end;
      end
      else
      if not fMax or (a[i] > max) then
      begin
        fMax := True;
        max := a[i];
      end;
    end;

    if found then
    begin
      res.q := q;
      res.min := min;
    end
    else
    begin
      res.q := 1;
      res.min := max;
    end;

    exit(res);
  end;

begin
  randomize;
  for t := 1 to maxT do
  begin
    init();
    if (solveA().min <> solveB().min) and (solveA().q <> solveB().q) then
      print();
  end;
  writeln('Done');

  readln();
end.
