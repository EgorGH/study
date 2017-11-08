program test_slow;

uses
  SysUtils;

const
  NMax = 3;

type
  episode = record
    event: longint;
    a: longint;
    b: longint;
  end;

  tseries = record
    size: longint;
    ser: ^shortstring;
  end;

  ttseries = ^Episode;

var
  N, Lim: longint;
  SecretKeepers: longint;
  Knowers, NotKnowers: ^longint;
  Series, MaxSeries: ttseries;
  SeriesSize, MaxSeriesSize: longint;

  function print_episode(event, a, b: longint): shortstring;
  begin
    print_episode := 'Character ' + IntToStr(a) + ' finds out ';
    case event of
      0: print_episode := print_episode + 'the secret.';
      1: print_episode := print_episode + 'that character ' +
          IntToStr(b) + ' does not know the secret.';
      2: print_episode := print_episode + 'that character ' + IntToStr(b) +
          ' knows the secret.';
    end;
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

  function full_search(N: longint): tseries;
  var
    i: longint;
  begin
    full_search.ser := GetMem((N + 2 * N * N) * sizeof(shortstring));

    fill_series();

    full_search.size := MaxSeriesSize;
    for i := 0 to MaxSeriesSize - 1 do
      full_search.ser[i] := print_episode(MaxSeries[i].event,
        MaxSeries[i].a, MaxSeries[i].b);
  end;

  function get_episode(serie: shortstring): Episode;
  begin
    get_episode.a := StrToInt(copy(serie, pos(' ', serie) + 1,
      pos('f', serie) - pos(' ', serie) - 2));

    if pos('k', serie) = 0 then
    begin
      get_episode.event := 0;
      get_episode.b := 0;
    end
    else if pos('not', serie) <> 0 then
    begin
      get_episode.event := 1;
      get_episode.b := StrToInt(copy(serie, pos('that', serie) + 14,
        pos('does', serie) - pos('that', serie) - 15));
    end
    else
    begin
      get_episode.event := 2;
      get_episode.b := StrToInt(copy(serie, pos('that', serie) + 14,
        pos('knows', serie) - pos('that', serie) - 15));
    end;
  end;

  function check_consistency(N: longint; series: tseries): boolean;
  var
    i, prev_ep: longint;
    SecretKeepers: longint;
    Knowers, NotKnowers: ^longint;
    x: episode;
  begin
    if (N = 1) and (series.size <> 1) or (N <> 1) and
      (series.size <> (N + 2 * (N - 1) * (N - 1) + 1)) then
      exit(False);

    Knowers := GetMem(N * sizeof(longint));
    NotKnowers := GetMem(N * sizeof(longint));

    SecretKeepers := 0;
    FillByte(Knowers[0], N * sizeof(longint), 0);
    FillByte(NotKnowers[0], N * sizeof(longint), 0);
    prev_ep := -1;

    for i := 0 to series.size - 1 do
    begin
      x := get_episode(series.ser[i]);

      if (x.event = 0) and (prev_ep <> 0) then
      begin
        SecretKeepers := SecretKeepers or (1 shl x.a);
        prev_ep := 0;
      end
      else
      if (x.event = 1) and (prev_ep <> 1) and (SecretKeepers and (1 shl x.b) = 0) and
        (NotKnowers[x.a] and (1 shl x.b) = 0) then
      begin
        NotKnowers[x.a] := NotKnowers[x.a] or (1 shl x.b);
        prev_ep := 1;
      end
      else
      if (x.event = 2) and (prev_ep <> 2) and (SecretKeepers and (1 shl x.b) <> 0) and
        (Knowers[x.a] and (1 shl x.b) = 0) then
      begin
        Knowers[x.a] := Knowers[x.a] or (1 shl x.b);
        prev_ep := 2;
      end
      else
      begin
        FreeMem(Knowers);
        FreeMem(NotKnowers);
        exit(False);
      end;
    end;

    FreeMem(Knowers);
    FreeMem(NotKnowers);

    exit(True);
  end;

begin
  for N := 1 to NMax do
  begin
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

    if not check_consistency(N, full_search(N)) then
      writeln('Error!');

    FreeMem(full_search(N).ser);
    FreeMem(Knowers);
    FreeMem(NotKnowers);
    FreeMem(Series);
    FreeMem(MaxSeries);
  end;
  writeln('Done');
end.
