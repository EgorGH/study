program answer;

uses
  SysUtils;

var
  index: string;
  N, a, i, min_odd, imin_odd, q_odd, izero: longint;
  found: boolean;
begin
  index := '';
  found := False;
  q_odd := 0;

  readln(N);

  for i := 1 to N do
  begin
    readln(a);

    if a = 0 then
      izero := i;

    if (a mod 2 <> 0) and (not found or (a <= min_odd)) then
    begin
      found := True;
      imin_odd := i;
      min_odd := a;
    end;

    if (a mod 2 <> 0) then
      q_odd := q_odd + 1;
  end;

  for i := 1 to N do
    if (i <> izero) and ((q_odd mod 2 = 0) or (i <> imin_odd)) then
      write(i, ' ');

  readln();
end.
