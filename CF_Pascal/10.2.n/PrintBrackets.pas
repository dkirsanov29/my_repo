PROGRAM PrintBrackets(INPUT, OUTPUT);
TYPE BracketsReadingConditions = (NoneReading, LeftBracketReading, StrOfSimbolsReading, RightBracketReading);
VAR
  W1, W2, W3, W4, W5, W6, W7: CHAR;
  BracketsReadingCondition: BracketsReadingConditions;  
BEGIN
  BracketsReadingCondition := NoneReading;
  READ(W7);
  IF W7 = '('
  THEN
    BEGIN
      W1 := W2; W2 := W3; W3 := W4; W4 := W5; W5 := W6; W6 := W7; 
      WRITE(W7);
      BracketsReadingCondition := LeftBracketReading;
      WHILE BracketsReadingCondition <> RightBracketReading
      DO
        BEGIN
          READ(W7);
          IF (BracketsReadingCondition = LeftBracketReading) AND (W7 = ')')
          THEN
            BracketsReadingCondition := RightBracketReading
          ELSE
            IF (BracketsReadingCondition = LeftBracketReading) AND (W7 = ' ')
            THEN
              {}
            ELSE
              IF (BracketsReadingCondition = LeftBracketReading) AND (W7 = ',')
              THEN
                BEGIN
                  W1 := W2; W2 := W3; W3 := W4; W4 := W5; W5 := W6; W6 := W7; 
                  W1 := W2; W2 := W3; W3 := W4; W4 := W5; W5 := W6; W6 := ' '; 
                  WRITE(W7, ' ')
                END  
              ELSE
                IF (BracketsReadingCondition = LeftBracketReading) AND (W7 = '''')
                THEN
                  BEGIN
                    W1 := W2; W2 := W3; W3 := W4; W4 := W5; W5 := W6; W6 := W7; 
                    WRITE(W7);
                    BracketsReadingCondition := StrOfSimbolsReading
                  END
                ELSE
                  IF BracketsReadingCondition = LeftBracketReading
                  THEN
                    BEGIN
                      W1 := W2; W2 := W3; W3 := W4; W4 := W5; W5 := W6; W6 := W7; 
                      WRITE(W7)
                    END  
                  ELSE
                    IF (BracketsReadingCondition = StrOfSimbolsReading) AND (W7 = '''')
                    THEN    
                      BEGIN
                        W1 := W2; W2 := W3; W3 := W4; W4 := W5; W5 := W6; W6 := W7; 
                        WRITE(W7);
                        BracketsReadingCondition := LeftBracketReading
                      END
                    ELSE
                      IF (BracketsReadingCondition = StrOfSimbolsReading)
                      THEN
                        BEGIN
                          W1 := W2; W2 := W3; W3 := W4; W4 := W5; W5 := W6; W6 := W7; 
                          WRITE(W7)
                        END           
        END;            
      W1 := W2; W2 := W3; W3 := W4; W4 := W5; W5 := W6; W6 := W7; 
      WRITE(W7);
      BracketsReadingCondition := NoneReading
    END;
    IF BracketsReadingCondition = NoneReading
    THEN
      BEGIN
        WRITELN;
        WRITELN('BracketsReadingCondition = NoneReading')
      END    
END.
