PROGRAM CorrectingLine(INPUT, OUTPUT);
TYPE PerfomanceConditions = (IsNotBegin, IsBegin, IsEnd);
TYPE PrevSigns = (None, IsSemicolon, IsGap, IsDot);
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
            WHILE (PrevSign = None)
            DO
              BEGIN
                READ(W7);
                IF W7 = '.' THEN PrevSign := IsDot ELSE
                IF W7 = ' ' THEN PrevSign := IsGap ELSE
                IF W7 = ';' THEN PrevSign := IsSemicolon;
                {�������� ������� PrintBrackets}
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
