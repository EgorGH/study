program answer;

uses
  SysUtils;

var
  s: Text;
  i: longint;
  str: ansistring;
  is_is_python: boolean;

begin
  assign(input, 'e2ans.txt');
  rewrite(input);

  for i := 1 to 700 do
  begin
    Assign(s, format('E2\%d', [i]));
    reset(s);
    is_python := true;

    while not EOF(s) do
    begin
      readln(s, str);

      if pos('begin', str) <> 0 then
      begin
        writeln('Pascal');
        is_python := false;
        break;
      end;

      if pos('void', str) <> 0 then
      begin
        writeln('C++');
        is_python := false;
        break;
      end;
    end;

    if is_python then
      writeln('Python');

    Close(s);
  end;
end.
