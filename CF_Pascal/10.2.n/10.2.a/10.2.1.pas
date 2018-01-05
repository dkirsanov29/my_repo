PROGRAM CorrectingLine(INPUT, OUTPUT);
TYPE PerfomanceConditions = (IsNotBegin, IsBegin, IsEnd);
VAR
  PerfomanceCondition: PerfomanceConditions;    
  W1, W2, W3, W4, W5, W6, W7: CHAR;
BEGIN
  W1 := ' '; W2 := ' '; W3 := ' '; W4 := ' '; W5 := ' '; W6 := ' '; W7 := ' ';
  PerfomanceCondition := IsNotBegin;
  WHILE PerfomanceCondition <> IsBegin
  DO
    BEGIN
      W1 := W2; W2 := W3; W3 := W4; W4 := W5; W5 := W6; W6 := W7;
      READ(W7);
      IF (PerfomanceCondition = IsNotBegin) AND (W1 = ' ') AND (W2 = 'B') AND (W3 = 'E') AND (W4 = 'G') AND (W5 = 'I') AND (W6 = 'N') AND ((W7 = ' ') OR (W7 = ';'))
      THEN
        PerfomanceCondition := IsBegin   
    END;
  IF PerfomanceCondition = IsBegin
  THEN
    WRITELN(W2, W3, W4, W5, W6);
  IF W7 = ';' THEN WRITELN('  ', W7)
END.
