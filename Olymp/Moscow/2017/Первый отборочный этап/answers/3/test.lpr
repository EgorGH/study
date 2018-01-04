program test;

uses
  SysUtils,
  strutils,
  Math;

const
  MaxT = 1000;
  SECS_IN_MIN = 60;
  SECS_IN_HOUR = 60 * SECS_IN_MIN;
  SECS_IN_DAY = 24 * SECS_IN_HOUR;

type
  ttime = record
    h, m, s: longint;
  end;

var
  t: longint;
  a, b, c: ttime;

  operator = (a, b: ttime): boolean;
  begin
    exit((a.h = b.h) and (a.m = b.m) and (a.s = b.s));
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

  function add_second(time: ttime): ttime;
  begin
    time.s := (time.s + 1) mod 60;
    if time.s = 0 then
      time.m := (time.m + 1) mod 60;
    if (time.s = 0) and (time.m = 0) then
      time.h := (time.h + 1) mod 24;
    exit(time);
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

  function optimal_search(): ttime;
  var
    diff, seconds: longint;
  begin
    diff := (time2sec(c) - time2sec(a) + SECS_IN_DAY) mod SECS_IN_DAY;
    seconds := time2sec(b) + ceil(diff / 2);
    exit(sec2time(seconds));
  end;

  function process_test(): boolean;
  begin
    a := sec2time(random(SECS_IN_DAY) + 1);
    b := sec2time(random(SECS_IN_DAY) + 1);
    c := sec2time(random(SECS_IN_DAY) + 1);
    exit(full_search() = optimal_search());
  end;

begin
  randomize();

  for t := 1 to MaxT do
    if not process_test() then
      writeln('Error!');

  writeln('Done');
end.
