variable cnt 0 cnt !
variable quote char ' quote !

: label ." .not_" cnt @ s>d <# #s #> type ;
: .quoted quote @ emit emit quote @ emit ;

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

: | char ;
: => char map ;
