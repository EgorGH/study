program answer;

uses
  Math,
  Classes;

const
  Lim = 100000;
  CLim = 1000000000;
  SLim = CLim + CLim + 1;

type
  tflights = record
    a: TFPList;
    b: TFPList;
  end;

  tinfo = record
    city, cost: longint;
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

  procedure add_flight(u, v, c: longint);
  begin
    flights[u].a.add(pointer(c));
    flights[v].a.add(pointer(c));
    flights[u].b.add(pointer(v));
    flights[v].b.add(pointer(u));
  end;

  procedure delete_flight(u, v: longint);
  begin
    //flights[u].a[v] := -1;
    //flights[v].a[u] := -1;
    flights[u].a.Delete(flights[u].b.IndexOf(pointer(v)));
    flights[v].a.Delete(flights[v].b.IndexOf(pointer(u)));
    flights[u].b.Delete(flights[u].b.IndexOf(pointer(v)));
    flights[v].b.Delete(flights[v].b.IndexOf(pointer(u)));
  end;

  procedure quicksort(var list: array of tinfo; lo, hi: longint);
  var
    i, j: longint;
    pivot: longint;
    t: tinfo;
  begin
    i := lo;
    j := hi;
    pivot := list[(lo + hi) div 2].city;
    while i <= j do
    begin
      while list[i].city < pivot do
        i := i + 1;
      while list[j].city > pivot do
        j := j - 1;
      if i <= j then
      begin
        t := list[i];
        list[i] := list[j];
        list[j] := t;
        i := i + 1;
        j := j - 1;
      end;
    end;
    if lo < j then
      quicksort(list, lo, j);
    if hi > i then
      quicksort(list, i, hi);
  end;

  function full_search(start, finish: longint): longint;
  var
    list: array of tinfo;
    smin, sum, i, x1, x2, size: longint;
  begin
    x1 := flights[start].b.IndexOf(pointer(finish));
    if x1 = -1 then
      smin := SLim
    else
      smin := longint(flights[start].a[x1]);

    setlength(list, 2000);

    x1 := flights[start].b.Count;

    for i := 0 to x1 - 1 do
    begin
      list[i].city := longint(flights[start].b[i]);
      list[i].cost := longint(flights[start].a[i]);
    end;

    x2 := flights[finish].b.count;

    for i := 0 to x2 - 1 do
    begin
      list[x1 + i].city := longint(flights[finish].b[i]);
      list[x1 + i].cost := longint(flights[finish].a[i]);
    end;

    size := x1 + x2;
    quicksort(list, 0, size - 1);

    for i := 1 to size - 1 do
      if list[i - 1].city = list[i].city then
      begin
        sum := list[i - 1].cost + list[i].cost;
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
  //assign(input, 'tests\13.');
  //reset(input);
  readln(n, m);

  SetLength(flights, n + 1);

  for i := 1 to n do
  begin
    flights[i].a := TFPList.Create;
    flights[i].a.capacity := 1000;
    flights[i].b := TFPList.Create;
    flights[i].b.capacity := 1000;
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
