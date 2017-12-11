program answer_slow;

uses
  SysUtils;

var
  ticket: shortstring;
  left, right, str: shortstring;
  i, nleft, nright, k: longint;
  q: longint = 0;

  function power_10(x: longint): longint;
  begin
    power_10 := 1;
    while x > 0 do
    begin
      power_10 := power_10 * 10;
      x := x - 1;
    end;
  end;

  function digit_sum(x: longint): longint;
  begin
    digit_sum := 0;
    while x <> 0 do
    begin
      digit_sum := digit_sum + x mod 10;
      x := x div 10;
    end;
  end;

  function check(ticket: shortstring): boolean;
  var
    len: longint;
  begin
    len := length(ticket);
    while ticket[1] = '0' do
      Delete(ticket, 1, 1);

    if length(ticket) * 2 <= len then
      exit(False)
    else
      exit(True);
  end;

  procedure delete_zeros(var x: shortstring);
  begin
    while x[1] = '0' do
      Delete(x, 1, 1);
  end;

begin
  readln(ticket);
  for i := 1 to length(ticket) do
    if ticket[i] = '9' then
      q := q + 1;

  if q = length(ticket) then
  begin
    str := '';
    for i := 1 to length(ticket) div 2 do
      str := str + '0';
    str := str + '1';
    writeln(str, str);
  end;

  if not check(ticket) then
  begin
    str := '';
    for i := 1 to length(ticket) div 2 - 1 do
      str := str + '0';
    str := str + '1';
    writeln(str, str);
  end;

  k := length(ticket) div 2;
  left := copy(ticket, 1, k);
  right := copy(ticket, k + 1, k);

  delete_zeros(left);
  delete_zeros(right);

  nleft := StrToInt(left);
  nright := StrToInt(right);

  if digit_sum(nleft) = digit_sum(nright) then
    nright := nright + 1;

  while (digit_sum(nleft) <> digit_sum(nright)) and (nright < power_10(k)) do
    nright := nright + 1;

  if nright = power_10(k) then
  begin
    nleft := nleft + 1;
    nright := 1;
    while (digit_sum(nleft) <> digit_sum(nright)) and (nright < power_10(k)) do
      nright := nright + 1;
  end;

  left := IntToStr(nleft);
  right := IntToStr(nright);

  while length(left) <> k do
    left := '0' + left;
  while length(right) <> k do
    right := '0' + right;

  writeln(left, right);
end.
