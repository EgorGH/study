program gen_test;

uses
  Math,
  fgl,
  SysUtils,
  strutils;

const
  SLim = 10000;
  TLim = 1000;
  ordA = 65;
  ordz = 122;

var
  avail: array[ordA..ordz, 1..SLim] of byte;
  Next: array[ordA..ordz, 1..SLim] of smallint;
  exist: array[1..TLim] of smallint;
  removed, minremoved: array[1..SLim] of byte;
  test, qremoved, minqremoved: smallint;
  s, t: ansistring;

  procedure optimal_search(snum, tnum: longint);
  var
    i, p, nextp, code, nextcode: smallint;
  begin
    code := Ord(t[tnum]);
    p := Next[code, snum];
    snum := p;
    while tnum <= length(t) do
    begin
      if minqremoved <= qremoved + 1 then
        exit();

      if tnum < length(t) then
      begin
        nextcode := Ord(t[tnum + 1]);
        nextp := Next[nextcode, snum + 1];
      end
      else
        nextp := snum + 1;

      for i := snum to nextp - 1 do
        if avail[code, i] = 1 then
        begin
          removed[i] := 1;
          qremoved += 1;
        end;


      if exist[tnum] >= nextp then
        optimal_search(nextp, tnum)
      else if qremoved < minqremoved then
      begin
        minqremoved := qremoved;
        minremoved := removed;
      end;

      for i := snum to nextp - 1 do
        if avail[code, i] = 1 then
        begin
          removed[i] := 0;
          qremoved -= 1;
        end;

      code := nextcode;
      p := nextp;
      snum := p;
      tnum += 1;
    end;
  end;

  procedure prepare();
  var
    i, j, p: smallint;
  begin
    minqremoved := smallint.MaxValue;
    FillByte(minremoved[1], SLim, 0);

    qremoved := 0;
    FillByte(removed[1], SLim, 0);

    for i := ordA to ordz do
      FillByte(avail[i, 1], SLim, 0);
    for i := 1 to length(s) do
      avail[Ord(s[i]), i] := 1;

    for i := ordA to ordz do
    begin
      p := 0;
      for j := length(s) downto 1 do
      begin
        if avail[i, j] = 1 then
          p := j;
        Next[i, j] := p;
      end;
    end;

    FillByte(exist[1], TLim, 0);
    for i := length(t) downto 1 do
      for j := length(s) - length(t) + i downto 1 do
        if (avail[Ord(t[i]), j] > 0) and ((i = length(t)) or (exist[i + 1] > j)) then
        begin
          exist[i] := j;
          break;
        end;
  end;

  procedure write_test(test: longint; var ans: ansistring);
  var
    infile, afile: Text;
  begin
    Assign(infile, format('tests\%.2d.', [test]));
    Assign(afile, format('tests\%.2d.a', [test]));
    Rewrite(infile);
    Rewrite(afile);
    writeln(infile, s);
    writeln(infile, t);
    writeln(afile, ans);
    Close(infile);
    Close(afile);
  end;

  procedure process_test(test, smax, tmax, cmax: longint);
  var
    i: longint;
    ans: ansistring = '';
  begin
    SetLength(s, smax);
    for i := 1 to smax do
      s[i] := char(random(cmax) + Ord('A'));

    tmax := min(length(s), random(tmax) + 1);
    SetLength(t, tmax);
    for i := 1 to tmax do
      t[i] := char(random(cmax) + Ord('A'));

    prepare();
    if exist[1] > 0 then
      optimal_search(1, 1);


    for i := 1 to length(s) do
      if minremoved[i] = 0 then
        ans += s[i];

    write_test(test, ans);
  end;

begin
  randomize();
  for test := 2 to 9 do
    process_test(test, 10, 3, 2);

  for test := 10 to 19 do
    process_test(test, 15, 15, 52);

  for test := 20 to 29 do
    process_test(test, 100, 52, 52);

  for test := 30 to 39 do
    process_test(test, 500, 500, 52);

  //for test := 40 to 49 do
  //  process_test(test, 4000, 400, 52);

  writeln('done!');
end.
