program test;

uses
  SysUtils;

const
  NMax = 100;

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

var
  N: longint;

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

  function optimal_search(N: longint): tseries;
  var
    i, SecretKeeper, Finder: longint;
  begin
    optimal_search.ser := GetMem((N + 2 * N * N) * sizeof(shortstring));

    i := 0;
    for SecretKeeper := 1 to N do
    begin
      optimal_search.ser[i] := print_episode(0, SecretKeeper, 0);
      i := i + 1;

      if SecretKeeper = N then
      begin
        optimal_search.ser[i] := print_episode(2, 1, SecretKeeper);
        i := i + 1;
        break;
      end;

      for Finder := 1 to N do
      begin
        if Finder = SecretKeeper then
        begin
          optimal_search.ser[i] := print_episode(2, Finder + 1, Finder);
          i := i + 1;
        end
        else if Finder = SecretKeeper + 1 then
        begin
          optimal_search.ser[i] := print_episode(1, SecretKeeper, Finder);
          i := i + 1;
        end
        else
        begin
          optimal_search.ser[i] := print_episode(2, Finder, SecretKeeper);
          i := i + 1;
          optimal_search.ser[i] := print_episode(1, Finder, SecretKeeper + 1);
          i := i + 1;
        end;
      end;
    end;
    optimal_search.size := i;
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
    if series.size <> (N + 2 * (N - 1) * (N - 1) + 1) then
      exit(False);

    Knowers := GetMem(N * sizeof(longint));
    NotKnowers := GetMem(N * sizeof(longint));

    SecretKeepers := 0;
    FillByte(Knowers[0], N * sizeof(longint), 0);
    FillByte(NotKnowers[0], N * sizeof(longint), 0);
    prev_ep := -1;

    for i := 0 to N - 1 do
    begin
      x := get_episode(series.ser[i]);
      x.a := x.a - 1;
      x.b := x.b - 1;

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
    if not check_consistency(N, optimal_search(N)) then
      writeln('Error!');
    FreeMem(optimal_search(N).ser);
  end;
  writeln('Done');
end.
