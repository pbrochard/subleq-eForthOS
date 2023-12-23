variable cnt 0 cnt !
variable quote char ' quote !

: label ." .not_" cnt @ s>d <# #s #> type ;
: .quoted quote @ emit emit quote @ emit ;
: .mapped ." .mapped" cr ;


: map
   swap
   cnt @ 1+ cnt !
   ."     cmp al, " .quoted cr
   ."     jne " label cr
   ."     mov al, " .quoted cr
   ."     jmp .mapped" cr
   label ." :" cr
   cr
;

char ;  char m  map
char a  char q  map
char q  char a  map
char w  char z  map
char z  char w  map
char :  char M  map

char A  char Q  map
char Q  char A  map
char Z  char W  map
char W  char Z  map

char \  char <  map
char |  char >  map

char m  char ,  map
char M  char ?  map
char ,  char ;  map
char <  char .  map
char .  char :  map
char >  char /  map
char /  char !  map
char =  char +  map
char +  char =  map
char #  char "  map
char !  char &  map
char @  char ~  map
char %  char (  map
char _  char )  map
char ^  char |  map
char &  char `  map
char *  char \  map
char (  char ^  map
char )  char @  map
char `  char _  map
char ?  char _  map

char " quote !
char '  char *  map
char $  char '  map

.mapped

bye
