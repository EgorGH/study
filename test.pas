program test;

const
  Lim = 1000;
  MaxR = 99999;
  MaxT = 100000;

type
  Tset = record
    k: integer;
    min: double;
  end;

var
  a: array[1..Lim] of double;
  N, t, i: integer;


  procedure init();
  var
    i: integer;
  begin
    N := 3 + random(23);
    for i := 1 to N do
      a[i] := random(MaxR + 1) / 10;
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

  //function solveA(): longint;
  //var
  //begin

  //end;

  function solveB(): Tset;
  var
    sett: Tset;
    i: integer;
    f: boolean;

  begin
    sett.k := 0;

    for i := 1 to N do
    begin
      if a[i] > 1 then
      begin
        sett.k := sett.k + 1;
        if (a[i] < sett.min) or not f then
        begin
          sett.min := a[i];
          f := True;
        end;
      end;

    end;

    exit(sett);
  end;

begin
  //randomize;
  //for t := 1 to MaxT do
  //begin
  //  init();
  //  if solveA() <> solveB() then
  //  begin
  //    print();
  //    writeln(solveA());
  //    writeln(solveB());
  //  end;
  //end;
  //writeln('Done');

  readln(N);
  for t := 1 to N do
    Read(a[t]);

  writeln(solveB().k, ' ', solveB().min);

  writeln('Done!');

  readln();
end.
