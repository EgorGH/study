program test;

var
  a, b, c: longint;

  function full_search(): longint;
  var
    i, q: longint;
  begin
    q := 0;
    for i := a to b do
      if i mod c = 0 then
        q += 1;
    exit(q);
  end;

  function flights_count(x: longint; include: boolean): longint;
  begin
    flights_count := x div c;
    if not include and (x mod c = 0) then
      flights_count -= 1;
  end;

  function optimal_search(): longint;
  begin
    exit(flights_count(b, True) - flights_count(a, False));
  end;

  function process_test(): boolean;
  begin
    exit(optimal_search() = full_search());
  end;

begin
  randomize();
  for c := 1 to 10 do
    for a := 1 to 100 do
      for b := a to 100 do
        if not process_test() then
          writeln('error!');
  writeln('Done');
end.

