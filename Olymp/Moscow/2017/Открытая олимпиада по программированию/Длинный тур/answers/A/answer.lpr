program answer;

uses math;

var
  w, h: int64;

  function optimal_search(): int64;
  var
    a, b, c: int64;
  begin
    if w = h then
      exit(w * w);

    a := max(w, h);
    b := min(w, h);
    c := min(a - b, b);

    exit(b * b + c * c);
  end;

begin
  readln(w, h);
  writeln(optimal_search());
end.

