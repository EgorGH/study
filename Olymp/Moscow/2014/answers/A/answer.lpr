program answer;

const
  Lim = 10000;

var
  goods: array[1..Lim] of shortstring;
  temp: array[1..Lim] of longint;
  relations: array[1..Lim, 1..Lim] of longint;
  quantity: array[1..Lim] of longint;
  always, often: array[1..Lim] of shortstring;
  i, d, n, q, qalways, qoften, size: longint;
  str: ansistring;

  procedure print_recommendations();
  var
    i: longint;
  begin
    for i := 1 to qalways do
      Write(always[i], ' ');
    writeln();
    for i := 1 to qoften do
      Write(often[i], ' ');
  end;

  procedure process_old_purchase(var str: ansistring);
  var
    found: boolean;
    g: shortstring;
    i, j, len: longint;
  begin
    while str <> '' do
    begin
      found := False;
      d := d + 1;

      if pos(' ', str) <> 0 then
        len := pos(' ', str)
      else
        len := length(str) + 1;

      g := copy(str, 1, len - 1);

      for i := 1 to q do
        if goods[i] = g then
        begin
          quantity[i] += 1;
          temp[d] := i;
          found := True;
        end;

      if not found then
      begin
        q := q + 1;
        goods[q] := g;
        quantity[q] += 1;
        temp[d] := q;
      end;

      if pos(' ', str) <> 0 then
        Delete(str, 1, pos(' ', str))
      else
        str := '';
    end;

    for i := 1 to d - 1 do
      for j := i + 1 to d do
      begin
        relations[temp[i], temp[j]] += 1;
        relations[temp[j], temp[i]] += 1;
      end;
  end;

  procedure process_purchase(var str: ansistring);
  var
    g: shortstring;
    i, j, len: longint;
  begin
    while str <> '' do
    begin
      d := d + 1;

      if pos(' ', str) <> 0 then
        len := pos(' ', str)
      else
        len := length(str) + 1;

      g := copy(str, 1, len - 1);

      for i := 1 to q do
        if goods[i] = g then
        begin
          temp[d] := i;
          break;
        end;

      if pos(' ', str) <> 0 then
        Delete(str, 1, pos(' ', str))
      else
        str := '';
    end;

    for i := 1 to d do
      for j := 1 to size do
        relations[j, temp[i]] := 0;
  end;

  procedure make_often_recommendations();
  var
    i, j, k, num: longint;
  begin
    for i := 1 to d do
      for j := 1 to size do
        if relations[temp[i], j] * 2 >= quantity[temp[i]] then
        begin
          qoften += 1;
          often[qoften] := goods[j];
          for k := 1 to size do
            relations[k, j] := 0;
        end;

    for i := 1 to qalways do
    begin
      for j := 1 to size do
        if goods[j] = always[i] then
        begin
          num := j;
          break;
        end;

      for j := 1 to size do
        if relations[num, j] * 2 >= quantity[num] then
        begin
          qoften += 1;
          often[qoften] := goods[j];
        end;
    end;
  end;

  procedure make_always_recommendations();
  var
    i, j, k: longint;
  begin
    for i := 1 to d do
      for j := 1 to size do
        if relations[temp[i], j] = quantity[temp[i]] then
        begin
          qalways += 1;
          always[qalways] := goods[j];
          for k := 1 to size do
            relations[k, j] := 0;
        end;
  end;

begin
  readln(n);

  q := 0;
  for i := 1 to n do
  begin
    readln(str);
    d := 0;
    process_old_purchase(str);
  end;

  size := q;

  readln(str);

  d := 0;
  process_purchase(str);

  qalways := 0;
  make_always_recommendations();

  qoften := 0;
  make_often_recommendations();

  print_recommendations();
end.
