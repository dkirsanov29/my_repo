PROGRAM MinSort3 (INPUT, OUTPUT);
{��������� 3-������ �� INPUT � OUTPUT }
VAR Ch1, Ch2, Ch3: CHAR;
BEGIN {MinSort3}
  READ(Ch1, Ch2, Ch3);
  WRITELN('Input data: ', Ch1, Ch2, Ch3);
  WRITE('Sorted data: ');
  {�������� ������� � OUTPUT, ��������� ���������� � Ch1 and Ch2 };
  IF Ch1 < Ch2
  THEN
    BEGIN
      { �������� ������� �� Ch1, Ch3 � OUTPUT,
      ����������� Ch3 � Ch1,���� ����������}
      IF Ch1 < Ch3
      THEN
        BEGIN
          WRITE(Ch1);
          Ch1 := Ch3
        END
      ELSE
        WRITE(Ch3)
    END    
  ELSE
    { �������� ������� �� Ch2, Ch3 � OUTPUT,
    ����������� Ch3 � Ch2,���� ����������}
    BEGIN
      IF Ch2 < Ch3
      THEN
        BEGIN
          WRITE(Ch2);
          Ch2 := Ch3
        END
      ELSE
        WRITE(Ch3)
    END;
  { ����������� Ch1, Ch2 � OUTPUT };
  WRITELN
END.{Minsort3}
