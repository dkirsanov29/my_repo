PROGRAM PaulRevere(INPUT, OUTPUT);
VAR Lanterns: CHAR;
BEGIN
  READ(Lanterns);
  IF Lanterns <> 'L'
  THEN
    WRITELN('The North church shows only ')
  ELSE
    BEGIN
      WRITE('The British are coming by ');
      READ(Lanterns);
      IF Lanterns = 'L'
      THEN
        WRITELN('sea.')
      ELSE
        WRITELN('land.')    
    END
END.      
