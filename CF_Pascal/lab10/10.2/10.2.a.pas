PROGRAM CorrectingLine(INPUT, OUTPUT);
{PerfomanceCondition = IsNotBegin <=> PerfomanceCondition = 'A'
 PerfomanceCondition = IsBegin    <=> PerfomanceCondition = 'B'
 PerfomanceCondition = IsEnd      <=> PerfomanceCondition = 'C'
 
 PrevSign = IsNotPrevSign         <=> PrevSign = 'A'
 PrevSign = IsSemicolon           <=> PrevSign = 'B'
 PrevSign = IsGap                 <=> PrevSign = 'C'
 PrevSign = IsDot                 <=> PrevSign = 'D'
 
 BracketsReadingCondition = NoneReading         <=> BracketsReadingCondition = 'A'
 BracketsReadingCondition = LeftBracketReading  <=> BracketsReadingCondition = 'B'
 BracketsReadingCondition = StrOfSimbolsReading <=> BracketsReadingCondition = 'C'
 BracketsReadingCondition = RightBracketReading <=> BracketsReadingCondition = 'D'}
VAR
  BracketsReadingCondition, PerfomanceCondition, PrevSign, IsErr: CHAR;
  W1, W2, W3, W4, W5, W6, W7, W8, W9, W10: CHAR;
