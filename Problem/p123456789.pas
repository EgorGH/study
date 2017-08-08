program p123456789;

uses math, sysutils;

const
  D = 9;
  Q = 8;

var
  N, i: integer;

  function find_sum(v: integer): integer;
  var
    sum, digit, number, i: integer;

  begin
    sum := 1;
    number := 0;
    digit := 1;

    for i := D downto 1 do
    begin
      if v mod 3 = 0 then
      begin
        sum := sum + i * digit + number;
        digit := 1;
        number := 0;
      end
      else if v mod 3 = 1 then
      begin
        sum := sum - i * digit - number;
        digit := 1;
        number := 0;
      end
      else if v mod 3 = 2 then
      begin
        number := i * digit + number;
        digit := digit * 10;
      end;
      v := v div 3;
    end;

    exit(sum);
  end;

  procedure print(a: integer);
  var
    s: string;
    i: integer;

  begin
    s := '';

    for i := D downto 2 do
    begin
      if a mod 3 = 0 then
        s := ' + ' + Inttostr(i) + s
      else if a mod 3 = 1 then
        s :=  ' - ' + Inttostr(i) + s
      else if a mod 3 = 2 then
        s := '' + Inttostr(i) + s ;
      a := a div 3;
    end;
    writeln('1' + s);
  end;

begin
  readln(N);
  for i := 1 to round(power(3, Q)) - 1 do
  begin
    if find_sum(i) = N + 1 then
      print(i);
  end;
  readln();
end.
