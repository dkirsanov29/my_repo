PROGRAM SarahRevere (INPUT, OUTPUT);
{������ ��������� � ��� ��� ���� ��������,
� ����������� �� ����, ������ �� ����� �����������
'land' ��� 'sea'.}
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
      { ������� ����, ��������� ����� ������}
      W1 := W2;
      W2 := W3;
      W3 := W4;
      READ(W4);
      WRITE(W1, W2, W3, W4);
      IF W4 = '#'
      THEN {����� ������}
        Looking := 'N'
      { �������� ���� ��� 'land'}
      { �������� ���� ��� 'sea'}
    END;
  WRITELN;
  WRITELN('Looking is ', Looking)  
  {������� ��������� Sarah}
END. {Sarah revere}

