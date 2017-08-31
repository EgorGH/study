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
      izero := i
    else if a mod 2 <> 0 then
    begin
      if (a <= min_odd) or not found then
      begin
        found := True;
        imin_odd := i;
        min_odd := a;
      end;
      q_odd := q_odd + 1;
    end;
  end;

  if q_odd mod 2 <> 0 then
    for i := 1 to N do
      if (imin_odd <> i) and (i <> izero) then
        index := index + IntToStr(i) + ' ';

  if q_odd mod 2 = 0 then
    for i := 1 to N do
      if i <> izero then
        index := index + IntToStr(i) + ' ';

  writeln(index);
  readln();
end.
