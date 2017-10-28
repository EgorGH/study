program answer;

uses
  Math;

var
  N: qword;

  function optimal_search(N: qword): qword;
  var
    q, p, w: qword;
  begin

    p := 1;
    while p * 2 <= N do
    begin
      p := p * 2;
    end;

    q := 1;
    w := p;

    while p <> N do
    begin
      w := w div 2;
      if N > p then
      begin
        q := q * 2;
        p := p + w;
      end
      else
        p := p - w;
    end;

    exit(q);
  end;

begin
  readln(N);
  writeln(optimal_search(N));
end.
