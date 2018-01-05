PROGRAM What(INPUT, OUTPUT);
VAR
  Ch: CHAR;
BEGIN
  READ(Ch);
  WRITELN('Symbol: ', Ch, ' is between ''0'' and ''9''?');
  IF '0' <= Ch
  THEN
    BEGIN
      IF Ch <= '9'
      THEN
        WRITELN('YES')
      ELSE
        WRITELN('No')
    END
  ELSE
    WRITELN('No')
END.
