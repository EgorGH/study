program answer_simple;

uses
  SysUtils,
  strutils,
  Math;

type
  ttime = record
    h, m, s: longint;
  end;

var
  a, b, c: ttime;

  operator = (a, b: ttime): boolean;
  begin
    if (a.h = b.h) and (a.m = b.m) and (a.s = b.s) then
      exit(true);
    exit(false);
  end;

  procedure read_time(var time: ttime);
  var
    s: shortstring;
  begin
    readln(s);
    readstr(StringReplace(s, ':', ' ', [rfReplaceAll]), time.h, time.m, time.s);
  end;

  function add_second(time: ttime): ttime;
  begin
    time.s := (time.s + 1) mod 60;
    if time.s = 0 then
      time.m := (time.m + 1) mod 60;
    if (time.s = 0) and (time.m = 0) then
      time.h := (time.h + 1) mod 24;
    exit(time);
  end;

  function time2str(time: ttime): shortstring;
  begin
    exit(format('%.2d:%.2d:%.2d', [time.h, time.m, time.s]));
  end;

  function full_search(): ttime;
  var
    diff: longint;
  begin
    diff := 0;
    while c <> a do
    begin
      a := add_second(a);
      diff += 1;
    end;

    diff := ceil(diff / 2);

    while diff > 0 do
    begin
      b := add_second(b);
      diff -= 1;
    end;
    exit(b);
  end;

begin
  read_time(a);
  read_time(b);
  read_time(c);

  writeln(time2str(full_search()));
end.
