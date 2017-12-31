program answer;

uses
  SysUtils, strutils, math;

const
  SECS_IN_MIN = 60;
  SECS_IN_HOUR = 60 * SECS_IN_MIN;
  SECS_IN_DAY = 24 * SECS_IN_HOUR;

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
    exit(time.h * SECS_IN_HOUR + time.m * SECS_IN_MIN + time.s);
  end;

  function sec2time(x: longint): ttime;
  begin
    sec2time.h := (x div SECS_IN_HOUR) mod 24;
    x := x mod SECS_IN_HOUR;
    sec2time.m := x div SECS_IN_MIN;
    x := x mod SECS_IN_MIN;
    sec2time.s := x;
  end;

  function time2str(time: ttime): shortstring;
  begin
    exit(format('%.2d:%.2d:%.2d', [time.h, time.m, time.s]));
  end;

  function optimal_search(): ttime;
  var
    diff, seconds: longint;
  begin
    diff := (time2sec(c) - time2sec(a) + SECS_IN_DAY) mod SECS_IN_DAY;
    seconds := time2sec(b) + ceil(diff / 2);
    exit(sec2time(seconds));
  end;

begin
  read_time(a);
  read_time(b);
  read_time(c);

  writeln(time2str(optimal_search()));
end.
