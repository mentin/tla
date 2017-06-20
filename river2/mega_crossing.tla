------------------------------ MODULE mega_crossing ------------------------------

EXTENDS Sequences, Integers 

VARIABLES locs

Things == { "Man", "Goat", "Wolf", "Cabbage" }
          
Init ==  locs = [x \in Things |-> FALSE]  (* nobody crossed *)

(* goat is either with man or not with wolf or cabbage *)
IsSafe == \/ locs'["Goat"] = locs'["Man"]
          \/ (/\ locs'["Goat"] /= locs'["Wolf"] 
              /\ locs'["Goat"] /= locs'["Cabbage"])

CrossAlone == locs' = [locs EXCEPT !["Man"] = ~locs["Man"]]
              
CrossWith(x) == /\ locs["Man"] = locs[x]
                /\ locs' = [locs EXCEPT !["Man"] = ~locs[x], ![x] = ~locs[x]] 
  
Next == /\ (CrossAlone \/ CrossWith("Goat") \/ CrossWith("Wolf") \/ CrossWith("Cabbage"))
        /\ IsSafe

Spec == Init /\ [][Next]_<<locs>> 

IsDone ==  locs = [x \in Things |-> TRUE]  (* everybody crossed *)

=============================================================================
\* Modification History
\* Last modified Mon Jun 19 23:47:00 PDT 2017 by mentin
\* Created Fri Jun 16 21:37:52 PDT 2017 by mentin
