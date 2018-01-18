program answer_simple;

uses
  Math,
  Classes;

const
  Lim = 100000;
  CLim = 1000000000;
  SLim = CLim + CLim + 1;

type
  tflights = record
    a: array of longint;
    b: TFPList;
  end;

var
  i, j, n, m, q, u, v, c: longint;
  flights: array of tflights;

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
  //      if flights[i, j] <> -1 then
  //        Write(flights[i, j]: 3)
  //      else
  //        Write('': 3);
  //    writeln();
  //  end;
  //end;

  function compare(a, b: Pointer): longint;
  begin
    exit(longint(a) - longint(b));
  end;

  procedure add_flight(u, v, c: longint);
  begin
    flights[u].a[v] := c;
    flights[v].a[u] := c;
    flights[u].b.add(pointer(v));
    flights[v].b.add(pointer(u));
  end;

  procedure delete_flight(u, v: longint);
  begin
    //flights[u].a[v] := -1;
    //flights[v].a[u] := -1;
    flights[u].b.Delete(flights[u].b.IndexOf(pointer(v)));
    flights[v].b.Delete(flights[v].b.IndexOf(pointer(u)));
  end;

  function full_search(start, finish: longint): longint;
  var
    list: TFPList;
    smin, sum, i, x: longint;
  begin
    smin := flights[start].a[finish];
    if flights[start].b.IndexOf(pointer(finish)) = -1 then
      smin := SLim;

    list := TFPList.Create;
    list.capacity := 1000;

    for i := 0 to flights[start].b.Count - 1 do
      list.add(pointer(flights[start].b[i]));
    for i := 0 to flights[finish].b.Count - 1 do
      list.add(pointer(flights[finish].b[i]));

    list.sort(@compare);

    for i := 1 to list.count - 1 do
      if longint(list[i - 1]) = longint(list[i]) then
      begin
        x := longint(list[i]);
        sum := flights[start].a[x] + flights[finish].a[x];
        if sum < smin then
          smin := sum;
      end;

    //smin := flights[start, finish];

    //if smin = -1 then
    //  smin := SLim;

    //for i := 1 to n do
    //begin
    //  a := flights[i, start];
    //  b := flights[i, finish];
    //  sum := a + b;
    //  if (a > -1) and (b > -1) and (sum < smin) then
    //    smin := sum;
    //end;

    exit(IfThen(smin = SLim, -1, smin));
  end;

begin
  //assign(input, 'tests\01.');
  //reset(input);
  readln(n, m);

  SetLength(flights, n + 1);

  for i := 1 to n do
  begin
    SetLength(flights[i].a, n + 1);
    flights[i].b := TFPList.Create;
    flights[i].b.capacity := 500;
  end;

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
