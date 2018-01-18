program answer_simple;

const
  Lim = 100;

var
  n, m, x: longint;
  a: array[1..Lim] of longint;
  data: array[1..Lim] of longint;

  function full_search(x: longint): longint;
  begin
    q := a[1];
    qp := 1;
    while i < Lim do
    begin
      for j := qp to q do
        data[j] := qboxes;
      qp := q;
      q += q;
    end;
  end;

begin
  readln(n, m);

  for i := 1 to n do
    read(a[i]);
  readln();

  for i := 1 to m do
  begin
    read(x);
    writeln(full_search(x));
  end;
  readln();

  readln();
end.

