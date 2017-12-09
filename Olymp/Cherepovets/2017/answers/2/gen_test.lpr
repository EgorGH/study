program gen_test;

uses
  SysUtils;

const
  Lim = 1000000;

var
  src, dst: array[0..Lim] of byte;
  src_size, dst_size: longint;
  i, k, t: longint;

  procedure write_test(t: longint);
  var
    infile, afile: Text;
  begin
    Assign(infile, format('tests/%.2d.in', [t]));
    Assign(afile, format('tests/%.2d.a', [t]));
    Rewrite(infile);
    Rewrite(afile);

    for i := 0 to src_size - 1 do
      Write(infile, src[i]);
    writeln(infile);
    writeln(infile, k);

    for i := 0 to dst_size - 1 do
      Write(afile, dst[i]);
    Writeln(afile);

    Close(infile);
    Close(afile);
  end;

  procedure optimal_search(k, start: longint);
  var
    i, imax: longint;
    dmax, d: byte;
    found: boolean = False;
  begin
    if k = src_size - start then
      exit();

    if k = 0 then
    begin
      for i := 0 to src_size - start - 1 do
        dst[dst_size + i] := src[start + i];
      dst_size += src_size - start;
      exit();
    end;

    for i := start to start + k do
    begin
      d := src[i];

      if not found or (d > dmax) then
      begin
        found := True;
        dmax := d;
        imax := i;
      end;

      if d = 9 then
        break;
    end;

    dst[dst_size] := dmax;
    dst_size += 1;
    optimal_search(k - imax + start, imax + 1);
  end;

begin
  randomize();

  for t := 1 to 9 do
  begin
    src_size := random(5) + 2;
    k := random(src_size - 1) + 1;

    src[0] := random(9) + 1;
    for i := 1 to src_size - 1 do
      src[i] := random(10);

    dst_size := 0;
    optimal_search(k, 0);

    write_test(t);
  end;

  for t := 10 to 19 do
  begin
    src_size := 20;
    k := random(src_size - 1) + 1;

    src[0] := random(9) + 1;
    for i := 1 to src_size - 1 do
      src[i] := random(10);

    dst_size := 0;
    optimal_search(k, 0);

    write_test(t);
  end;

  for t := 20 to 22 do
  begin
    src_size := 254;
    k := random(src_size - 1) + 1;

    src[0] := random(9) + 1;
    for i := 1 to src_size - 1 do
      src[i] := random(10);

    dst_size := 0;
    optimal_search(k, 0);

    write_test(t);
  end;

  for t := 30 to 32 do
  begin
    src_size := Lim;
    k := random(src_size);

    src[0] := random(9) + 1;
    for i := 1 to src_size - 1 do
      src[i] := random(10);

    dst_size := 0;
    optimal_search(k, 0);

    write_test(t);
  end;

  writeln('Done');
end.
