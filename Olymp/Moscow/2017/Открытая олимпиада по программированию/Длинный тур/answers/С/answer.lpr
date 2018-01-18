program answer;

uses
  SysUtils;

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
  cache: array[1..SLim, 1..TLim] of smallint;
  i, qremoved, minqremoved: smallint;
  s, t: ansistring;

  procedure optimal_search(snum, tnum: longint); forward;

  procedure optimal_search_cached(snum, tnum: longint);
  var
    qcached: smallint;
  begin
    qcached := cache[snum, tnum];
    if (qcached = 0) or (qcached > qremoved) then
    begin
      cache[snum, tnum] := qremoved;
      optimal_search(snum, tnum);
    end;
  end;

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
        optimal_search_cached(nextp, tnum)
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
    qremoved := 0;

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

    for i := length(t) downto 1 do
      for j := length(s) - length(t) + i downto 1 do
        if (avail[Ord(t[i]), j] > 0) and ((i = length(t)) or (exist[i + 1] > j)) then
        begin
          exist[i] := j;
          break;
        end;
  end;

begin
  readln(s);
  readln(t);

  prepare();
  if exist[1] > 0 then
    optimal_search(1, 1);

  for i := 1 to length(s) do
    if minremoved[i] = 0 then
      Write(s[i]);
end.
