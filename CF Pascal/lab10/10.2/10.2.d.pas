PROGRAM CorrectingLine(INPUT, OUTPUT);
{PerfomanceCondition = IsNotBegin <=> PerfomanceCondition = 'A'
 PerfomanceCondition = IsBegin    <=> PerfomanceCondition = 'B'
 PerfomanceCondition = IsEnd      <=> PerfomanceCondition = 'C'
 
 PrevSign = IsNotSign             <=> PrevSign = 'A'
 PrevSign = IsSemicolon           <=> PrevSign = 'B'
 PrevSign = WasSemicolon          <=> PrevSign = 'C'
 PrevSign = IsDot                 <=> PrevSign = 'D'
 
 BracketsReadingCondition = NoneReading         <=> BracketsReadingCondition = 'A'
 BracketsReadingCondition = LeftBracketReading  <=> BracketsReadingCondition = 'B'
 BracketsReadingCondition = StrOfSimbolsReading <=> BracketsReadingCondition = 'C'
 BracketsReadingCondition = RightBracketReading <=> BracketsReadingCondition = 'D'
 
 AssignmentSign = IsNotAssignmentSign <=> AssignmentSign = 'F'
 AssignmentSign = IsAssignmentSign    <=> AssignmentSign = 'T'
 
 CommentReadingCondition = IsNotCommentReadingCondition <=> CommentReadingCondition = 'F'
 CommentReadingCondition = IsCommentReadingCondition    <=> CommentReadingCondition = 'T'}
VAR
  BracketsReadingCondition, CommentReadingCondition, AssignmentSign, PerfomanceCondition, PrevSign, IsErr: CHAR;  
  W1, W2, W3, W4, W5, W6, W7, W8, W9, W10: CHAR;
