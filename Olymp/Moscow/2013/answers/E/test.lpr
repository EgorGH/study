program test;

const
  MaxT = 1000;
  NMax = 100;
  KMax = 100;

type
  tmins_row = ^longint;
  tmins = ^tmins_row;

var
  t, i, n, k, min1, min2: longint;
  cache, mins: tmins;

  procedure init();
  var
    i, j: longint;
  begin
    n := random(NMax) + 1;
    k := random(n) + 1;
    for i := 0 to NMax do
      for j := 0 to KMax do
        cache[i, j] := -1;
  end;

  function cached_search(cache: tmins; n, k: longint): longint;
  forward;

  function full_search(cache: tmins; n, k: longint): longint;
  var
    a, b, i, d, w, max, min: longint;
  begin
    min := 100;
    if (n = k) or (k = 0) then
      exit(0);
    for w := 1 to n - 1 do
    begin
      max := 0;
      a := w;
      b := n - w;
      for i := 0 to k do
        if (i <= a) and (k - i <= b) then
        begin
          d := cached_search(cache, a, i) + cached_search(cache, b, k - i) + 1;
          if d > max then
            max := d;
        end;
      if max < min then
        min := max;
    end;
    cache[n, k] := min;
    exit(min);
  end;

  function cached_search(cache: tmins; n, k: longint): longint;
  var
    q: longint;
  begin
    if cache[n, k] = -1 then
    begin
      q := full_search(cache, n, k);
      cache[n, k] := q;
      exit(q);
    end
    else
      exit(cache[n, k]);
  end;

  procedure fill_table(mins: tmins; NMax, KMax: longint);
  var
    a, b, i, j, d, w, max, min: longint;
  begin
    for i := 0 to NMax do
      for j := 0 to KMax do
        mins[i, j] := -1;

    for i := 0 to NMax do
    begin
      mins[0, i] := 0;
      mins[i, 0] := 0;
      for j := 0 to KMax do
        if i = j then
          mins[i, j] := 0;
    end;

    for n := 1 to NMax do
      for k := 1 to KMax do
      begin
        if mins[n, k] <> -1 then
          break;
        min := 100;
        for w := 1 to n - 1 do
        begin
          max := 0;
          a := w;
          b := n - w;
          for i := 0 to k do
            if (i <= a) and (k - i <= b) then
            begin
              d := mins[a, i] + mins[b, k - i] + 1;
              if d > max then
                max := d;
            end;
          if max < min then
            min := max;
        end;
        mins[n, k] := min;
      end;
  end;

  function optimal_search(mins: tmins; n, k: longint): longint;
  begin
    exit(mins[n, k]);
  end;

begin
  mins := GetMem((KMax + 1) * sizeof(tmins_row));
  for i := 0 to KMax do
    mins[i] := GetMem((NMax + 1) * sizeof(longint));
  cache := GetMem((KMax + 1) * sizeof(tmins_row));
  for i := 0 to KMax do
    cache[i] := GetMem((NMax + 1) * sizeof(longint));

  fill_table(mins, NMax, KMax);

  randomize();
  for t := 1 to MaxT do
  begin
    init();
    min1 := cached_search(cache, n, k);
    min2 := optimal_search(mins, n, k);
    if min1 <> min2 then
      writeln('Error!');
  end;
  writeln('Done');
end.
