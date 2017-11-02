program answer_slow;

type
  Episode = record
    event: longint;
    a: longint;
    b: longint;
  end;
  tseries = ^Episode;

var
  N, Lim: longint;
  SecretKeepers: longint;
  Knowers, NotKnowers: ^longint;
  Series, MaxSeries: tseries;
  SeriesSize, MaxSeriesSize: longint;

  procedure print_series(series: tseries; seriesSize: longint);
  var
    i: longint;
  begin
    for i := 0 to seriesSize - 1 do
    begin
      Write('Character ', series[i].a + 1, ' finds out ');
      case series[i].event of
        0: Write('the secret.');
        1: Write('that character ', series[i].b + 1, ' does not know the secret.');
        2: Write('that character ', series[i].b + 1, ' knows the secret.');
      end;
      writeln();
    end;
    writeln('The end. No secret now!');
  end;

  procedure fill_series();
  forward;

  procedure fill_series(event, a, b: longint);
  begin
    Series[SeriesSize].event := event;
    Series[SeriesSize].a := a;
    Series[SeriesSize].b := b;
    SeriesSize := SeriesSize + 1;
    fill_series();
    SeriesSize := SeriesSize - 1;
  end;

  procedure fill_series();
  var
    i, a, b: longint;
  begin
    if SeriesSize > MaxSeriesSize then
    begin
      MaxSeriesSize := SeriesSize;
      for i := 0 to MaxSeriesSize - 1 do
        MaxSeries[i] := Series[i];
    end;

    if Series[SeriesSize - 1].event <> 0 then
      for a := 0 to N - 1 do
        if SecretKeepers and (1 shl a) = 0 then
        begin
          SecretKeepers := SecretKeepers or (1 shl a);
          fill_series(0, a, 0);
          SecretKeepers := SecretKeepers and not (1 shl a);
        end;

    if Series[SeriesSize - 1].event <> 1 then
      for a := 0 to N - 1 do
        for b := 0 to N - 1 do
          if (a <> b) and (SecretKeepers and (1 shl b) = 0) and
            (NotKnowers[a] and (1 shl b) = 0) then
          begin
            NotKnowers[a] := NotKnowers[a] or (1 shl b);
            fill_series(1, a, b);
            NotKnowers[a] := NotKnowers[a] and not (1 shl b);
          end;

    if Series[SeriesSize - 1].event <> 2 then
      for a := 0 to N - 1 do
        for b := 0 to N - 1 do
          if (a <> b) and (SecretKeepers and (1 shl b) <> 0) and
            (Knowers[a] and (1 shl b) = 0) then
          begin
            Knowers[a] := Knowers[a] or (1 shl b);
            fill_series(2, a, b);
            Knowers[a] := Knowers[a] and not (1 shl b);
          end;
  end;

begin
  readln(N);
  Lim := N + 2 * N * N;

  Knowers := GetMem(N * sizeof(longint));
  NotKnowers := GetMem(N * sizeof(longint));
  Series := GetMem(Lim * sizeof(Episode));
  MaxSeries := GetMem(Lim * sizeof(Episode));

  SecretKeepers := 1;
  FillByte(Knowers[0], N * sizeof(longint), 0);
  FillByte(NotKnowers[0], N * sizeof(longint), 0);

  Series[0].event := 0;
  Series[0].a := 0;
  SeriesSize := 1;

  fill_series();
  print_series(MaxSeries, MaxSeriesSize);
  readln();
end.
