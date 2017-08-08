program p123456789;

uses math;

const
  D = 9;

var
  N, i: integer;

  function find_sum(v: integer): integer;
  var
    sum, digit, number, i: integer;

  begin
    sum := 0;
    number := 0;
    digit := 1;

    for i := D downto 2 do
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
        s :=
      else if a mod 3 = 1 then
        s :=
      else if a mod 3 = 2 then
        s := ;
      a := a div 3;
    end;
    writeln(s);
  end;

begin
  readln(N);
  for i := 1 to round(power(3, D)) - 1 do
  begin
    if find_sum(i) = N then
      print(i);
  end;
  readln();
end.
