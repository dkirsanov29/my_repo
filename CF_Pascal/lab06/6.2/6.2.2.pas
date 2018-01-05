PROGRAM Split(INPUT, OUTPUT);
VAR
  Ch, Next: CHAR;
  Odds, Evens: TEXT;
BEGIN
  {Разбить INPUT на Odds и Evens}
  Next := 'O';
  REWRITE(Odds);
  REWRITE(Evens);
  READ(INPUT, Ch);
  WHILE Ch <> '#'
  DO
    BEGIN
      IF Next = 'O'
      THEN
        BEGIN
          WRITE(Odds, Ch);
          Next := 'E'
        END
      ELSE IF Next = 'E'
      THEN
        BEGIN
          WRITE(Evens, Ch);
          Next := 'O'
        END;
      READ(Ch)    
    END;
  WRITE(Odds, '#');
  WRITE(Evens, '#');
  {Копировать Odds в Output}
  RESET(Odds);
  READ(Odds, Ch);
  WRITE('Odds contains: ');
  WHILE Ch <> '#'
  DO
    BEGIN
      WRITE(Ch);
      READ(Odds, Ch)
    END;
  {Копировать Evens в Output}
END.
