program test;

const
  MaxT = 10000;
  Lim = 100000;

var
  k, n, t: longint;
  Data: array[1..Lim] of longint;

  function full_search(): qword;
  var
    i, j: longint;
    free_space: qword;
    Data_copy: array[1..Lim] of longint;
  begin
    full_search := 0;
    Data_copy := data;

    i := n;
    while i >= 1 do
    begin
      if Data_copy[i] = 0 then
      begin
        i -= 1;
        continue;
      end;

      free_space := k;
      full_search += i * 2;

      if Data_copy[i] > free_space then
        Data_copy[i] -= free_space
      else
      begin
        for j := i downto 1 do
          if Data_copy[j] <= free_space then
          begin
            free_space -= Data_copy[j];
            Data_copy[j] := 0;
          end
          else
          begin
            Data_copy[j] -= free_space;
            break;
          end;

        i -= 1;
      end;
    end;
  end;

  function optimal_search(): qword;
  var
    i: longint;
    free_space, x: qword;
  begin
    free_space := 0;
    optimal_search := 0;

    for i := n downto 1 do
    begin
      if Data[i] > free_space then
      begin
        Data[i] -= free_space;
        if Data[i] mod k <> 0 then
          x := Data[i] div k + 1
        else
          x := Data[i] div k;
        optimal_search += 2 * i * x;
        free_space := x * k - Data[i];
      end
      else
        free_space -= Data[i];
    end;
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
