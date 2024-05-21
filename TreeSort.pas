UNIT TreeSort;  
INTERFACE                  

PROCEDURE AddToStorage(Word: STRING);{Add To Storage word}
PROCEDURE PrintWords(VAR FSort: TEXT);{Print dictionary}

IMPLEMENTATION  

TYPE 
  Tree = ^NodeType;
  NodeType = RECORD
               Word: STRING;
               Count: INTEGER;
               LLink, RLink: Tree
             END; 
VAR
  Root: Tree;
  
PROCEDURE Insert(VAR Ptr: Tree; Data: STRING);
{Insert word according to alphabet}
CONST 
  BeforeE = ['-', 'a'..'z', 'а'..'е'];
  AfterE = ['ж'..'я'];
VAR
  LastBook, Book: INTEGER;

PROCEDURE InsertShorterWord;{insert if shorter word is part of word}
BEGIN {InsertShorterWord}
  IF Book = Length(Data)
  THEN
    Insert(Ptr^.LLink, Data)
  ELSE
    IF Book = Length(Ptr^.Word)
    THEN
      Insert(Ptr^.RLink, Data);  
  Book := Book + 1
END; {InsertShorterWord} 

PROCEDURE CompareEachLetter;{Compare storage word letter with new word's letter}
VAR
  Ch, NewCh: CHAR;
BEGIN {CompareEachLetter}
  Ch := Ptr^.Word[Book];
  NewCh := Data[Book];  
  IF (Ch = 'ё') AND (NewCh IN BeforeE) OR 
     (NewCh = 'ё') AND (Ch IN AfterE) OR 
     (Ch <> 'ё') AND (NewCh <> 'ё') AND (NewCh < Ch)
  THEN
    Insert(Ptr^.LLink, Data) 
  ELSE
    Insert(Ptr^.RLink, Data);
  Book := LastBook + 1   
END; {CompareEachLetter}   
  
PROCEDURE Alphabetise;{Alphabetise words}  
BEGIN {Alphabetise}
  IF Length(Ptr^.Word) > Length(Data)
  THEN
    LastBook := Length(Data)
  ELSE
    LastBook := Length(Ptr^.Word);
  Book := 1;
  WHILE (Book <> LastBook + 1)
  DO      
    IF Ptr^.Word[Book] = Data[Book]
    THEN
      InsertShorterWord
    ELSE  
      CompareEachLetter      
END; {Alphabetise}
  
BEGIN {Insert}
  IF Ptr = NIL
  THEN
    BEGIN {Создаем лист со значением Data}
      NEW(Ptr);
      Ptr^.Word := Data;
      Ptr^.Count := 1;
      Ptr^.LLink := NIL;
      Ptr^.RLink := NIL
    END
  ELSE
    BEGIN  
      IF Ptr^.Word = Data
      THEN
        Ptr^.Count := Ptr^.Count + 1
      ELSE
        Alphabetise
    END      
END; {Insert}

PROCEDURE AddToStorage(Word: STRING);{front of procedure insert}
BEGIN {AddToStorage}
  Insert(Root, Word)
END; {AddToStorage} 

PROCEDURE PrintTree(VAR FSort: TEXT; Ptr: Tree);
{Print word tree with word count in file}
BEGIN {PrintTree}
  IF Ptr <> NIL
  THEN
    BEGIN
      PrintTree(FSort, Ptr^.LLink);
      WRITELN(FSort, Ptr^.Word, ' ', Ptr^.Count);
      PrintTree(FSort, Ptr^.RLink);
      DISPOSE(Ptr)
    END
END;  {PrintTree} 

PROCEDURE PrintWords(VAR FSort: TEXT);{front of procedure PrintTree}
BEGIN {PrintWords}
  PrintTree(FSort, Root)
END; {PrintWords}

BEGIN {TreeSort} 
  Root := NIL
END.  {TreeSort}
