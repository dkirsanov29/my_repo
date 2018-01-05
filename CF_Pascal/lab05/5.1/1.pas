PROGRAM IFSort3(INPUT, OUTPUT);
{Сортирует 3-строку из INPUT в OUTPUT}
VAR
Ch1, Ch2, Ch3:Char;
BEGIN {IFSort3}
  READ(Ch1, Ch2, Ch3);
  WRITELN('Input data: ', Ch1, Ch2, Ch3);
  WRITE('Sorted data: ');
  {Сортируем Ch1, Ch2, Ch3 в OUTPUT}
  IF Ch1 < Ch2
  THEN
    BEGIN
      {Ch1 < Ch2:сортируем Ch1, Ch2, Ch3 в OUTPUT}
      IF Ch2 < Ch3
      THEN {Ch1 < Ch2 < Ch3:сортируем Ch1, Ch2, Ch3 в OUTPUT}
        WRITELN(Ch1, Ch2, Ch3)
      ELSE
        BEGIN
        {Ch1 < Ch2, Ch3 <= Ch2:сортируем Ch1, Ch2, Ch3 в OUTPUT}
        END
    END
  ELSE
    {Ch2 <= Ch1:сортируем Ch1, Ch2, Ch3 в OUTPUT}
    BEGIN
      {Ch2 <= Ch1:сортируем Ch1, Ch2, Ch3 в OUTPUT}
      IF Ch1 < Ch3
      THEN {Ch2 <= Ch1 < Ch3:сортируем Ch1, Ch2, Ch3 в OUTPUT}
        WRITELN(Ch2, Ch1, Ch3)
      ELSE
        BEGIN
          {Ch2 <= Ch1, Ch3 <= Ch1:сортируем Ch1, Ch2, Ch3 в OUTPUT}
        END  
    END
END. {IFsort3}

