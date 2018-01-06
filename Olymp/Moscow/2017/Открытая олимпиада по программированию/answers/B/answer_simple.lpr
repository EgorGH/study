program answer_simple;

const
  NLim = 1000000;

var
  Data: array[1..NLim] of longint;
  i, n, idxleft, idxright, smax: longint;

  procedure full_search();
  var
    i, j, k, sum: longint;
    found: boolean = false;
  begin
    for i := 1 to n do
      for j := i to n do
      begin
        if Data[i] <> Data[j] then
          continue;

        sum := 0;
        for k := i to j do
          sum += Data[k];

        if not found or (sum > smax) then
        begin
          found := true;
          smax := sum;
          idxleft := i;
          idxright := j;
        end;
      end;
  end;

begin
  readln(n);
  for i := 1 to n do
    Read(Data[i]);

  full_search();

  writeln(smax);
  writeln(idxleft, ' ', idxright);
end.
