PROGRAM SarahRevere (INPUT, OUTPUT);
{Печать сообщения о том как идут британцы,
в зависимости от того, первым во входе встречается
'land' или 'sea'.}
VAR
  W1, W2, W3, W4, Looking: CHAR;
BEGIN {SarahRevere}
  W1 := ' ';
  W2 := ' ';
  W3 := ' ';
  W4 := ' ';
  Looking := 'Y';
  WHILE Looking = 'Y'
  DO
    BEGIN
      { Проверка окна для 'land'}
      IF (W1 = 'l') AND (W2 = 'a') AND (W3 = 'n') AND (W4 = 'd')
      THEN {'land' найдено}
        Looking := 'L';
      { Проверка окна для 'sea'}
      IF (W1 = 's') AND (W2 = 'e') AND (W3 = 'a')
      THEN {'sea' найдено}
        Looking := 'S';
      { Двигать окно, проверять конец данных}
      W1 := W2;
      W2 := W3;
      W3 := W4;
      READ(W4);
      IF W4 = '#'
      THEN {Конец данных}
        Looking := 'N'            
    END;
  WRITELN;
  WRITELN('Looking is ', Looking);
  {создать сообщение Sarah}
  IF Looking = 'L'
  THEN
    WRITELN('The British are coming by land.')
  ELSE
    IF Looking = 'S'
    THEN
      WRITELN('The British coming by sea.')
    ELSE
      WRITELN('Sarah didn''t say')    
END. {Sarah revere}

