program answer;

uses
  strutils;

const
  Lim = 10000;

type
  tdata = ^longint;

var
  goods: array[1..Lim] of shortstring;
  relations: array[1..Lim, 1..Lim] of longint;
  always, often: tdata;
  k, n, qA, qO, size: longint;
  str: ansistring;

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

  procedure make_recommendations();
  var
    i, j, k, qi, qj: longint;
  begin
    for i := 1 to size do
      if relations[n + 1, i] = 1 then
        for j := 1 to size do
          if j <> i then
          begin
            qi := 0;
            qj := 0;

            for k := 1 to n do
              if (relations[k, i] = 1) then
              begin
                qi += 1;
                if (relations[k, j] = 1) then
                  qj += 1;
              end;

            if qi = qj then
            begin
              qA += 1;
              always[qA] := j;
            end;

            if qi <= qj * 2 then
            begin
              qO += 1;
              often[qO] := j;
            end;
          end;

    for i := 1 to qA do
      for j := 1 to size do
        if j <> always[i] then
        begin
          qi := 0;
          qj := 0;

          for k := 1 to n do
            if relations[k, always[i]] = 1 then
            begin
              qi += 1;
              if relations[k, j] = 1 then
                qj += 1;
            end;

          if qi <= qj * 2 then
          begin
            qO += 1;
            often[qO] := j;
          end;
        end;
  end;

  function check(x: longint; fAlways: boolean): boolean;
  var
    i: longint;
  begin
    if x = 0 then
      exit(False);

    for i := 1 to size do
      if (relations[n + 1, i] = 1) and (i = x) then
        exit(False);

    if not fAlways then
      for i := 1 to qA do
        if always[i] = x then
          exit(False);

    exit(True);
  end;

  procedure delete_repeated_elements(var data: tdata; x: longint);
  var
    i, j: longint;
  begin
    for i := 1 to x - 1 do
      for j := i + 1 to x do
        if (data[i] = data[j]) and (data[i] <> 0) then
          data[j] := 0;
  end;

  procedure print_recommendations();
  var
    i: longint;
  begin
    delete_repeated_elements(always, qA);
    delete_repeated_elements(often, qO);
    for i := 1 to qA do
      if check(always[i], True) then
        Write(goods[always[i]], ' ');
    writeln();
    for i := 1 to qO do
      if check(often[i], False) then
        Write(goods[often[i]], ' ');
  end;

begin
  readln(n);

  always := GetMem(n * n * sizeof(longint));
  often := GetMem(n * n * sizeof(longint));

  size := 0;
  for k := 1 to n + 1 do
  begin
    readln(str);
    process_purchase(str);
  end;

  qA := 0;
  qO := 0;
  make_recommendations();
  print_recommendations();
end.
