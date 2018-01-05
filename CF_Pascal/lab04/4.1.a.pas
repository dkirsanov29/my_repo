PROGRAM PaulRevere(INPUT, OUTPUT);
VAR Lanterns: CHAR;
BEGIN
  READ(Lanterns);
  IF Lanterns >= '1'
  THEN
    IF Lanterns <= '2'
    THEN
      WRITE('The British are coming by ')
    ELSE
      WRITELN('The North church shows only ', Lanterns);
  IF Lanterns = '1'
  THEN
    WRITELN('land.');
  IF Lanterns = '2'
  THEN
    WRITELN('sea.')
END.
