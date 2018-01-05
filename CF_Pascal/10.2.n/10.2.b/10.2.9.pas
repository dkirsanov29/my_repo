PROGRAM CorrectingLine(INPUT, OUTPUT);
TYPE PerfomanceConditions = (IsNotBegin, IsBegin, IsEnd);
TYPE PrevSigns = (IsNotSign, IsSemicolon, IsDot);
TYPE AssignmentSigns = (IsNotAssignmentSign, IsAssignmentSign);
VAR
   AssignmentSign: AssignmentSigns;
  PerfomanceCondition: PerfomanceConditions;    
  PrevSign: PrevSigns;
  W1, W2, W3, W4, W5, W6, W7, W8, W9, W10: CHAR;
BEGIN
  W1 := ' '; W2 := ' '; W3 := ' '; W4 := ' '; W5 := ' '; W6 := ' '; W7 := ' '; W8 := ' '; W9 := ' '; W10 := ' ';
  AssignmentSign := IsNotAssignmentSign;
  PerfomanceCondition := IsBegin;
  PrevSign := IsNotSign;
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
  IF W7 = ';' THEN WRITELN('  ', W7);
  WHILE PerfomanceCondition <> IsEnd
  DO
    BEGIN
      READ(W7);
      IF W7 = ' ' THEN BEGIN {} END ELSE
      IF W7 = ';' THEN BEGIN WRITELN('  ', W7); W1 := W2; W2 := W3; W3 := W4; W4 := W5; W5 := W6; W6 := W7 END
      ELSE
        BEGIN {IF W7 <> ' ' AND W7 <> ';' AND W7 <> ':'}
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
                          END 
                        ELSE {IF W7 <> ':'}
                          WRITELN  
                      END
                  ELSE
                    IF W7 = ';' THEN PrevSign := IsSemicolon;
                  {Добавить функцию PrintBrackets}
                  
                  IF (PrevSign = IsNotSign) AND (AssignmentSign = IsNotAssignmentSign) THEN BEGIN WRITE(W7); W1 := W2; W2 := W3; W3 := W4; W4 := W5;
                  W5 := W6; W6 := W7 END ELSE
                  IF (PrevSign = IsNotSign) AND (AssignmentSign = IsAssignmentSign) THEN BEGIN WRITE(W7); W1 := W2; W2 := W3; W3 := W4; W4 := W5;
                  W5 := W6; W6 := W7; AssignmentSign := IsNotAssignmentSign END
                END;
              
              IF PrevSign = IsDot THEN BEGIN WRITE(W7); W1 := W2; W2 := W3; W3 := W4; W4 := W5;
              W5 := W6; W6 := W7; PrevSign := IsNotSign; PerfomanceCondition := IsEnd END; 
              IF PrevSign = IsSemicolon THEN BEGIN WRITELN(W7); W1 := W2; W2 := W3; W3 := W4; W4 := W5;
              W5 := W6; W6 := W7; PrevSign := IsNotSign END;  
            END      
        END {IF W7 <> ' ' AND W7 <> ';' AND W7 <> ':'}
    END; {WHILE PerfomanceCondition <> IsEnd}
  CASE PerfomanceCondition OF
    IsNotBegin: BEGIN WRITELN; WRITELN; WRITELN('PerfomanceCondition = IsNotBegin') END;
    IsBegin: BEGIN WRITELN; WRITELN; WRITELN('PerfomanceCondition = IsBegin') END;
    IsEnd: BEGIN WRITELN; WRITELN; WRITELN('PerfomanceCondition = IsEnd') END
  END;
  
  CASE PrevSign OF
   IsNotSign: BEGIN WRITELN; WRITELN('PrevSign = IsNotSign') END;
   IsSemicolon: BEGIN WRITELN; WRITELN('PrevSign = IsSemicolon') END
  END   
END.
