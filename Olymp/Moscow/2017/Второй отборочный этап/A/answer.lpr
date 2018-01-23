program answer;

uses
  SysUtils;

var
  n, i, x: longint;
  is_available: array[0..99] of boolean;

  procedure prepare_data();
  var
    i, j: longint;
  begin
    for i := 0 to 9 do
      is_available[i] := True;
    for i := 10 to 99 do
      for j := 2 to 9 do
        if (i mod j = 0) and (i div j < 10) then
        begin
          is_available[i] := True;
          break;
        end;
  end;

  function Str2Int(s: shortstring; a, b: longint): longint;
  begin
    s := copy(s, a, b);
    if (length(s) > 1) and (s[1] = '0') then
      exit(11)
    else
      exit(StrToInt(s));
  end;

  function optimal_search(x: longint): boolean;
  var
    xstr: shortstring;
    d1, d2, d3, d4, d5, d1_2, d2_2, d3_2, d4_2, d5_2: longint;
  begin
    if x < 1000 then
      exit(True);
    if x > 818181 then
      exit(False);

    xstr := IntToStr(x);
    d1 := Str2Int(xstr, 1, 1);
    d2 := Str2Int(xstr, 2, 1);
    d3 := Str2Int(xstr, 3, 1);
    d4 := Str2Int(xstr, 4, 1);
    d1_2 := Str2Int(xstr, 1, 2);
    d2_2 := Str2Int(xstr, 2, 2);
    d3_2 := Str2Int(xstr, 3, 2);

    if x < 10000 then
    begin
      if is_available[d1_2] and is_available[d3_2] then
        exit(True);
      if is_available[d1_2] and is_available[d3] and is_available[d4] then
        exit(True);
      if is_available[d2_2] and is_available[d1] and is_available[d4] then
        exit(True);
      if is_available[d3_2] and is_available[d1] and is_available[d2] then
        exit(True);
      exit(False);
    end;

    d5 := Str2Int(xstr, 5, 1);
    d4_2 := Str2Int(xstr, 4, 2);
    if x < 100000 then
    begin
      if is_available[d1_2] and is_available[d3_2] and is_available[d5] then
        exit(True);
      if is_available[d1] and is_available[d2_2] and is_available[d4_2] then
        exit(True);
      if is_available[d1_2] and is_available[d3] and is_available[d4_2] then
        exit(True);
      exit(False);
    end;

    d5_2 := Str2Int(xstr, 5, 2);
    if is_available[d1_2] and is_available[d3_2] and is_available[d5_2] then
      exit(True);
    exit(False);
  end;

begin
  //Assign(input, '02.');
  //reset(input);
  //Assign(output, '02.a');
  //rewrite(output);

  prepare_data();
  readln(n);
  for i := 1 to n do
  begin
    readln(x);
    if not optimal_search(x) then
      writeln('NO')
    else
      writeln('YES');
  end;
end.
