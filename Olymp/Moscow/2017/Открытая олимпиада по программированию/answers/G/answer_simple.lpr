program answer_simple;

const
  Lim = 10000;

var
  i, j, n, m, q, u, v, c: longint;
  flights: array[1..Lim, 1..Lim] of longint;

  //procedure print_flights();
  //var
  //  i, j: longint;
  //begin
  //  Write('': 3);
  //  for i := 1 to n do
  //    Write(i: 3);
  //  writeln();
  //  for i := 1 to n do
  //  begin
  //    Write(i: 3);
  //    for j := 1 to n do
  //      if flights[i, j] <> 1000 then
  //        Write(flights[i, j]: 3)
  //      else
  //        Write('': 3);
  //    writeln();
  //  end;
  //end;

  procedure add_flight(u, v, c: longint);
  begin
    flights[u, v] := c;
    flights[v, u] := c;
  end;

  procedure delete_flight(u, v: longint);
  begin
    flights[u, v] := -1;
    flights[v, u] := -1;
  end;

  function full_search(start, finish: longint): longint;
  var
    smin, a, k: longint;
  begin
    if start = finish then
      exit(-1);

    a := flights[start, finish];

    if a <> -1 then
      smin := a
    else
      smin := Lim + Lim;

    for k := 1 to n do
      if (flights[start, k] <> -1) and (flights[k, finish] <> -1) and
        (flights[start, k] + flights[k, finish] < smin) then
        smin := flights[start, k] + flights[k, finish];

    if smin = Lim + Lim then
      exit(-1)
    else
      exit(smin);
  end;

begin
  for i := 1 to Lim do
    for j := 1 to Lim do
      flights[i, j] := -1;

  readln(n, m);
  for i := 1 to m do
  begin
    readln(u, v, c);
    add_flight(u, v, c);
  end;

  readln(q);
  for i := 1 to q do
  begin
    Read(j);
    case j of
      1:
      begin
        readln(u, v, c);
        add_flight(u, v, c);
      end;
      2:
      begin
        readln(u, v);
        delete_flight(u, v);
      end;
      3:
      begin
        readln(u, v);
        writeln(full_search(u, v));
      end;
    end;
  end;
end.
