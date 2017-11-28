program test_slow;

uses
  SysUtils;

const
  MaxT = 3;

var
  m: array[1..9, 1..9] of byte;
  ans: array[1..MaxT] of longint;
  N, t: longint;

  procedure clear_m();
  var
    i, j: longint;
  begin
    for i := 1 to 9 do
      for j := 1 to 9 do
        m[i, j] := 0;
  end;

  procedure clear_ans();
  var
    i: longint;
  begin
    for i := 1 to MaxT do
      ans[i] := 0;
  end;

  procedure full_search(N: longint);
  var
    a, b, s: shortstring;
    MaxNum, i, j, p, start, fin, t, prev, d, q, k: longint;
    error: boolean;
  begin
    a := '';
    b := '';
    MaxNum := 2 * N + 1;
    for i := 1 to MaxNum do
    begin
      a := a + IntToStr(i);
      b := b + '9';
    end;

    start := StrToInt(a);
    fin := StrToInt(b);
    k := 0;

    for i := start to fin do
    begin
      error := False;

      if pos('0', IntToStr(i)) <> 0 then
        continue;

      s := IntToStr(i);
      for j := 1 to MaxNum - 1 do
        for p := j + 1 to MaxNum do
          if (s[j] = s[p]) or (StrToInt(s[j]) > MaxNum) or (StrToInt(s[p]) > MaxNum) then
            error := True;

      if error then
        continue;

      q := 0;
      t := i;
      prev := t mod 10;
      t := t div 10;
      while t <> 0 do
      begin
        d := t mod 10;
        if m[prev, d] = 0 then
          q := q + 1;
        prev := d;

        t := t div 10;

        if (t = 0) and (m[i mod 10, prev] = 0) then
          q := q + 1;
      end;

      if q = MaxNum then
      begin
        t := i;
        prev := t mod 10;
        t := t div 10;
        while t <> 0 do
        begin
          d := t mod 10;
          m[prev, d] := 1;
          m[d, prev] := 1;
          prev := d;

          t := t div 10;
        end;

        m[i mod 10, prev] := 1;
        m[prev, i mod 10] := 1;

        k := k + 1;
        ans[k] := i;
      end;
    end;
  end;

  function check(n: longint): boolean;
  var
    i, x, prev, d: longint;
  begin
    for i := 1 to n do
    begin
      x := ans[i];
      prev := x mod 10;
      x := x div 10;
      while x <> 0 do
      begin
        d := x mod 10;
        if m[prev, d] = 1 then
          exit(False);
        m[prev, d] := 1;
        m[d, prev] := 1;
        prev := d;

        x := x div 10;
      end;

      if m[ans[i] mod 10, prev] = 1 then
        exit(False);
      m[ans[i] mod 10, prev] := 1;
      m[prev, ans[i] mod 10] := 1;
    end;

    exit(True);
  end;


begin
  for t := 1 to MaxT do
  begin
    clear_m();
    clear_ans();

    N := t;
    full_search(N);

    clear_m();

    if not check(N) then
      writeln('Error');
  end;
  writeln('Done');
end.
