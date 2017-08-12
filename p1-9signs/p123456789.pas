program p123456789;

uses
  Math,
  SysUtils;

const
  N = 9;

var
  M, v: integer;

  function eval(v: integer): integer;
  var
    res, factor, temp, i: integer;

  begin
    res := 0;
    temp := 0;
    factor := 1;

    for i := N downto 1 do
    begin
      if v mod 3 = 0 then
      begin
        res := res + i * factor + temp;
        temp := 0;
        factor := 1;
      end
      else if v mod 3 = 1 then
      begin
        res := res - i * factor - temp;
        temp := 0;
        factor := 1;
      end
      else if v mod 3 = 2 then
      begin
        temp := i * factor + temp;
        factor := factor * 10;
      end;
      v := v div 3;
    end;

    exit(res);
  end;

  function CodeToStr(v: integer): string;
  var
    s: string;
    i: integer;
  begin
    s := '';
    for i := N downto 1 do
    begin
      if v mod 3 = 0 then
        s := ' + ' + IntToStr(i) + s
      else if v mod 3 = 1 then
        s := ' - ' + IntToStr(i) + s
      else if v mod 3 = 2 then
        s := IntToStr(i) + s;
      v := v div 3;
    end;
    exit(copy(s, 4, length(s) - 1));
  end;

begin
  readln(M);
  for v := 1 to round(power(3, N - 1)) - 1 do
    if eval(v) = M then
      writeln(CodeToStr(v));
  readln();
end.
