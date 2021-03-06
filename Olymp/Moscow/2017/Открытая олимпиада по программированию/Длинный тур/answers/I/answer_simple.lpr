program answer_simple;

const
  Lim = 5000;

type
  tproblem = record
    score: longint;
    is_fixed: boolean;
  end;
  tdata = array[1..Lim] of longint;

var
  Data: array of array of tproblem;
  maxsums, minsums: tdata;
  s: array of longint;
  c, i, j, n, m, q, k, p, t: longint;

  procedure quicksort(var list: tdata; lo, hi: longint);
  var
    i, j: longint;
    pivot, t: longint;
  begin
    i := lo;
    j := hi;
    pivot := list[(lo + hi) div 2];
    while i <= j do
    begin
      while list[i] < pivot do
        i := i + 1;
      while list[j] > pivot do
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

  procedure form_maxsums();
  var
    i, j: longint;
  begin
    for i := 1 to n do
      for j := 1 to m do
        if Data[i, j].is_fixed then
          maxsums[i] += Data[i, j].score
        else
          maxsums[i] += k;
  end;

  procedure form_minsums();
  var
    i, j: longint;
  begin
    for i := 1 to n do
      for j := 1 to m do
        minsums[i] += Data[i, j].score;
  end;

  procedure update_sums(i, j, c: longint);
  begin
    maxsums[i] += c - (k - s[j]);
    minsums[i] := maxsums[i];
  end;

  procedure full_search(x: longint);
  var
    i, j, maxscore, minscore, maxplace, minplace, t: longint;
    a, b: tdata;
  begin
    a := maxsums;
    b := minsums;

    maxscore := a[x];
    minscore := b[x];

    t := a[x];
    a[x] := b[x];
    b[x] := t;

    quicksort(a, 1, n);
    quicksort(b, 1, n);

    for i := 1 to n do
    begin
      if b[i] = maxscore then
        maxplace := n - i + 1;
      if a[i] = minscore then
        minplace := n - i + 1;
    end;

    writeln(maxplace, ' ', minplace);
  end;

begin
  readln(n, m, q, k);

  setlength(data, n + 1, m + 1);
  setlength(s, m + 1);

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

  form_maxsums();
  form_minsums();

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
        update_sums(i, j, c);
      end;
    end;
  end;
end.
