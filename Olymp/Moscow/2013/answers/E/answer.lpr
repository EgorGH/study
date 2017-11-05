program answer;

const
  NMax = 100;
  KMax = 100;

type
  tmins_row = ^longint;
  tmins = ^tmins_row;

var
  T, N, K, a, b, i: longint;
  mins: tmins;

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

begin
  mins := GetMem((KMax + 1) * sizeof(tmins_row));
  for i := 0 to KMax do
    mins[i] := GetMem((NMax + 1) * sizeof(longint));

  fill_table(mins, KMax, NMax);

  readln(T);
  for i := 1 to T do
  begin
    readln(N, K, a, b);
    writeln(mins[n, k]);
  end;
end.
