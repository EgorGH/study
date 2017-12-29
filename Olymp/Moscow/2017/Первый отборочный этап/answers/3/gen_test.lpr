program gen_test;

uses
  SysUtils,
  strutils,
  Math;

const
  SecsInMin = 60;
  SecsInHour = 60 * SecsInMin;
  SecsInDay = 24 * SecsInHour;

type
  ttime = record
    h, m, s: longint;
  end;

var
  t: longint;
  a, b, c: ttime;

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

    writeln(afile, optimal_search());

    Close(infile);
    Close(afile);
  end;

  procedure process_test(t: longint);
  begin
    a := sec2time(random(SecsInDay) + 1);
    b := sec2time(random(SecsInDay) + 1);
    c := sec2time(random(SecsInDay) + 1);
    write_test(t);
  end;

begin
  randomize();

  for t := 10 to 20 do
    process_test(t);

  writeln('Done');
end.
