program answer_simple;

uses math;

var
  w, h: int64;

  function full_search(): int64;
  var
    i, j: longint;
    smax: int64;
  begin
    smax := 0;
    for i := 1 to min(w, h) do
      for j := 0 to min(min(w, h), max(w, h) - i) do
        if i * i + j * j > smax then
          smax := i * i + j * j;
    exit(smax);
  end;

begin
  readln(w, h);
  writeln(full_search());
end.

