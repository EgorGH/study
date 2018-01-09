program answer_simple;

const
  Lim = 1000;

type
  tproblem = record
    score: longint;
    is_fixed: boolean;
  end;

var
  Data: array[1..Lim, 1..Lim + 2] of tproblem;
  s: array[1..Lim] of longint;
  c, i, j, n, m, q, k, p, t: longint;

  procedure sort_data(x: longint);
  var
    i, j, min, t: longint;
  begin
    for i := 1 to n - 1 do
    begin
      min := i;
      for j := i + 1 to n do
        if Data[min, x].score < Data[j, x].score then
          min := j;
      if min <> i then
      begin
        t := Data[i, x].score;
        Data[i, x].score := Data[min, x].score;
        Data[min, x].score := t;
      end;
    end;
  end;

  procedure full_search(x: longint);
  var
    i, j, maxscore, minscore, maxplace, minplace: longint;
  begin
    for i := 1 to n do
    begin
      Data[i, m + 1].score := 0;
      Data[i, m + 2].score := 0;
    end;

    for i := 1 to n do
      for j := 1 to m do
        if Data[i, j].is_fixed then
        begin
          Data[i, m + 1].score += Data[i, j].score;
          Data[i, m + 2].score += Data[i, j].score;
        end
        else if (i <> x) then
        begin
          Data[i, m + 1].score += Data[i, j].score;
          Data[i, m + 2].score += k;
        end
        else if (i = x) then
        begin
          Data[i, m + 1].score += k;
          Data[i, m + 2].score += Data[i, j].score;
        end;

    maxscore := Data[x, m + 1].score;
    minscore := Data[x, m + 2].score;

    for i := 1 to n - 1 do
      for j := i + 1 to n do
      begin
        if Data[i, m + 1].score = Data[j, m + 1].score then
          Data[j, m + 1].score := 0;
        if Data[i, m + 2].score = Data[j, m + 2].score then
          Data[j, m + 2].score := 0;
      end;

    sort_data(n + 1);
    sort_data(n + 2);

    for i := 1 to n do
    begin
      if Data[i, m + 1].score = maxscore then
        maxplace := i;
      if Data[i, m + 2].score = minscore then
        minplace := i;
    end;

    writeln(maxplace, ' ', minplace);
  end;

begin
  readln(n, m, q, k);

  for i := 1 to m do
    Read(s[i]);
  readln();

  for i := 1 to n do
  begin
    for j := 1 to m do
    begin
      Read(Data[i, j].score);
      if Data[i, j].score < k - s[j] then
        Data[i, j].is_fixed := True
      else
        Data[i, j].is_fixed := False;
    end;
    readln();
  end;

  for p := 1 to q do
  begin
    Read(t);
    case t of
      1:
      begin
        readln(i);
        full_search(i);
      end;
      2:
      begin
        readln(i, j, c);
        Data[i, j].score := c;
        Data[i, j].is_fixed := True;
      end;
    end;
  end;

  readln();
end.
