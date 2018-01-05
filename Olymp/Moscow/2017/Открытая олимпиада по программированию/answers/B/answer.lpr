program answer;

uses
  Classes;

type
  TNode = record
    Value, maxleft, maxright, lastleft, lastright: longint;
    maxsum, lastleftsum, lastrightsum: int64;
  end;

const
  NLim = 1000000;

var
  Data: array[1..NLim] of longint;
  nodes: array[1..NLim] of TNode;
  keys: array[1..NLim] of longint;
  i, n, m: longint;

  procedure init_node(var node: TNode; idx, val: longint; sum: int64);
  begin
    node.Value := val;
    node.maxsum := 0;
    node.maxleft := idx;
    node.maxright := idx;
    node.lastleft := idx;
    node.lastright := idx;
    node.lastleftsum := sum;
    node.lastrightsum := sum;
  end;

  procedure update_node(var node: TNode; idx: longint; sum: int64);
  begin
    if sum - node.lastleftsum > node.maxsum then
    begin
      node.maxleft := node.lastleft;
      node.maxright := idx;
      node.maxsum := sum - node.lastleftsum;
    end;

    if sum - node.lastrightsum > node.maxsum then
    begin
      node.maxleft := node.lastright;
      node.maxright := idx;
      node.maxsum := sum - node.lastrightsum;
    end;

    if sum <= node.lastleftsum then
    begin
      node.lastleft := idx;
      node.lastright := idx;
      node.lastleftsum := sum;
    end;
  end;

  function node_to_string(node: TNode): ansistring;
  begin
    writestr(node_to_string, node.maxsum + node.Value, LineEnding,
      node.maxleft, ' ', node.maxright);
  end;

  function index_of_key(key: longint): longint;
  var
    idx, l, r, v: longint;
  begin
    l := 1;
    r := m;
    repeat
      idx := (l + r) div 2;
      v := keys[idx];
      if v > key then
        r := idx - 1
      else
        l := idx + 1
    until v = key;
    exit(idx);
  end;

  function compare(a, b: Pointer): longint;
  begin
    exit(longint(a) - longint(b));
  end;

  procedure populate_keys();
  var
    i: longint;
    list: TFPList;
  begin
    list := TFPList.Create;
    list.Capacity := n;
    for i := 1 to n do
      list.Add(Pointer(Data[i]));
    list.Sort(@compare);

    m := 1;
    keys[1] := longint(list[0]);
    for i := 1 to n - 1 do
      if longint(list[i]) <> longint(list[i - 1]) then
      begin
        m += 1;
        keys[m] := longint(list[i]);
      end;
  end;

  function optimal_search(): TNode;
  var
    i, j, x: longint;
    sum: int64 = 0;
    list: TFPList;
  begin
    populate_keys();

    for i := 1 to n do
    begin
      x := Data[i];
      sum += x;

      j := index_of_key(x);
      if nodes[j].lastleft = 0 then
        init_node(nodes[j], i, x, sum)
      else
        update_node(nodes[j], i, sum);
    end;

    j := 1;
    for i := 2 to m do
      if nodes[i].Value + nodes[i].maxsum > nodes[j].Value + nodes[j].maxsum then
        j := i;

    exit(nodes[j]);
  end;

begin
  readln(n);
  for i := 1 to n do
    Read(Data[i]);

  writeln(node_to_string(optimal_search()));
end.
