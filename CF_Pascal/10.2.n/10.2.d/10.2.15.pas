PROGRAM CorrectingLine(INPUT, OUTPUT);
TYPE PerfomanceConditions = (IsNotBegin, IsBegin, IsEnd);
TYPE CommentReadingConditions = (IsNotCommentReadingCondition, IsCommentReadingCondition);
VAR
  CommentReadingCondition: CommentReadingConditions;
  PerfomanceCondition: PerfomanceConditions;    
  W1, W2, W3, W4, W5, W6, W7: CHAR;
BEGIN
  W1 := ' '; W2 := ' '; W3 := ' '; W4 := ' '; W5 := ' '; W6 := ' '; W7 := ' ';
  CommentReadingCondition := IsNotCommentReadingCondition;
  PerfomanceCondition := IsNotBegin;
  WHILE PerfomanceCondition <> IsBegin
  DO
    BEGIN
      IF NOT EOLN
      THEN
        BEGIN
          W1 := W2; W2 := W3; W3 := W4; W4 := W5; W5 := W6; W6 := W7;
          READ(W7);
          IF (W7 = '{') AND (CommentReadingCondition = IsNotCommentReadingCondition)
          THEN
            BEGIN
              WRITE(W7);
              CommentReadingCondition := IsCommentReadingCondition
            END
          ELSE
            IF (W7 = '}') AND (CommentReadingCondition = IsCommentReadingCondition)
            THEN
              BEGIN
                WRITELN(W7);
                CommentReadingCondition := IsNotCommentReadingCondition
              END
          ELSE
            IF (CommentReadingCondition = IsCommentReadingCondition)
            THEN
              WRITE(W7)      
        END
      ELSE
        BEGIN
          READLN;
          IF (CommentReadingCondition = IsCommentReadingCondition)
          THEN
            WRITELN
        END;  
      IF (CommentReadingCondition = IsNotCommentReadingCondition) AND (PerfomanceCondition = IsNotBegin) AND (W1 = ' ') AND (W2 = 'B') AND (W3 = 'E') AND (W4 = 'G') AND (W5 = 'I') AND (W6 = 'N') AND ((W7 = ' ') OR (W7 = ';'))
      THEN
        PerfomanceCondition := IsBegin
    END;
  IF PerfomanceCondition = IsBegin
  THEN
    WRITELN(W2, W3, W4, W5, W6);
  IF W7 = ';' THEN WRITELN('  ', W7)
END.
