program answer_slow;

uses
  SysUtils, math;

var
  a, b, c: shortstring;
  ahour, bhour, chour, amin, bmin, cmin, asec, bsec, csec: shortstring;
  addhour, addmin, addsec: shortstring;

  procedure clean(var x: shortstring);
  begin
    if x[1] = '0' then
      delete(x, 1, 1);
  end;

begin
  readln(a);
  readln(b);
  readln(c);

  ahour := Copy(a, 1, 2);
  bhour := Copy(b, 1, 2);
  chour := Copy(c, 1, 2);
  amin := copy(a, 4, 2);
  bmin := copy(b, 4, 2);
  cmin := copy(c, 4, 2);
  asec := copy(a, 7, 2);
  bsec := copy(b, 7, 2);
  csec := copy(c, 7, 2);

  clean(ahour);
  clean(bhour);
  clean(chour);
  clean(amin);
  clean(bmin);
  clean(cmin);
  clean(asec);
  clean(bsec);
  clean(csec);



  if ahour = chour then
    if amin = cmin then
      addsec := IntToStr(ceil((StrToInt(csec) - StrToInt(asec)) / 2))
    else
      addsec := IntToStr(ceil((amin - cmin + 1 * 60) / 2));

  writeln(dsec);
  readln();
  {
15:01:00
18:09:45
15:01:40
}
end.
