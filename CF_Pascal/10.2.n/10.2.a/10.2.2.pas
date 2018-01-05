PROGRAM CorrectingLine(INPUT, OUTPUT);
TYPE PerfomanceConditions = (IsNotBegin, IsBegin, IsEnd);
TYPE PrevSigns = (None, IsSemicolon, IsGap);
VAR
  PerfomanceCondition: PerfomanceConditions;    
  PrevSign: PrevSigns;
  W1, W2, W3, W4, W5, W6, W7, W8, W9, W10: CHAR;
BEGIN
  W1 := ' '; W2 := ' '; W3 := ' '; W4 := ' ';
  W5 := ' '; W6 := ' '; W7 := ' '; W8 := ' ';
  W9 := ' '; W10 := ' ';
  PerfomanceCondition := IsBegin;
  PrevSign := None;
  //WHILE NOT EOLN
  WHILE PerfomanceCondition <> IsEnd
  DO
    BEGIN
      READ(W7);
      IF W7 = ' ' THEN BEGIN {} END ELSE
      IF W7 = ';' THEN BEGIN WRITELN('  ', W7) END ELSE
      BEGIN 
        WRITE('  ', W7);
        WHILE PrevSign = None
        DO
          BEGIN
            READ(W7);
            IF W7 = ' ' THEN PrevSign := IsGap ELSE
            IF W7 = ';' THEN PrevSign := IsSemicolon;
            IF PrevSign = None THEN WRITE(W7)  
          END;
        IF PrevSign = IsGap THEN BEGIN WRITELN; PrevSign := None END;
        IF PrevSign = IsSemicolon THEN BEGIN WRITELN(W7); PrevSign := None END;  
      END      
    END {WHILE PerfomanceCondition <> IsEnd}
END.
