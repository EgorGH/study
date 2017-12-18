program answer;

const
  Lim = 10000;

var
  goods: array[1..Lim] of shortstring;
  temp: array[1..Lim] of smallint;
  relations: array[1..Lim, 1..Lim] of longint;
  quantity: array[1..Lim] of longint;
  always, often: array[1..Lim] of shortstring;
  i, j, k, d, n, p, q, len, size: longint;
  str, g: shortstring;
  found: boolean;

  procedure print_goods();
  var
    i: longint;
  begin
    for i := 1 to q do
      writeln(i, ' ', goods[i]);

    for i := 1 to Lim do
    begin
      for j := 1 to Lim do
        Write(relations[i, j], ' ');
      writeln();
    end;

    for i := 1 to Lim do
      writeln(quantity[i]);
  end;

begin
  readln(n);

  q := 0;
  for i := 1 to n do
  begin
    readln(str);
    d := 0;
    while str <> '' do
    begin
      found := False;
      d := d + 1;

      if pos(' ', str) <> 0 then
        len := pos(' ', str)
      else
        len := length(str) + 1;

      g := copy(str, 1, len - 1);

      for j := 1 to q do
        if goods[j] = g then
        begin
          quantity[j] += 1;
          temp[d] := j;
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

    for j := 1 to d - 1 do
      for k := j + 1 to d do
      begin
        relations[temp[j], temp[k]] += 1;
        relations[temp[k], temp[j]] += 1;
      end;
  end;

  size := q;

  readln(str);

  d := 0;
  while str <> '' do
  begin
    d := d + 1;

    if pos(' ', str) <> 0 then
      len := pos(' ', str)
    else
      len := length(str) + 1;

    g := copy(str, 1, len - 1);

    for j := 1 to q do
      if goods[j] = g then
      begin
        temp[d] := j;
        break;
      end;

    if pos(' ', str) <> 0 then
      Delete(str, 1, pos(' ', str))
    else
      str := '';
  end;

  q := 0;
  p := 0;
  for i := 1 to d do
  begin
    for j := 1 to size do
    begin
      if relations[temp[i], j] = quantity[temp[i]] then
      begin
        q := q + 1;
        always[q] := goods[j];
      end
      else
      if relations[temp[i], j] * 2 >= quantity[temp[i]] then
      begin
        p := p + 1;
        often[p] := goods[j];
      end;
    end;
  end;

  writeln();
  for i := 1 to q do
    write(always[i], ' ');
  writeln();
  for i := 1 to p do
    write(often[i], ' ');
  readln();
end.
(*
5
A D
B C E
C F
C E F G
A B C E
*)
