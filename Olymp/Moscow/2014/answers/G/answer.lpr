program answer;

uses
  SysUtils,
  strutils;

const
  Lim = 200;

var
  samples, replacements, Data: array[1..Lim] of shortstring;
  i, dsize, psize: longint;

  procedure read_data(fname: shortstring; is_program: boolean);
  var
    f: Text;
    p: longint;
    s: shortstring;
  begin
    Assign(f, fname);
    reset(f);

    while not EOF(f) do
    begin
      readln(f, s);

      if s[1] = '#' then
        continue;

      if is_program then
      begin
        psize += 1;
        p := pos('->', s);
        samples[psize] := trim(copy(s, 1, p - 1));
        replacements[psize] := trim(copy(s, p + 2, length(s)));
      end;

      if not is_program then
      begin
        dsize += 1;
        Data[dsize] := trim(s);
      end;
    end;

    Close(f);
  end;

  function process(s: ansistring): ansistring;
  var
    i: longint;
    prev: ansistring;
  begin
    repeat
      prev := s;
      for i := 1 to psize do
        if pos(samples[i], s) <> 0 then
        begin
          s := StringReplace(s, samples[i], replacements[i], []);
          break;
        end;
    until prev = s;
    exit(s);
  end;

begin
  read_data(ParamStr(1), True);
  read_data(ParamStr(2), False);
  for i := 1 to dsize do
    writeln(process(Data[i]));
end.
