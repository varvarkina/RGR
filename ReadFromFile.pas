UNIT ReadFromFile; 
INTERFACE   
USES
  TreeSort;               
PROCEDURE ReadingWords(VAR FIn: TEXT);{Reading words from file}                   

IMPLEMENTATION
    
CONST
  LowerCase = ['a'..'z', 'à'..'ÿ', '¸'];
  UpperCase = ['À'..'ß', 'A'..'Z', '¨'];
  Alphabet = LowerCase + UpperCase;
  NonLetterCh = [' ', ')', ',', '.', '!', '?', ':', ';', '"', ']']; 
  ArrRegisterSwitchRu: ARRAY['À'..'ß'] OF CHAR = ('à', 'á', 'â', 'ã', 'ä', 'å', 
  'æ', 'ç', 'è', 'é', 'ê', 'ë', 'ì', 'í', 'î', 'ï', 'ð', 'ñ', 'ò', 'ó', 'ô', 
  'õ', 'ö', '÷', 'ø', 'ù', 'ú', 'û', 'ü', 'ý', 'þ', 'ÿ');  
  ArrRegisterSwitchEng: ARRAY['A'..'Z'] OF CHAR = ('a', 'b', 'c', 'd', 'e', 'f', 
  'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 
  'v', 'w', 'x', 'y', 'z');  
  
PROCEDURE ReadingWords(VAR FIn: TEXT);
{Reading words from file and add to the storage according to alphabet}
VAR
  Word: STRING;
  Ch: CHAR;
  WBegin, WEnd: BOOLEAN;
  Defis: INTEGER;

PROCEDURE Initializating;{initialise variables}
BEGIN {Initializating}
  Word := '';
  Defis := 0;
  WBegin := Ch IN Alphabet;                
  WEnd := FALSE
END; {Initializating}
     
FUNCTION RegisterSwitch(Ch1: CHAR): CHAR;{Convert upper case to lower case}
BEGIN {RegisterSwitch}
  RegisterSwitch := Ch1;
  CASE Ch1 OF
    '¨': RegisterSwitch := '¸';
    'A'..'Z': RegisterSwitch := ArrRegisterSwitchEng[Ch1];  
    'À'..'ß': RegisterSwitch := ArrRegisterSwitchRu[Ch1] 
  END
END; {RegisterSwitch}

PROCEDURE CheckDefisAndEnd;{Check if defis's significant, end of the word}
BEGIN {CheckDefisAndEnd}
  IF Ch = '-'
  THEN
    Defis := Defis + 1;  
  WEnd := (Ch IN NonLetterCh) OR (Defis = 2);
  IF (Ch IN Alphabet) AND (Defis = 1)
  THEN
    BEGIN
      Word := Word + '-';
      Defis := 0
    END 
END; {CheckDefisAndEnd}

BEGIN {ReadingWords}
  READ(FIn, Ch);
  Initializating;         
  WHILE (WBegin) AND (NOT WEnd)
  DO                                
    BEGIN
      Ch := RegisterSwitch(Ch);       
      IF Ch <> '-'
      THEN
        Word := Word + Ch;
      IF NOT EOLN(FIn)
      THEN  
        BEGIN
          READ(FIn, Ch);
          CheckDefisAndEnd         
        END
      ELSE
        BEGIN
          WBegin := FALSE;
          WEnd := TRUE
        END    
    END;
  IF WEnd
  THEN
    AddToStorage(Word)      
END; {ReadingWords}

BEGIN

END.
