program answer;

uses
  SysUtils, strutils, math;

const
  SecsInMin = 60;
  SecsInHour = 60 * SecsInMin;
  SecsInDay = 24 * SecsInHour;

type
  ttime = record
    h, m, s: longint;
  end;

var
  a, b, c: ttime;

  procedure read_time(var time: ttime);
  var
    s: shortstring;
  begin
    readln(s);
    readstr(StringReplace(s, ':', ' ', [rfReplaceAll]), time.h, time.m, time.s);
  end;

  function time2sec(time: ttime): longint;
  begin
    exit(time.h * SecsInHour + time.m * SecsInMin + time.s);
  end;

  function sec2time(x: longint): ttime;
  begin
    sec2time.h := (x div SecsInHour) mod 24;
    x := x mod SecsInHour;
    sec2time.m := x div SecsInMin;
    x := x mod SecsInMin;
    sec2time.s := x;
  end;

  function time2str(time: ttime): shortstring;
  begin
    exit(format('%.2d:%.2d:%.2d', [time.h, time.m, time.s]));
  end;

  function optimal_search(): shortstring;
  var
    time: ttime;
    d, diff, time_sec: longint;
  begin
    d := time2sec(c) - time2sec(a);
    diff := IfThen(d > 0, d, d + SecsInDay);
    time_sec := time2sec(b) + diff div 2 + diff mod 2;
    time := sec2time(time_sec);
    exit(time2str(time));
  end;

begin
  read_time(a);
  read_time(b);
  read_time(c);

  writeln(optimal_search());
end.
