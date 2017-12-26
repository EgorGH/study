program answer;

uses
  strutils;

const
  Lim = 10000;

var
  goods: array[1..Lim] of shortstring;
  relations: array[1..Lim, 1..Lim] of longint;
  always, often: array[1..Lim] of shortstring;
  i, j, k, d, n, qA, qO, size: longint;
  str: ansistring;

  procedure print_recommendations();
  var
    i: longint;
  begin
    for i := 1 to qA do
      Write(always[i], ' ');
    writeln();
    //for i := 1 to qoften do
    //  Write(often[i], ' ');
  end;

  procedure process_purchase(str: ansistring);
  var
    g: shortstring;
    i, j, position: longint;
  begin
    for i := 1 to WordCount(str, [' ']) do
    begin
      position := 0;
      size += 1;
      g := ExtractWord(i, str, [' ']);

      for j := 1 to size - 1 do
        if goods[j] = g then
        begin
          position := j;
          size -= 1;
          break;
        end;

      if position = 0 then
      begin
        goods[size] := g;
        position := size;
      end;

      relations[k, position] := 1;
    end;
  end;

  procedure make_always_recommendations();
  var
    i, j, k: longint;
    fA: boolean;
  begin
    for i := 1 to size do
      if relations[n + 1, i] = 1 then
        for j := 1 to size do
          if j <> i then
          begin
            fA := True;
            for k := 1 to n do
              if (relations[k, i] = 1) and (relations[k, j] = 0) then
                fA := False;
            if fA then
            begin
              qA += 1;
              always[qA] := goods[j];
            end;
          end;
  end;

begin
  readln(n);

  size := 0;
  for k := 1 to n + 1 do
  begin
    readln(str);
    process_purchase(str);
  end;

  qA := 0;
  make_always_recommendations();

  print_recommendations();
  readln();
end.
