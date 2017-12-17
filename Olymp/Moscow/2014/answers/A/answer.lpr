program answer;

const
  Lim = 7;

var
  goods: array[1..Lim] of shortstring;
  temp: array[1..10] of smallint;
  relations: array[1..Lim, 1..Lim] of longint;
  quantity: array[1..Lim] of longint;
  i, j, k, d, n, q, len: longint;
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
        write(relations[i, j], ' ');
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
      found := false;
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

  print_goods();
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
