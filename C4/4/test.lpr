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

  function eval(v: longword): TRes;
  var
    i, q: longword;
    prod, min: double;
    fMin: boolean;
  begin
    fMin := False;
    q := 0;
    prod := 1;

    for i := 1 to N do
    begin
      if v mod 2 <> 0 then
      begin
        q := q + 1;
        prod := prod * a[i];
        if not fMin or (a[i] < min) then
        begin
          fMin := True;
          min := a[i];
        end;
      end;

      v := v div 2;

      eval.q := q;
      eval.prod := prod;
      eval.min := min;
    end;
  end;

  function solveA(): TRes;
  var
    v: longword;
    res, temp: TRes;
    fProd: boolean;

  begin
    fProd := False;

    for v := 1 to (1 shl N) - 1 do
    begin
      temp := eval(v);
      if not fProd or (temp.prod > res.prod) then
      begin
        fProd := True;
        res := temp;
      end;
    end;

    exit(res);
  end;

  function solveB(): TRes;
  var
    i, q: longint;
    fMin, fMax: boolean;
    res: TRes;
    min, max: double;

  begin
    q := 0;
    fMin := False;
    fMax := False;

    for i := 1 to N do
    begin
      if a[i] > 1 then
      begin
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

    if fMin then
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
