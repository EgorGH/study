program test;

const
  MaxT = 10000;
  Lim = 100000;

var
  k, n, t: longint;
  Data: array[1..Lim] of longint;

  function full_search(): longint;
  var
    i, j, free_space: longint;
    ans: longint;
  begin
    ans := 0;
    i := n;
    while i >= 1 do
    begin
      if Data[i] = 0 then
      begin
        i -= 1;
        continue;
      end;

      free_space := k;
      if Data[i] > free_space then
      begin
        Data[i] -= free_space;
        ans += i * 2;
      end
      else
      begin
        for j := i downto 1 do
          if Data[j] <= free_space then
          begin
            free_space -= Data[j];
            Data[j] := 0;
          end
          else
          begin
            Data[j] -= free_space;
            break;
          end;

        ans += i * 2;
        i -= 1;
      end;
    end;
    exit(ans);
  end;

  function optimal_search(): longint;
  var
    i, free_space, ans: longint;
  begin
    ans := 0;
    for i := n downto 1 do
    begin
      if data[i] > free_space then
      begin
        data[i] -= free_space;

      end
      else
        free_space -= data[i];
    end;
    exit(ans);
  end;

  function process_test(maxk, maxn, maxdata: longint): boolean;
  var
    i: longint;
  begin
    k := random(maxk) + 1;
    n := random(maxn) + 1;
    for i := 1 to n do
      Data[i] := random(maxdata + 1);
    exit(full_search() = optimal_search());
  end;

begin
  randomize();
  for t := 1 to MaxT do
    if not process_test(1000, 1000, 1000) then
      writeln('error!');
  writeln('done!');
end.
