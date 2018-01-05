PROGRAM CorrectingLine(INPUT, OUTPUT);
TYPE PerfomanceConditions = (IsNotBegin, IsBegin, IsEnd);
TYPE PrevSigns = (IsNotSign, IsSemicolon, WasSemicolon, IsDot);
TYPE AssignmentSigns = (IsNotAssignmentSign, IsAssignmentSign);
TYPE BracketsReadingConditions = (NoneReading, LeftBracketReading, StrOfSimbolsReading, RightBracketReading);
VAR
  AssignmentSign: AssignmentSigns;
  BracketsReadingCondition: BracketsReadingConditions; 
  PerfomanceCondition: PerfomanceConditions;    
  PrevSign: PrevSigns;
  W1, W2, W3, W4, W5, W6, W7, W8, W9, W10: CHAR;
BEGIN
  W1 := ' '; W2 := ' '; W3 := ' '; W4 := ' ';
  W5 := ' '; W6 := ' '; W7 := ' '; W8 := ' ';
  W9 := ' '; W10 := ' ';
  BracketsReadingCondition := LeftBracketReading;
  AssignmentSign := IsNotAssignmentSign;
  PerfomanceCondition := IsBegin;
  PrevSign := IsNotSign;
  //WHILE NOT EOLN
  WHILE PerfomanceCondition <> IsEnd
  DO
    BEGIN
      IF NOT EOLN
      THEN
        BEGIN {IF NOT EOLN}
          READ(W7);
          IF W7 = ' ' THEN BEGIN {} END ELSE
          IF (W7 = ';') AND (PrevSign = WasSemicolon) THEN BEGIN WRITE(W7); W1 := W2; W2 := W3; W3 := W4; W4 := W5; W5 := W6; W6 := W7 END
          ELSE
            BEGIN {IF W7 <> ' ' AND W7 <> ';' AND W7 <> ':'}
              IF PrevSign = WasSemicolon THEN BEGIN WRITELN; PrevSign := IsNotSign END;
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
                              W1 := W2; W2 := W3; W3 := W4; W4 := W5;
                              W5 := W6; W6 := W7; W7 := W8; W8 := W9;
                              W9 := W10;
                              W1 := W2; W2 := W3; W3 := W4; W4 := W5;
                              W5 := W6; W6 := W7; W7 := W8; W8 := W9;
                              W9 := W10;
                              W1 := W2; W2 := W3; W3 := W4; W4 := W5;
                              W5 := W6; W6 := W7; W7 := W8; W8 := W9;
                              W9 := W10;
                              W8 := ' '; W9 := ' '; W10 := ' '; 
                              WRITE(W4, W5, W6, W7);
                              PerfomanceCondition := IsEnd
                            END 
                          ELSE
                            BEGIN {IF W10 <> '.'}
                              W1 := W2; W2 := W3; W3 := W4; W4 := W5;
                              W5 := W6; W6 := W7; W7 := W8; W8 := W9;
                              W9 := W10;
                              W1 := W2; W2 := W3; W3 := W4; W4 := W5;
                              W5 := W6; W6 := W7; W7 := W8; W8 := W9;
                              W9 := W10;
                              W1 := W2; W2 := W3; W3 := W4; W4 := W5;
                              W5 := W6; W6 := W7; W7 := W8; W8 := W9;
                              W9 := W10;
                              W8 := ' '; W9 := ' '; W10 := ' '; 
                              IF W7 = ' '
                              THEN
                                WRITELN('  ', W4, W5, W6)
                              ELSE
                                WRITE('  ', W4, W5, W6, W7)  
                            END 
                        END 
                      ELSE
                        BEGIN {IF W9 <> 'D'}
                          W1 := W2; W2 := W3; W3 := W4; W4 := W5;
                          W5 := W6; W6 := W7; W7 := W8; W8 := W9;
                          W9 := W10;
                          W1 := W2; W2 := W3; W3 := W4; W4 := W5;
                          W5 := W6; W6 := W7; W7 := W8; W8 := W9;
                          W9 := W10;
                          W8 := ' '; W9 := ' '; W10 := ' ';
                          WRITE('  ', W4, W5, W6, W7) 
                        END 
                    END 
                  ELSE
                    BEGIN {IF W8 <> 'N'}
                      W1 := W2; W2 := W3; W3 := W4; W4 := W5;
                      W5 := W6; W6 := W7; W7 := W8; W8 := W9;
                      W9 := W10
                    END 
                END 
              ELSE
                BEGIN {IF W7 <> 'E'}
                  WRITE('  ', W7);
                  W1 := W2; W2 := W3; W3 := W4; W4 := W5;
                  W5 := W6; W6 := W7
                END;
              IF PerfomanceCondition <> IsEnd
              THEN
                BEGIN
                  WHILE PrevSign = IsNotSign
                  DO
                    BEGIN
                      READ(W7);
                      IF W7 = '.' THEN PrevSign := IsDot ELSE
                      IF W7 = ':'
                      THEN
                        BEGIN
                          READ(W8);
                          IF W8 = '='
                          THEN
                            BEGIN
                              W1 := W2; W2 := W3; W3 := W4; W4 := W5; W5 := W6; W6 := W7; W7 := W8;
                              WRITE(' ' , W6, W7, ' ');
                              W8 := ' ';
                              AssignmentSign := IsAssignmentSign;
                              READ(W7);
                              IF W7 = ' '
                              THEN
                                BEGIN 
                                  WHILE W7 = ' '
                                  DO
                                    READ(W7)
                                END
                            END
                        END
                      ELSE
                        IF W7 = ' '
                        THEN
                          BEGIN
                            WHILE W7 = ' '
                            DO
                              READ(W7);
                            IF W7 = ':'
                            THEN
                              BEGIN
                                READ(W8);
                                IF W8 = '='
                                THEN                                                                           
                                  BEGIN
                                    W1 := W2; W2 := W3; W3 := W4; W4 := W5; W5 := W6; W6 := W7; W7 := W8;
                                    WRITE(' ' , W6, W7, ' ');
                                    PrevSign := IsNotSign;
                                    W8 := ' ';
                                    READ(W7);
                                    IF W7 = ' '
                                    THEN
                                      BEGIN 
                                        WHILE W7 = ' '
                                        DO
                                          READ(W7)
                                      END
                                  END
                              END {IF W7 = ':'}
                            ELSE 
                              IF W7 = ';'
                              THEN
                                PrevSign := IsSemicolon
                              ELSE {IF W7 <> ':' AND W7 <> ';'}
                                WRITELN 
                          END
                      ELSE
                        IF W7 = ';' THEN PrevSign := IsSemicolon
                      ELSE
                      {Добавить функцию PrintBrackets}
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
                             //WRITE(W7);
                             BracketsReadingCondition := NoneReading
                           END;
                                   
                      {Конец функции PrintBrackets}
                      IF (PrevSign = IsNotSign) AND (AssignmentSign = IsNotAssignmentSign) THEN BEGIN WRITE(W7); W1 := W2; W2 := W3; W3 := W4; W4 := W5;
                      W5 := W6; W6 := W7 END ELSE
                      IF (PrevSign = IsNotSign) AND (AssignmentSign = IsAssignmentSign) THEN BEGIN WRITE(W7); W1 := W2; W2 := W3; W3 := W4; W4 := W5;
                      W5 := W6; W6 := W7; AssignmentSign := IsNotAssignmentSign END
                    END;
              
                  IF PrevSign = IsDot THEN BEGIN WRITE(W7); W1 := W2; W2 := W3; W3 := W4; W4 := W5;
                  W5 := W6; W6 := W7; PrevSign := IsNotSign; PerfomanceCondition := IsEnd END; 
                  IF PrevSign = IsSemicolon THEN BEGIN WRITE(W7); W1 := W2; W2 := W3; W3 := W4; W4 := W5;
                  W5 := W6; W6 := W7; PrevSign := WasSemicolon END;  
                END      
            END {IF W7 <> ' ' AND W7 <> ';' AND W7 <> ':'}
        END {IF NOT EOLN}
      ELSE
        READLN  
    END; {WHILE PerfomanceCondition <> IsEnd}
  
  CASE PerfomanceCondition OF
    IsNotBegin: BEGIN WRITELN; WRITELN; WRITELN('PerfomanceCondition = IsNotBegin') END;
    IsBegin: BEGIN WRITELN; WRITELN; WRITELN('PerfomanceCondition = IsBegin') END;
    IsEnd: BEGIN WRITELN; WRITELN; WRITELN('PerfomanceCondition = IsEnd') END
  END;
  
  CASE PrevSign OF
   IsNotSign: BEGIN WRITELN; WRITELN('PrevSign = IsNotSign') END;
   IsSemicolon: BEGIN WRITELN; WRITELN('PrevSign = IsSemicolon') END
  END; 
END.
