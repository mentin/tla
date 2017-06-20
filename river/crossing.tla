------------------------------ MODULE crossing ------------------------------

EXTENDS Integers 

VARIABLES man, goat, cabbage, wolf   
          
TypeOK == /\ man \in {TRUE, FALSE}
          /\ goat \in {TRUE, FALSE}
          /\ cabbage \in {TRUE, FALSE}
          /\ wolf \in {TRUE, FALSE}
          
Init ==  /\ man = FALSE
         /\ goat = FALSE
         /\ cabbage = FALSE
         /\ wolf = FALSE

Safety == \/ man = goat
          \/ (goat /= cabbage /\ wolf /= goat)

IsSafe == \/ man' = goat'
          \/ (goat' /= cabbage' /\ wolf' /= goat')

CrossWith(move, stay1, stay2) ==
            /\ man = move 
            /\ man' = ~man
            /\ move' = ~move
            /\ stay1' = stay1
            /\ stay2' = stay2
            /\ IsSafe  
         
CrossAlone == /\ man' = ~man
              /\ goat' = goat
              /\ wolf' = wolf
              /\ cabbage' = cabbage
              /\ IsSafe
  
Next == \/ CrossWith(goat, wolf, cabbage)
        \/ CrossWith(wolf, cabbage, goat)    
        \/ CrossWith(cabbage, goat, wolf)
        \/ CrossAlone

Done ==  /\ man = TRUE
         /\ goat = TRUE
         /\ cabbage = TRUE
         /\ wolf = TRUE

=============================================================================
\* Modification History
\* Last modified Fri Jun 16 22:22:27 PDT 2017 by mentin
\* Created Fri Jun 16 21:37:52 PDT 2017 by mentin
