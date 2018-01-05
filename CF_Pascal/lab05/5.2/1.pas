PROGRAM MinSort3 (INPUT, OUTPUT);
{сортирует 3-строку из INPUT в OUTPUT }
VAR Ch1, Ch2, Ch3: CHAR;
BEGIN {MinSort3}
  READ(Ch1, Ch2, Ch3);
  WRITELN('Input data: ', Ch1, Ch2, Ch3);
  WRITE('Sorted data: ');
  {Печатать минимум в OUTPUT, сохранить содержимое в Ch1 and Ch2 };
  IF Ch1 < Ch2
  THEN
    BEGIN
      { Печатать минимум из Ch1, Ch3 в OUTPUT,
      переместить Ch3 в Ch1,если необходимо}
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
    { Печатать минимум из Ch2, Ch3 в OUTPUT,
    переместить Ch3 в Ch2,если необходимо}
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
  { Сортировать Ch1, Ch2 в OUTPUT };
  WRITELN
END.{Minsort3}