BEGIN
  W1 := ' '; W2 := ' '; W3 := ' '; W4 := ' '; W5 := ' '; W6 := ' '; W7 := ' '; W8 := ' '; W9 := ' '; W10 := ' ';
  BracketsReadingCondition := 'A';
  PerfomanceCondition := 'A';
  IsErr := 'F';
  IF EOLN(INPUT)
  THEN
    BEGIN
      IsErr := 'T';
      WRITELN('Err: Input file hasn''t be empty')
    END;  
  WHILE (PerfomanceCondition <> 'B') AND (IsErr = 'F')
  DO
    BEGIN
      W1 := W2; W2 := W3; W3 := W4; W4 := W5; W5 := W6; W6 := W7;
      READ(W7);
      IF (PerfomanceCondition = 'A') AND (W1 = ' ') AND (W2 = 'B') AND (W3 = 'E') AND (W4 = 'G') AND (W5 = 'I') AND (W6 = 'N') AND ((W7 = ' ') OR (W7 = ';'))
      THEN
        PerfomanceCondition := 'B'   
    END;
  IF PerfomanceCondition = 'B'
  THEN
    WRITELN(W2, W3, W4, W5, W6);
  PrevSign := 'A';
  WHILE (PerfomanceCondition <> 'C') AND (IsErr = 'F')
  DO
    BEGIN
      READ(W7);
      IF W7 <> ' '
      THEN
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
                          PerfomanceCondition := 'C'
                        END 
                      ELSE
                        BEGIN {IF W10 <> '.'}
                          W1 := W2; W2 := W3; W3 := W4; W4 := W5; W5 := W6; W6 := W7; W7 := W8; W8 := W9; W9 := W10;
                          W1 := W2; W2 := W3; W3 := W4; W4 := W5; W5 := W6; W6 := W7; W7 := W8; W8 := W9; W9 := W10;
                          W1 := W2; W2 := W3; W3 := W4; W4 := W5; W5 := W6; W6 := W7; W7 := W8; W8 := W9; W9 := W10;
                          W8 := ' '; W9 := ' '; W10 := ' '; 
                          WRITE('  ', W4, W5, W6, W7)
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
          IF PerfomanceCondition <> 'C'
          THEN
            BEGIN
              WHILE PrevSign = 'A'
              DO
                BEGIN
                  READ(W7);
                  IF W7 = '.'
                  THEN
                    PrevSign := 'D'
                  ELSE
                    IF W7 = ' '
                    THEN
                      PrevSign := 'C'
                    ELSE
                      IF W7 = ';'
                      THEN
                        PrevSign := 'B';
                  {Добавить функцию PrintBrackets}
                  IF W7 = '('
                  THEN
                    BEGIN
                      W1 := W2; W2 := W3; W3 := W4; W4 := W5; W5 := W6; W6 := W7; 
                      WRITE(W7);
                      BracketsReadingCondition := 'B';
                      WHILE BracketsReadingCondition <> 'D'
                      DO
                        BEGIN
                          READ(W7);
                          IF (BracketsReadingCondition = 'B') AND (W7 = ')')
                          THEN
                            BracketsReadingCondition := 'D'
                          ELSE
                            IF (BracketsReadingCondition = 'B') AND (W7 = ' ')
                            THEN
                              {}
                            ELSE
                              IF (BracketsReadingCondition = 'B') AND (W7 = ',')
                              THEN
                                BEGIN
                                  W1 := W2; W2 := W3; W3 := W4; W4 := W5; W5 := W6; W6 := W7; 
                                  W1 := W2; W2 := W3; W3 := W4; W4 := W5; W5 := W6; W6 := ' '; 
                                  WRITE(W7, ' ')
                                END  
                              ELSE
                                IF (BracketsReadingCondition = 'B') AND (W7 = '''')
                                THEN
                                  BEGIN
                                    W1 := W2; W2 := W3; W3 := W4; W4 := W5; W5 := W6; W6 := W7; 
                                    WRITE(W7);
                                    BracketsReadingCondition := 'C'
                                  END
                                ELSE
                                  IF BracketsReadingCondition = 'B'
                                  THEN
                                    BEGIN
                                      W1 := W2; W2 := W3; W3 := W4; W4 := W5; W5 := W6; W6 := W7; 
                                      WRITE(W7)
                                    END  
                                  ELSE
                                    IF (BracketsReadingCondition = 'C') AND (W7 = '''')
                                    THEN    
                                      BEGIN
                                        W1 := W2; W2 := W3; W3 := W4; W4 := W5; W5 := W6; W6 := W7; 
                                        WRITE(W7);
                                        BracketsReadingCondition := 'B'
                                      END
                                    ELSE
                                      IF (BracketsReadingCondition = 'C')
                                      THEN
                                        BEGIN
                                          W1 := W2; W2 := W3; W3 := W4; W4 := W5; W5 := W6; W6 := W7; 
                                          WRITE(W7)
                                        END           
                        END;            
                      W1 := W2; W2 := W3; W3 := W4; W4 := W5; W5 := W6; W6 := W7; 
                      WRITE(W7)
                    END;
                  IF BracketsReadingCondition = 'A'
                  THEN
                    BEGIN
                      IF PrevSign = 'A'
                      THEN
                        BEGIN
                          WRITE(W7);
                          W1 := W2; W2 := W3; W3 := W4; W4 := W5; W5 := W6; W6 := W7
                        END
                    END  
                  ELSE
                    BracketsReadingCondition := 'A'
                END;
              IF PrevSign = 'D'
              THEN
                BEGIN
                  WRITE(W7);
                  W1 := W2; W2 := W3; W3 := W4; W4 := W5; W5 := W6; W6 := W7;
                  PrevSign := 'A';
                  PerfomanceCondition := 'C'
                END;
              IF PrevSign = 'C'
              THEN
                BEGIN
                  WRITELN;
                  W1 := W2; W2 := W3; W3 := W4; W4 := W5; W5 := W6; W6 := W7;
                  PrevSign := 'A'
                END;
              IF PrevSign = 'B'
              THEN
                BEGIN
                  WRITELN(W7);
                  W1 := W2; W2 := W3; W3 := W4; W4 := W5; W5 := W6; W6 := W7;
                  PrevSign := 'A'
                END  
            END      
        END {W7 <> ' '}
    END; {WHILE PerfomanceCondition <> 'C'}
  {CASE PerfomanceCondition OF
    'A': BEGIN WRITELN; WRITELN; WRITELN('PerfomanceCondition = IsNotBegin') END;
    'B': BEGIN WRITELN; WRITELN; WRITELN('PerfomanceCondition = IsBegin') END;
    'C': BEGIN WRITELN; WRITELN; WRITELN('PerfomanceCondition = IsEnd') END
  END;
  
  CASE PrevSign OF
   'A': BEGIN WRITELN; WRITELN('PrevSign = IsNotPrevSign') END;
   'B': BEGIN WRITELN; WRITELN('PrevSign = IsSemicolon') END;
   'C': BEGIN WRITELN; WRITELN('PrevSign = IsGap') END;
   'D': BEGIN WRITELN; WRITELN('PrevSign = IsDot') END;      
  END}
END.
