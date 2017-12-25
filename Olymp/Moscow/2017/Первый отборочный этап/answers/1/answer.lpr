program answer;

var
  a, b, c: longint;

  function flights_count(x: longint; include: boolean): longint;
  begin
    flights_count := x div c;
    if not include and (x mod c = 0) then
      flights_count -= 1;
  end;

  function optimal_search(): longint;
  begin
    exit(flights_count(b, true) - flights_count(a, false));
  end;

begin
  readln(a);
  readln(b);
  readln(c);
  writeln(optimal_search());
end.

