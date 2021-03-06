program gen_test;

uses
  SysUtils,
  strutils,
  Math;

const
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

  procedure write_test(test: longint);
  var
    infile, afile: Text;
  begin
    Assign(infile, format('tests/%.2d.', [test]));
    Assign(afile, format('tests/%.2d.a', [test]));
    rewrite(infile);
    rewrite(afile);

    writeln(infile, time2str(a));
    writeln(infile, time2str(b));
    writeln(infile, time2str(c));

    writeln(afile, time2str(optimal_search()));

    Close(infile);
    Close(afile);
  end;

  procedure process_test(t: longint);
  begin
    a := sec2time(random(SECS_IN_DAY) + 1);
    b := sec2time(random(SECS_IN_DAY) + 1);
    c := sec2time(random(SECS_IN_DAY) + 1);
    write_test(t);
  end;

begin
  randomize();

  for t := 10 to 20 do
    process_test(t);

  writeln('Done');
end.
