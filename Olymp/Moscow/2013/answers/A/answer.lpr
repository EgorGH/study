program answer;

const
  Lim = 1000;

var
  i, j, N, k: integer;
  w: array[1..Lim] of string;
  T: array[0..25, 0..25] of boolean;
  S: array[0..25] of char;

  procedure f(a, b, c: integer);
  var
    i, x, y: integer;
    let1, let2: char;
  begin
    if a >= b then
    begin
      writeln('All words checked');
      exit();
    end;

    i := a;

    while w[i][c] = w[i + 1][c] do
    begin
      i := i + 1;
    end;

    if i <> a then
    begin
      y := i;
      f(a, y, c + 1);
    end;

    if i = a then
    begin
      let1 := w[i][c];
      let2 := w[i + 1][c];
      T[Ord(let1) - 97, Ord(let2) - 97] := True;

      x := a + 1;
      y := b;
      f(x, y, c);
    end;

  end;

begin
  for i := 0 to 25 do
    s[i] := chr(i + 97);

  for i := 0 to 25 do
    for j := 0 to 25 do
      T[i, j] := False;


  readln(N);

  for i := 1 to N do
    readln(w[i]);

  w[N + 1] := '!';

  f(1, N, 1);

  for i := 0 to 25 do
    for j := 1 to 25 do
      if T[i, j] = True then
      begin
        writeln(i, ' ', j);
        k := 25;
        while (k >= j) and (k > 0) do
          k := k - 1;
        S[i] := chr(k + 97);
        S[k] := chr(i + 97);
        //T[] := False;
      end;

  for i := 0 to 25 do
    Write(chr(i + 97), ' ');
  writeln();
  for i := 0 to 25 do
    Write(s[i], ' ');

  readln();
end.