BEGIN
  W1 := ' '; W2 := ' '; W3 := ' '; W4 := ' '; W5 := ' '; W6 := ' '; W7 := ' '; W8 := ' '; W9 := ' '; W10 := ' ';
  BracketsReadingCondition := 'B';
  CommentReadingCondition := 'F';
  AssignmentSign := 'F';
  PrevSign := 'A';
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
      IF NOT EOLN
      THEN
        BEGIN
          W1 := W2; W2 := W3; W3 := W4; W4 := W5; W5 := W6; W6 := W7;
          READ(W7);
          IF (W7 = '{') AND (CommentReadingCondition = 'F')
          THEN
            BEGIN
              WRITE(W7);
              CommentReadingCondition := 'T'
            END
          ELSE
            IF (W7 = '}') AND (CommentReadingCondition = 'T')
            THEN
              BEGIN
                WRITELN(W7);
                CommentReadingCondition := 'F'
              END
          ELSE
            IF (CommentReadingCondition = 'T')
            THEN
              WRITE(W7)      
        END
      ELSE
        BEGIN
          READLN;
          IF (CommentReadingCondition = 'T')
          THEN
            WRITELN
        END;  
      IF (CommentReadingCondition = 'F') AND (PerfomanceCondition = 'A') AND (W1 = ' ') AND (W2 = 'B') AND (W3 = 'E') AND (W4 = 'G') AND (W5 = 'I') AND (W6 = 'N') AND ((W7 = ' ') OR (W7 = ';'))
      THEN
        PerfomanceCondition := 'B'
    END;
  IF PerfomanceCondition = 'B'
  THEN
    WRITELN(W2, W3, W4, W5, W6);
  IF W7 = ';'
  THEN
    WRITELN('  ', W7);
  WHILE (PerfomanceCondition <> 'C') AND (IsErr = 'F')
  DO
    BEGIN
      IF NOT EOLN
      THEN
        BEGIN {IF NOT EOLN}
          READ(W7);
          IF W7 = '{'
          THEN
            BEGIN
              IF PrevSign = 'C'
              THEN
                BEGIN
                  WRITE(' ');
                  PrevSign := 'A'
                END;
              WRITE(W7);
              WHILE W7 <> '}'
              DO
                BEGIN
                  IF NOT EOLN(INPUT)
                  THEN
                    BEGIN
                      READ(W7);
                      WRITE(W7)
                    END
                  ELSE
                    BEGIN
                      READLN(INPUT);
                      WRITELN
                    END  
                END;
              WRITELN  
            END
          ELSE
            IF W7 = ' '
            THEN
              BEGIN
                {}
              END
            ELSE
              IF (W7 = ';') AND (PrevSign = 'C')
              THEN
                BEGIN
                  WRITE(W7);
                  W1 := W2; W2 := W3; W3 := W4; W4 := W5; W5 := W6; W6 := W7
                END
              ELSE
                BEGIN {IF W7 <> ' ' AND W7 <> ';' AND W7 <> ':'; AND W7 <> '{'}
                  IF PrevSign = 'C'
                  THEN
                    BEGIN
                      WRITELN;
                      PrevSign := 'A'
                    END;
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
                                  IF W7 = ' '
                                  THEN
                                    WRITELN('  ', W4, W5, W6)
                                  ELSE
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
                          CommentReadingCondition := 'F';
                          READ(W7);
                          IF W7 = '.' THEN PrevSign := 'D' ELSE
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
                                  AssignmentSign := 'T';
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
                                        PrevSign := 'A';
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
                                ELSE {IF W7 = '{'}
                                  IF W7 = '{'
                                  THEN
                                    BEGIN
                                      CommentReadingCondition := 'T';
                                      WRITE(' ', W7);
                                      WHILE W7 <> '}'
                                      DO
                                        BEGIN
                                          IF NOT EOLN(INPUT)
                                          THEN
                                            BEGIN
                                              READ(W7);
                                              WRITE(W7)
                                            END
                                          ELSE
                                            BEGIN
                                              READLN(INPUT);
                                              WRITELN
                                            END    
                                        END
                                    END
                                  ELSE 
                                    IF W7 = ';'
                                    THEN
                                      PrevSign := 'B'
                                    ELSE {IF W7 <> ':' AND W7 <> '{' AND W7 <> ';'}
                                      WRITELN 
                              END
                            ELSE
                              IF W7 = ';'
                              THEN
                                PrevSign := 'B'
                              ELSE
                                IF W7 = '{'
                                THEN
                                  BEGIN
                                    CommentReadingCondition := 'T';
                                    WRITE(' ', W7);
                                    WHILE W7 <> '}'
                                    DO
                                      BEGIN
                                        IF NOT EOLN(INPUT)
                                        THEN
                                          BEGIN
                                            READ(W7);
                                            WRITE(W7)
                                          END
                                        ELSE
                                          BEGIN
                                            READLN(INPUT);
                                            WRITELN
                                          END    
                                      END;
                                    WRITELN
                                  END                                 
                                ELSE
                                  {�������� ������� PrintBrackets}
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
                                        END; {WHILE BracketsReadingCondition <> 'D'}            
                                      W1 := W2; W2 := W3; W3 := W4; W4 := W5; W5 := W6; W6 := W7; 
                                      BracketsReadingCondition := 'A'
                                    END; {����� ������� PrintBrackets}
                          IF (PrevSign = 'A') AND (AssignmentSign = 'F') AND (CommentReadingCondition = 'F')
                          THEN
                            BEGIN
                              WRITE(W7);
                              W1 := W2; W2 := W3; W3 := W4; W4 := W5; W5 := W6; W6 := W7
                            END
                          ELSE
                            IF (PrevSign = 'A') AND (AssignmentSign = 'T')
                            THEN
                              BEGIN
                                WRITE(W7);
                                W1 := W2; W2 := W3; W3 := W4; W4 := W5; W5 := W6; W6 := W7;
                                AssignmentSign := 'F'
                              END
                        END;
                      IF PrevSign = 'D'
                      THEN
                        BEGIN
                          WRITE(W7);
                          W1 := W2; W2 := W3; W3 := W4; W4 := W5; W5 := W6; W6 := W7;
                          PrevSign := 'A';
                          PerfomanceCondition := 'C'
                        END; 
                      IF PrevSign = 'B'
                      THEN
                        BEGIN
                          WRITE(W7);
                          W1 := W2; W2 := W3; W3 := W4; W4 := W5; W5 := W6; W6 := W7;
                          PrevSign := 'C'
                        END  
                    END      
                END {IF W7 <> ' ' AND W7 <> ';' AND W7 <> ':'; AND W7 <> '{'}
        END {IF NOT EOLN}
      ELSE
        READLN  
    END; {WHILE PerfomanceCondition <> 'C'}
    IF NOT EOF(INPUT)
    THEN
      BEGIN
        WHILE NOT EOLN(INPUT)
        DO
          BEGIN
            READ(W7);
            IF W7 = '{'
            THEN
              BEGIN
                WRITE(' ', W7);
                WHILE W7 <> '}'
                DO
                  BEGIN
                    IF NOT EOLN(INPUT)
                    THEN
                      BEGIN
                        READ(W7);
                        WRITE(W7)
                      END
                    ELSE
                      BEGIN
                        READLN(INPUT);
                        WRITELN
                      END    
                  END
              END     
          END
      END;
  {CASE PerfomanceCondition OF
    'A': BEGIN WRITELN; WRITELN; WRITELN('PerfomanceCondition = IsNotBegin') END;
    'B': BEGIN WRITELN; WRITELN; WRITELN('PerfomanceCondition = IsBegin') END;
    'C': BEGIN WRITELN; WRITELN; WRITELN('PerfomanceCondition = IsEnd') END
  END;
  
  CASE PrevSign OF
   'A': BEGIN WRITELN; WRITELN('PrevSign = IsNotSign') END;
   'B': BEGIN WRITELN; WRITELN('PrevSign = IsSemicolon') END
  END;} 
END.
