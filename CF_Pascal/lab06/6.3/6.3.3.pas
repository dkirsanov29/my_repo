PROGRAM SelectSort(INPUT, OUTPUT);
{Сортирует символы, предшествующие #, из INPUT в OUTPUT.
 Программа выдаст ошибку, если в INPUT отсутствует #}
VAR
  Ch, Min: CHAR;
  F1, F2: TEXT;
BEGIN {SelectSort}
  {Копировать INPUT в F1 и эхо в OUTPUT}
  REWRITE(F1);
  WRITE(OUTPUT, 'INPUT DATA: ');
  READ(INPUT, Ch);
  WHILE Ch <> '#'
  DO
    BEGIN
      WRITE(F1, Ch);
      READ(INPUT, Ch)
    END;
  WRITELN(F1, '#');
  {Сортировать F1 в OUTPUT, используя стратегию SelectSort}
  WRITE(OUTPUT, 'SORTED DATA: ');
  RESET(F1);
  READ(F1, Ch);
  WHILE Ch <> '#'
  DO { Ch <> '#' и Ch1 - первый символ F1}
    BEGIN
      {Выбираем минимальный из F1 и копируем остаток F1 в F2}
      REWRITE(F2);
      Min := Ch;
      READ(F1, Ch);
      WHILE Ch <> '#'
      DO { Ch <> '#' и Ch1 - первый символ F1}
        BEGIN
          {Выбираем минимальный из (Ch, Min)
          копируем второй символ в F2}
          IF Ch < Min
          THEN  {Ch - минимальный из (Ch, Min)}
            BEGIN
              WRITE(F2, Min);
              Min := Ch
            END
          ELSE {Min - минимальный из (Ch, Min)}
            WRITE(F2, Ch);
          READ(F1, Ch)
        END;
      WRITELN(F2, '#');
      WRITELN(OUTPUT, 'Min: ', Min);
      WRITE('F2 contains: ');
      {Выводим данные из F2 в Output}
      RESET(F2);
      READ(F2, Ch);
      WHILE Ch <> '#'
      DO { Ch <> '#' и Ch1 - первый символ F1}
        BEGIN
          WRITE(Output, Ch);
          READ(F2, Ch)    
        END;
      WRITELN  
    END
  {Копируем F2 в F1}
END. {SelectSort}

