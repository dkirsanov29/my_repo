PROGRAM CorrectingLine(INPUT, OUTPUT);
TYPE PerfomanceConditions = (IsNotBegin, IsBegin, IsEnd);
TYPE PrevSigns = (None, IsSemicolon, IsGap, IsDot);
TYPE BracketsReadingConditions = (NoneReading, LeftBracketReading, StrOfSimbolsReading, RightBracketReading);
VAR
  BracketsReadingCondition: BracketsReadingConditions;
  PerfomanceCondition: PerfomanceConditions;    
  PrevSign: PrevSigns;
  W1, W2, W3, W4, W5, W6, W7, W8, W9, W10: CHAR;
BEGIN
  W1 := ' '; W2 := ' '; W3 := ' '; W4 := ' '; W5 := ' '; W6 := ' '; W7 := ' '; W8 := ' '; W9 := ' '; W10 := ' ';
  BracketsReadingCondition := NoneReading;
  PerfomanceCondition := IsBegin;
  PrevSign := None;
  //WHILE NOT EOLN
  WHILE PerfomanceCondition <> IsEnd
  DO
    BEGIN
      READ(W7);
      IF W7 = ' ' THEN BEGIN {} END ELSE
      IF W7 = ';' THEN BEGIN WRITELN('  ', W7); W1 := W2; W2 := W3; W3 := W4; W4 := W5;
      W5 := W6; W6 := W7 END ELSE
      BEGIN 
        IF W7 = 'E'
        THEN
          BEGIN
            READ(W8);
            IF W8 = 'N'
            THEN
              BEGIN
                READ(W9);
                IF W9 = 'D'
                THEN
                  BEGIN
                    READ(W10);
                    IF W10 = '.'
                    THEN
                      BEGIN
                        W1 := W2; W2 := W3; W3 := W4; W4 := W5; W5 := W6; W6 := W7; W7 := W8; W8 := W9; W9 := W10;
                        W1 := W2; W2 := W3; W3 := W4; W4 := W5; W5 := W6; W6 := W7; W7 := W8; W8 := W9; W9 := W10;
                        W1 := W2; W2 := W3; W3 := W4; W4 := W5; W5 := W6; W6 := W7; W7 := W8; W8 := W9; W9 := W10;
                        W8 := ' '; W9 := ' '; W10 := ' '; 
                        WRITE(W4, W5, W6, W7);
                        PerfomanceCondition := IsEnd
                      END 
                    ELSE
                      BEGIN {IF W10 <> '.'}
                        W1 := W2; W2 := W3; W3 := W4; W4 := W5; W5 := W6; W6 := W7; W7 := W8; W8 := W9; W9 := W10;
                        W1 := W2; W2 := W3; W3 := W4; W4 := W5; W5 := W6; W6 := W7; W7 := W8; W8 := W9; W9 := W10;
                        W1 := W2; W2 := W3; W3 := W4; W4 := W5; W5 := W6; W6 := W7; W7 := W8; W8 := W9; W9 := W10;
                        W8 := ' '; W9 := ' '; W10 := ' '; 
                        IF W7 = ' ' THEN WRITELN('  ', W4, W5, W6) ELSE WRITE('  ', W4, W5, W6, W7)
                      END 
                  END 
                ELSE
                  BEGIN {IF W9 <> 'D'}
                    W1 := W2; W2 := W3; W3 := W4; W4 := W5; W5 := W6; W6 := W7; W7 := W8; W8 := W9; W9 := W10;
                    W1 := W2; W2 := W3; W3 := W4; W4 := W5; W5 := W6; W6 := W7; W7 := W8; W8 := W9; W9 := W10;
                    W8 := ' '; W9 := ' '; W10 := ' ';
                    WRITE('  ', W4, W5, W6, W7) 
                  END 
              END 
            ELSE
              BEGIN {IF W8 <> 'N'}
                W1 := W2; W2 := W3; W3 := W4; W4 := W5; W5 := W6; W6 := W7; W7 := W8; W8 := W9; W9 := W10
              END 
          END 
        ELSE
          BEGIN {IF W7 <> 'E'}
            WRITE('  ', W7);
            W1 := W2; W2 := W3; W3 := W4; W4 := W5; W5 := W6; W6 := W7
          END;
        IF PerfomanceCondition <> IsEnd
        THEN
          BEGIN
            WHILE PrevSign = None
            DO
              BEGIN
                READ(W7);
                IF W7 = '.' THEN PrevSign := IsDot ELSE
                IF W7 = ' ' THEN PrevSign := IsGap ELSE
                IF W7 = ';' THEN PrevSign := IsSemicolon;
                {�������� ������� PrintBrackets}
                IF W7 = '('
                THEN
                  BEGIN
                    W1 := W2; W2 := W3; W3 := W4; W4 := W5; W5 := W6; W6 := W7; 
                    WRITE(W7);
                    BracketsReadingCondition := LeftBracketReading;
                    WHILE BracketsReadingCondition <> RightBracketReading 
                    DO
                      BEGIN {WHILE BracketsReadingCondition <> RightBracketReading}
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
                                W1 := W2; W2 := W3; W3 := W4; W4 := W5; W5 := W6;
                                W6 := ' '; 
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
                      END {WHILE BracketsReadingCondition <> RightBracketReading}           
                  END;
                IF BracketsReadingCondition = RightBracketReading
                THEN
                  BEGIN
                    W1 := W2; W2 := W3; W3 := W4; W4 := W5; W5 := W6; W6 := W7; 
                    WRITE(W7);
                    BracketsReadingCondition := NoneReading
                  END 
                ELSE
                  IF PrevSign = None THEN BEGIN WRITE(W7); W1 := W2; W2 := W3; W3 := W4; W4 := W5;
                  W5 := W6; W6 := W7 END  
              END;
            IF PrevSign = IsDot THEN BEGIN WRITE(W7); W1 := W2; W2 := W3; W3 := W4; W4 := W5;
            W5 := W6; W6 := W7; PrevSign := None; PerfomanceCondition := IsEnd END; 
            IF PrevSign = IsGap THEN BEGIN WRITELN; W1 := W2; W2 := W3; W3 := W4; W4 := W5;
            W5 := W6; W6 := W7; PrevSign := None END;
            IF PrevSign = IsSemicolon THEN BEGIN WRITELN(W7); W1 := W2; W2 := W3; W3 := W4; W4 := W5;
            W5 := W6; W6 := W7; PrevSign := None END;  
          END      
      END {W7 <> ' ' AND W7 <> ' '}
    END; {WHILE PerfomanceCondition <> IsEnd}
  
  CASE PerfomanceCondition OF
    IsNotBegin: BEGIN WRITELN; WRITELN; WRITELN('PerfomanceCondition = IsNotBegin') END;
    IsBegin: BEGIN WRITELN; WRITELN; WRITELN('PerfomanceCondition = IsBegin') END;
    IsEnd: BEGIN WRITELN; WRITELN; WRITELN('PerfomanceCondition = IsEnd') END;
  END;
  
  CASE PrevSign OF
   None: BEGIN WRITELN; WRITELN('PrevSign = None') END;
   IsSemicolon: BEGIN WRITELN; WRITELN('PrevSign = IsSemicolon') END;
   IsGap: BEGIN WRITELN; WRITELN('PrevSign = IsGap') END;      
  END;
END.
