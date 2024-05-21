PROGRAM CountWords(INPUT, OUTPUT);
USES
  ReadFromFile, TreeSort;   
VAR
  FIn, FOut: TEXT;  
BEGIN
  //ASSIGN(FIn, 'ExampFull.txt');
  ASSIGN(FIn, 'book-war-and-peace.txt');
  ASSIGN(FOut, 'FOut.txt');
  RESET(FIn);
  REWRITE(FOut); 
  WHILE NOT EOF(FIn)
  DO
    BEGIN
      WHILE NOT EOLN(FIn)
      DO
        ReadingWords(FIn);
      READLN(FIn) 
    END;
  CLOSE(FIn);  
  PrintWords(FOut);
  CLOSE(FOut) 
END. 
