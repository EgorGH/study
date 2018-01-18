program test;

uses
  SysUtils,
  Math;

const
  MaxT = 1000;

var
  n, m, t, tt, k, i, j, a, b: longint;
  serA1, serB1: array[0..1000] of byte;
  serA2, serB2: longint;
  ta, tb: longint;

  procedure full_search();
  var
    i: longint;
    chan: byte = 0;
    flag: boolean;
  begin
    for i := 0 to t - 1 do
    begin
      if (chan = 0) and (serA1[i] = 0) then
      begin
        flag := False;
        ta += 1;
      end
      else
      if (chan = 0) and (serA1[i] = 1) and not flag then
      begin
        chan := 1;
        if serB1[i] = 0 then
          tb += 1
        else
          flag := True;
      end

      else
      if (chan = 1) and (serB1[i] = 0) then
      begin
        flag := False;
        tb += 1;
      end
      else
      if (chan = 1) and (serB1[i] = 1) and not flag then
      begin
        chan := 0;
        if serA1[i] = 0 then
          ta += 1
        else
          flag := True;
      end;
    end;
  end;

  procedure optimal_search();
  var
    i: longint;
    chan: byte = 0;
    flag: boolean;
  begin
    for i := 0 to t - 1 do
    begin
      if (chan = 0) and (serA2 mod 2 = 0) then
      begin
        flag := False;
        ta += 1;
      end
      else
      if (chan = 0) and (serA2 mod 2 = 1) and not flag then
      begin
        chan := 1;
        if serB2 mod 2 = 0 then
          tb += 1
        else
          flag := True;
      end

      else
      if (chan = 1) and (serB2 mod 2 = 0) then
      begin
        flag := False;
        tb += 1;
      end
      else
      if (chan = 1) and (serB2 mod 2 = 1) and not flag then
      begin
        chan := 0;
        if serA2 mod 2 = 0 then
          ta += 1
        else
          flag := True;
      end;

      serA2 := serA2 div 2;
      serB2 := serB2 div 2;
    end;
  end;

  function process_test(maxn, maxm, maxt, maxk: longint): boolean;
  var
    i, j, a, b, c, d: longint;
  begin
    n := random(maxn) + 1;
    m := random(maxm) + 1;
    t := random(maxt) + 1;
    k := random(maxk) + 1;

    for i := 0 to n - 1 do
    begin
      a := random(t) + 1;
      for j := a to a + k - 1 do
      if j < t then
      begin
        serA1[j] := 1;
        serA2 := serA2 or (1 shl j);
      end;
    end;

    for i := 0 to m - 1 do
    begin
      b := random(t) + 1;
      for j := b to b + k - 1 do
      if j < t then
      begin
        serB1[j] := 1;
        serB2 := serB2 or (1 shl j);
      end;
    end;

    ta := 0;
    tb := 0;
    full_search();
    a := ta;
    b := tb;
    ta := 0;
    tb := 0;
    optimal_search();
    c := ta;
    d := tb;
    if (a <> c) and (b <> d) then
      a := a;
    exit((a = c) and (b = d));
  end;

begin
  randomize();

  for tt := 1 to MaxT do
    if not process_test(10, 10, 10, 10) then
      writeln('err');

  writeln('Done');
end.
