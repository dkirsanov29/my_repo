PROGRAM Split(INPUT, OUTPUT);
VAR
  Ch, Next: CHAR;
  Odds, Evens: TEXT;
BEGIN
  {�������� ����������� ������������ ���������� Next, �������� ���(�� #) ������� �� INPUT}
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
          WRITELN('Next is ', Next, '; Ch = ', Ch);
          Next := 'E'
        END
      ELSE IF Next = 'E'
      THEN
        BEGIN
          WRITELN('Next is ', Next, '; Ch = ', Ch);
          Next := 'O'
        END;
      READ(Ch)    
    END;
  {���������� Odds � Output}
  {���������� Evens � Output}
END.
