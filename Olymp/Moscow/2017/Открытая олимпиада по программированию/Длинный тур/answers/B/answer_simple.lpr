program answer_simple;

const
  NLim = 1000000;

var
  Data: array[1..NLim] of longint;
  i, n: longint;

  function full_search(): ansistring;
  var
    i, j, k, sum, smax, idxleft, idxright: longint;
  begin
    smax := data[1];
    for i := 1 to n do
      for j := i to n do
        if Data[i] = Data[j] then
        begin
          sum := 0;
          for k := i to j do
            sum += Data[k];

          if sum > smax then
          begin
            smax := sum;
            idxleft := i;
            idxright := j;
          end;
        end;

    writestr(full_search, smax, LineEnding,
      idxleft, ' ', idxright);
  end;

begin
  readln(n);
  for i := 1 to n do
    Read(Data[i]);

  writeln(full_search());
end.
