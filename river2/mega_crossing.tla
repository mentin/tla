------------------------------ MODULE mega_crossing ------------------------------

EXTENDS Sequences, Integers 

VARIABLES locs

Things == { "Man", "Goat", "Wolf", "Cabbage" }
          
Init ==  locs = [x \in Things |-> FALSE]  (* nobody crossed *)

(* goat is either with man or not with wolf or cabbage *)
IsSafe == \/ locs'["Goat"] = locs'["Man"]
          \/ (/\ locs'["Goat"] /= locs'["Wolf"] 
              /\ locs'["Goat"] /= locs'["Cabbage"])

(* CrossWith("Man") is crossing alone *)              
CrossWith(x) == /\ locs["Man"] = locs[x]
                /\ locs' = [locs EXCEPT !["Man"] = ~locs[x], ![x] = ~locs[x]] 
  
Next == /\ (\E x \in Things : CrossWith(x))
        /\ IsSafe

(* assertion we trying to fail: everybody crossed *)
IsDone ==  locs = [x \in Things |-> TRUE]

=============================================================================
\* Modification History
\* Last modified Sun Jun 25 23:17:31 PDT 2017 by mentin
\* Created Fri Jun 16 21:37:52 PDT 2017 by mentin
