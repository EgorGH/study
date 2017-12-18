program answer_slow;

var
  str: shortstring;
  finished: boolean;

begin
  while not EOF(input) do
  begin
    readln(input, str);
    finished := False;
    while not finished do
    begin
      if pos('1', str) <> 0 then
        str[pos('1', str)] := 'x'
      else
      if pos('4', str) <> 0 then
        str[pos('4', str)] := 'x'
      else
      if pos('7', str) <> 0 then
        str[pos('7', str)] := 'x'
      else
      if pos('2', str) <> 0 then
      begin
        insert('xx', str, pos('2', str));
        Delete(str, pos('2', str), 1);
      end
      else
      if pos('5', str) <> 0 then
      begin
        insert('xx', str, pos('5', str));
        Delete(str, pos('5', str), 1);
      end
      else
      if pos('8', str) <> 0 then
      begin
        insert('xx', str, pos('8', str));
        Delete(str, pos('8', str), 1);
      end
      else
      if pos('0', str) <> 0 then
        Delete(str, pos('0', str), 1)
      else
      if pos('3', str) <> 0 then
        Delete(str, pos('3', str), 1)
      else
      if pos('6', str) <> 0 then
        Delete(str, pos('6', str), 1)
      else
      if pos('9', str) <> 0 then
        Delete(str, pos('9', str), 1)
      else
      if pos('xxxx', str) <> 0 then
        Delete(str, pos('xxxx', str), 3)
      else
      if pos('xxx', str) <> 0 then
      begin
        insert('zero', str, pos('xxx', str));
        Delete(str, pos('xxx', str), 3);
      end
      else
      if pos('xx', str) <> 0 then
      begin
        insert('two', str, pos('xx', str));
        Delete(str, pos('xx', str), 2);
      end
      else
      if pos('x', str) <> 0 then
      begin
        insert('one', str, pos('x', str));
        Delete(str, pos('x', str), 1);
      end
      else
        finished := True;
    end;
    writeln(str);
  end;
end.
