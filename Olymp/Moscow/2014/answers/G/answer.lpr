program answer;

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
      //sift
      if pos('x0', str) <> 0 then
      begin
        insert('0x', str, pos('x0', str));
        Delete(str, pos('x0', str), 2);
      end
      else
      if pos('x1', str) <> 0 then
      begin
        insert('1x', str, pos('x1', str));
        Delete(str, pos('x1', str), 2);
      end
      else
      if pos('x2', str) <> 0 then
      begin
        insert('2x', str, pos('x2', str));
        Delete(str, pos('x2', str), 2);
      end
      else
      if pos('x3', str) <> 0 then
      begin
        insert('3x', str, pos('x3', str));
        Delete(str, pos('x3', str), 2);
      end
      else
      if pos('x4', str) <> 0 then
      begin
        insert('4x', str, pos('x4', str));
        Delete(str, pos('x4', str), 2);
      end
      else
      if pos('x5', str) <> 0 then
      begin
        insert('5x', str, pos('x5', str));
        Delete(str, pos('x5', str), 2);
      end
      else
      if pos('x6', str) <> 0 then
      begin
        insert('6x', str, pos('x6', str));
        Delete(str, pos('x6', str), 2);
      end
      else
      if pos('x7', str) <> 0 then
      begin
        insert('7x', str, pos('x7', str));
        Delete(str, pos('x7', str), 2);
      end
      else
      if pos('x8', str) <> 0 then
      begin
        insert('8x', str, pos('x8', str));
        Delete(str, pos('x8', str), 2);
      end
      else
      if pos('x9', str) <> 0 then
      begin
        insert('9x', str, pos('x9', str));
        Delete(str, pos('x9', str), 2);
      end
      //initialize
      else
      if pos('0x', str) <> 0 then
      begin
        insert('0a', str, pos('0x', str));
        Delete(str, pos('0x', str), 2);
      end
      else
      if pos('1x', str) <> 0 then
      begin
        insert('1a', str, pos('1x', str));
        Delete(str, pos('1x', str), 2);
      end
      else
      if pos('2x', str) <> 0 then
      begin
        insert('2a', str, pos('2x', str));
        Delete(str, pos('2x', str), 2);
      end
      else
      if pos('3x', str) <> 0 then
      begin
        insert('3a', str, pos('3x', str));
        Delete(str, pos('3x', str), 2);
      end
      else
      if pos('4x', str) <> 0 then
      begin
        insert('4a', str, pos('4x', str));
        Delete(str, pos('4x', str), 2);
      end
      else
      if pos('5x', str) <> 0 then
      begin
        insert('5a', str, pos('5x', str));
        Delete(str, pos('5x', str), 2);
      end
      else
      if pos('6x', str) <> 0 then
      begin
        insert('6a', str, pos('6x', str));
        Delete(str, pos('6x', str), 2);
      end
      else
      if pos('7x', str) <> 0 then
      begin
        insert('7a', str, pos('7x', str));
        Delete(str, pos('7x', str), 2);
      end
      else
      if pos('8x', str) <> 0 then
      begin
        insert('8a', str, pos('8x', str));
        Delete(str, pos('8x', str), 2);
      end
      else
      if pos('9x', str) <> 0 then
      begin
        insert('9a', str, pos('9x', str));
        Delete(str, pos('9x', str), 2);
      end
      else
      //processing 1
      if pos('0a', str) <> 0 then
      begin
        insert('c', str, pos('0a', str));
        Delete(str, pos('0a', str), 2);
      end
      else
      if pos('1a', str) <> 0 then
      begin
        insert('ct', str, pos('1a', str));
        Delete(str, pos('1a', str), 2);
      end
      else
      if pos('2a', str) <> 0 then
      begin
        insert('ctt', str, pos('2a', str));
        Delete(str, pos('2a', str), 2);
      end
      else
      if pos('3a', str) <> 0 then
      begin
        insert('cttt', str, pos('3a', str));
        Delete(str, pos('3a', str), 2);
      end
      else
      if pos('4a', str) <> 0 then
      begin
        insert('ctttt', str, pos('4a', str));
        Delete(str, pos('4a', str), 2);
      end
      else
      if pos('5a', str) <> 0 then
      begin
        insert('cttttt', str, pos('5a', str));
        Delete(str, pos('5a', str), 2);
      end
      else
      if pos('6a', str) <> 0 then
      begin
        insert('ctttttt', str, pos('6a', str));
        Delete(str, pos('6a', str), 2);
      end
      else
      if pos('7a', str) <> 0 then
      begin
        insert('cttttttt', str, pos('7a', str));
        Delete(str, pos('7a', str), 2);
      end
      else
      if pos('8a', str) <> 0 then
      begin
        insert('ctttttttt', str, pos('8a', str));
        Delete(str, pos('8a', str), 2);
      end
      else
      if pos('9a', str) <> 0 then
      begin
        insert('cttttttttt', str, pos('9a', str));
        Delete(str, pos('9a', str), 2);
      end
      else
      //processing 2
      if pos('0b', str) <> 0 then
      begin
        insert('f', str, pos('0b', str));
        Delete(str, pos('0b', str), 2);
      end
      else
      if pos('1b', str) <> 0 then
      begin
        insert('ftt', str, pos('1b', str));
        Delete(str, pos('1b', str), 2);
      end
      else
      if pos('2b', str) <> 0 then
      begin
        insert('ftttt', str, pos('2b', str));
        Delete(str, pos('2b', str), 2);
      end
      else
      if pos('3b', str) <> 0 then
      begin
        insert('ftttttt', str, pos('3b', str));
        Delete(str, pos('3b', str), 2);
      end
      else
      if pos('4b', str) <> 0 then
      begin
        insert('ftttttttt', str, pos('4b', str));
        Delete(str, pos('4b', str), 2);
      end
      else
      if pos('5b', str) <> 0 then
      begin
        insert('ftttttttttt', str, pos('5b', str));
        Delete(str, pos('5b', str), 2);
      end
      else
      if pos('6b', str) <> 0 then
      begin
        insert('ftttttttttttt', str, pos('6b', str));
        Delete(str, pos('6b', str), 2);
      end
      else
      if pos('7b', str) <> 0 then
      begin
        insert('ftttttttttttttt', str, pos('7b', str));
        Delete(str, pos('7b', str), 2);
      end
      else
      if pos('8b', str) <> 0 then
      begin
        insert('ftttttttttttttttt', str, pos('8b', str));
        Delete(str, pos('8b', str), 2);
      end
      else
      if pos('9b', str) <> 0 then
      begin
        insert('ftttttttttttttttttt', str, pos('9b', str));
        Delete(str, pos('9b', str), 2);
      end
      else
      //processing 3
      if pos('0c', str) <> 0 then
      begin
        insert('b', str, pos('0c', str));
        Delete(str, pos('0c', str), 2);
      end
      else
      if pos('1c', str) <> 0 then
      begin
        insert('bttt', str, pos('1c', str));
        Delete(str, pos('1c', str), 2);
      end
      else
      if pos('2c', str) <> 0 then
      begin
        insert('btttttt', str, pos('2c', str));
        Delete(str, pos('2c', str), 2);
      end
      else
      if pos('3c', str) <> 0 then
      begin
        insert('bttttttttt', str, pos('3c', str));
        Delete(str, pos('3c', str), 2);
      end
      else
      if pos('4c', str) <> 0 then
      begin
        insert('btttttttttttt', str, pos('4c', str));
        Delete(str, pos('4c', str), 2);
      end
      else
      if pos('5c', str) <> 0 then
      begin
        insert('bttttttttttttttt', str, pos('5c', str));
        Delete(str, pos('5c', str), 2);
      end
      else
      if pos('6c', str) <> 0 then
      begin
        insert('btttttttttttttttttt', str, pos('6c', str));
        Delete(str, pos('6c', str), 2);
      end
      else
      if pos('7c', str) <> 0 then
      begin
        insert('bttttttttttttttttttttt', str, pos('7c', str));
        Delete(str, pos('7c', str), 2);
      end
      else
      if pos('8c', str) <> 0 then
      begin
        insert('btttttttttttttttttttttttt', str, pos('8c', str));
        Delete(str, pos('8c', str), 2);
      end
      else
      if pos('9c', str) <> 0 then
      begin
        insert('bttttttttttttttttttttttttttt', str, pos('9c', str));
        Delete(str, pos('9c', str), 2);
      end
      else
      //processing 4
      if pos('0d', str) <> 0 then
      begin
        insert('e', str, pos('0d', str));
        Delete(str, pos('0d', str), 2);
      end
      else
      if pos('1d', str) <> 0 then
      begin
        insert('etttt', str, pos('1d', str));
        Delete(str, pos('1d', str), 2);
      end
      else
      if pos('2d', str) <> 0 then
      begin
        insert('etttttttt', str, pos('2d', str));
        Delete(str, pos('2d', str), 2);
      end
      else
      if pos('3d', str) <> 0 then
      begin
        insert('etttttttttttt', str, pos('3d', str));
        Delete(str, pos('3d', str), 2);
      end
      else
      if pos('4d', str) <> 0 then
      begin
        insert('etttttttttttttttt', str, pos('4d', str));
        Delete(str, pos('4d', str), 2);
      end
      else
      if pos('5d', str) <> 0 then
      begin
        insert('etttttttttttttttttttt', str, pos('5d', str));
        Delete(str, pos('5d', str), 2);
      end
      else
      if pos('6d', str) <> 0 then
      begin
        insert('etttttttttttttttttttttttt', str, pos('6d', str));
        Delete(str, pos('6d', str), 2);
      end
      else
      if pos('7d', str) <> 0 then
      begin
        insert('etttttttttttttttttttttttttttt', str, pos('7d', str));
        Delete(str, pos('7d', str), 2);
      end
      else
      if pos('8d', str) <> 0 then
      begin
        insert('etttttttttttttttttttttttttttttttt', str, pos('8d', str));
        Delete(str, pos('8d', str), 2);
      end
      else
      if pos('9d', str) <> 0 then
      begin
        insert('etttttttttttttttttttttttttttttttttttt', str, pos('9d', str));
        Delete(str, pos('9d', str), 2);
      end
      else
      //processing 5
      if pos('0e', str) <> 0 then
      begin
        insert('a', str, pos('0e', str));
        Delete(str, pos('0e', str), 2);
      end
      else
      if pos('1e', str) <> 0 then
      begin
        insert('attttt', str, pos('1e', str));
        Delete(str, pos('1e', str), 2);
      end
      else
      if pos('2e', str) <> 0 then
      begin
        insert('atttttttttt', str, pos('2e', str));
        Delete(str, pos('2e', str), 2);
      end
      else
      if pos('3e', str) <> 0 then
      begin
        insert('attttttttttttttt', str, pos('3e', str));
        Delete(str, pos('3e', str), 2);
      end
      else
      if pos('4e', str) <> 0 then
      begin
        insert('atttttttttttttttttttt', str, pos('4e', str));
        Delete(str, pos('4e', str), 2);
      end
      else
      if pos('5e', str) <> 0 then
      begin
        insert('attttttttttttttttttttttttt', str, pos('5e', str));
        Delete(str, pos('5e', str), 2);
      end
      else
      if pos('6e', str) <> 0 then
      begin
        insert('atttttttttttttttttttttttttttttt', str, pos('6e', str));
        Delete(str, pos('6e', str), 2);
      end
      else
      if pos('7e', str) <> 0 then
      begin
        insert('attttttttttttttttttttttttttttttttttt', str, pos('7e', str));
        Delete(str, pos('7e', str), 2);
      end
      else
      if pos('8e', str) <> 0 then
      begin
        insert('atttttttttttttttttttttttttttttttttttttttt', str, pos('8e', str));
        Delete(str, pos('8e', str), 2);
      end
      else
      if pos('9e', str) <> 0 then
      begin
        insert('attttttttttttttttttttttttttttttttttttttttttttt', str, pos('9e', str));
        Delete(str, pos('9e', str), 2);
      end
      else
      //processing 6
      if pos('0f', str) <> 0 then
      begin
        insert('d', str, pos('0f', str));
        Delete(str, pos('0f', str), 2);
      end
      else
      if pos('1f', str) <> 0 then
      begin
        insert('dtttttt', str, pos('1f', str));
        Delete(str, pos('1f', str), 2);
      end
      else
      if pos('2f', str) <> 0 then
      begin
        insert('dtttttttttttt', str, pos('2f', str));
        Delete(str, pos('2f', str), 2);
      end
      else
      if pos('3f', str) <> 0 then
      begin
        insert('dtttttttttttttttttt', str, pos('3f', str));
        Delete(str, pos('3f', str), 2);
      end
      else
      if pos('4f', str) <> 0 then
      begin
        insert('dtttttttttttttttttttttttt', str, pos('4f', str));
        Delete(str, pos('4f', str), 2);
      end
      else
      if pos('5f', str) <> 0 then
      begin
        insert('dtttttttttttttttttttttttttttttt', str, pos('5f', str));
        Delete(str, pos('5f', str), 2);
      end
      else
      if pos('6f', str) <> 0 then
      begin
        insert('dtttttttttttttttttttttttttttttttttttt', str, pos('6f', str));
        Delete(str, pos('6f', str), 2);
      end
      else
      if pos('7f', str) <> 0 then
      begin
        insert('dtttttttttttttttttttttttttttttttttttttttttt', str, pos('7f', str));
        Delete(str, pos('7f', str), 2);
      end
      else
      if pos('8f', str) <> 0 then
      begin
        insert('dtttttttttttttttttttttttttttttttttttttttttttttttt', str, pos('8f', str));
        Delete(str, pos('8f', str), 2);
      end
      else
      if pos('9f', str) <> 0 then
      begin
        insert('dtttttttttttttttttttttttttttttttttttttttttttttttttttttt',
          str, pos('9f', str));
        Delete(str, pos('9f', str), 2);
      end
      else
      //erasing temporary symbol
      if pos('a', str) <> 0 then
        Delete(str, pos('a', str), 1)
      else
      if pos('b', str) <> 0 then
        Delete(str, pos('b', str), 1)
      else
      if pos('c', str) <> 0 then
        Delete(str, pos('c', str), 1)
      else
      if pos('d', str) <> 0 then
        Delete(str, pos('d', str), 1)
      else
      if pos('e', str) <> 0 then
        Delete(str, pos('e', str), 1)
      else
      if pos('f', str) <> 0 then
        Delete(str, pos('f', str), 1)
      else
      //compressing
      if pos('ttttttt', str) <> 0 then
        Delete(str, pos('ttttttt', str), 7)
      else
      //starting algorithm
      if pos('0', str) <> 0 then
      begin
        insert('x0', str, pos('0', str));
        Delete(str, pos('0', str), 1);
      end
      else
      if pos('1', str) <> 0 then
      begin
        insert('x1', str, pos('1', str));
        Delete(str, pos('1', str), 1);
      end
      else
      if pos('2', str) <> 0 then
      begin
        insert('x2', str, pos('2', str));
        Delete(str, pos('2', str), 1);
      end
      else
      if pos('3', str) <> 0 then
      begin
        insert('x3', str, pos('3', str));
        Delete(str, pos('3', str), 1);
      end
      else
      if pos('4', str) <> 0 then
      begin
        insert('x4', str, pos('4', str));
        Delete(str, pos('4', str), 1);
      end
      else
      if pos('5', str) <> 0 then
      begin
        insert('x5', str, pos('5', str));
        Delete(str, pos('5', str), 1);
      end
      else
      if pos('6', str) <> 0 then
      begin
        insert('x6', str, pos('6', str));
        Delete(str, pos('6', str), 1);
      end
      else
      if pos('7', str) <> 0 then
      begin
        insert('x7', str, pos('7', str));
        Delete(str, pos('7', str), 1);
      end
      else
      if pos('8', str) <> 0 then
      begin
        insert('x8', str, pos('8', str));
        Delete(str, pos('8', str), 1);
      end
      else
      if pos('9', str) <> 0 then
      begin
        insert('x9', str, pos('9', str));
        Delete(str, pos('9', str), 1);
      end

      else
        finished := True;
    end;
    writeln(str);
  end;
end.
