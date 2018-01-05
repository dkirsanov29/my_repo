PROGRAM DeleteExtraGaps(INPUT, OUTPUT);
VAR
  Ch, StartOfLine, IsGap: CHAR;
BEGIN
  IsGap := 'F';
  StartOfLine := 'T';
  IF EOLN(INPUT)
  THEN
    WRITELN;
  WHILE (NOT EOLN(INPUT))
  DO
    BEGIN
      READ(Ch);
      IF (StartOfLine = 'T') AND (Ch <> ' ')
      THEN
        BEGIN
          WRITE(Ch);
          StartOfLine := 'F'
        END  
      ELSE
        IF (StartOfLine = 'F') AND (Ch = ' ') AND (IsGap = 'F')
        THEN
          IsGap := 'T'
        ELSE
          IF (StartOfLine = 'F') AND (Ch <> ' ') AND (IsGap = 'T')
          THEN      
            BEGIN
              WRITE(' ', Ch);
              IsGap := 'F'
            END
          ELSE
            IF (StartOfLine = 'F') AND (Ch <> ' ') AND (IsGap = 'F')
            THEN      
              WRITE(Ch)
    END
END.
