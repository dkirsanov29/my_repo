PROGRAM CopyOdds(INPUT, OUTPUT);
{Копирует через один символы из INPUT в OUTPUT,
но до тех пор, пока не встретится первое #.}
VAR
  Ch, Next: CHAR;
  {Next - это переключатель между нечетными (odd (O)) 
  и четными (even (E)}
BEGIN
  Next := 'O'; {odd}
  READ(Ch);
  WHILE Ch <> '#'
  DO
    BEGIN
      IF Next = 'O'
      THEN  {Копирование нечетных символов}
        WRITE(Ch);
      READ(Ch);
      {Переключение величины Next}
      IF Next = 'O'
      THEN
        Next := 'E'  {even}
      ELSE
        Next := 'O'  {odd}
    END;
  WRITELN
END.

