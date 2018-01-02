program answer;

uses
  classes,
  strutils,
  Math;

const
  NLim = 10000;
  MLim = 10000;

type
  torder = array[1..MLim] of longint;

var
  goods: array[1..MLim] of shortstring;
  Data: array[1..NLim] of torder;
  always, often: torder;
  n, m: longint;

  function get_goods_id(Name: shortstring): longint;
  var
    i: longint;
  begin
    for i := 1 to m do
      if goods[i] = Name then
        exit(i);
    m += 1;
    goods[m] := Name;
    exit(m);
  end;

  procedure read_data();
  var
    i, j: longint;
    s: ansistring;
  begin
    readln(n);
    for i := 1 to n + 1 do
    begin
      readln(s);
      for j := 1 to wordcount(s, StdWordDelims) do
        Data[i, get_goods_id(ExtractWord(j, s, StdWordDelims))] := 1;
    end;
  end;

  procedure full_search(var order, always, often: torder);
  var
    i, j, k, lim: longint;
    sum: torder;
  begin
    for i := 1 to m do
      if order[i] = 1 then
      begin
        FillByte(sum[1], m * sizeof(longint), 0);
        for j := 1 to n do
          if Data[j, i] = 1 then
            for k := 1 to m do
              sum[k] += Data[j, k];
        lim := sum[i];
        for k := 1 to m do
          if sum[k] = lim then
            always[k] := 1
          else if sum[k] * 2 >= lim then
            often[k] := 1;
      end;
  end;

  procedure remove_order(var a, b: torder);
  var
    i: longint;
  begin
    for i := 1 to m do
      if b[i] = 1 then
        a[i] := 0;
  end;

  procedure print_order(var a: torder);
  var
    i: longint;
    list: TStringList;
  begin
    list := TStringList.Create();

    for i := 1 to m do
      if a[i] = 1 then
        list.Add(goods[i]);

    list.Sort();

    for i := 0 to list.Count - 1 do
      write(list[i], ' ');
    writeln();
  end;

begin
  read_data();
  full_search(Data[n + 1], always, often);
  remove_order(always, Data[n + 1]);
  full_search(always, often, often);
  remove_order(often, Data[n + 1]);
  remove_order(often, always);

  print_order(always);
  print_order(often);
end.
