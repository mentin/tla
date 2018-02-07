-------------------------------- MODULE boat --------------------------------

EXTENDS Sequences, Integers, FiniteSets

CONSTANTS AllowedWeight, AllowedMoves
VARIABLES locs, boat, moves

People == { 60, 70, 80, 90, 100 }
Baggage == { 10, 20, 30, 40, 50 }
Things == People \union Baggage

 (* nobody crossed *) 
Init == /\ locs = [x \in Things |-> FALSE] 
        /\ boat = FALSE
        /\ moves = 0
        
RECURSIVE Sum(_)
Sum(S) == IF S = {} THEN 0 ELSE LET x == CHOOSE x \in S : TRUE IN  x + Sum(S \ {x})

GoodMove(onboat) == 
        /\ Sum(onboat) <= AllowedWeight
        /\ Cardinality(People \intersect onboat) > 0 (* at least one person *)

Next == /\ moves < AllowedMoves
        /\ \E onboat \in SUBSET {x \in Things : locs[x] = boat } : 
            /\ GoodMove(onboat)
            /\ boat' = ~boat
            /\ locs' = [x \in Things |-> IF (x \in onboat) THEN ~locs[x] ELSE locs[x] ]
            /\ moves' = moves + 1

(* assertion we trying to fail: everybody crossed *)
IsSolution ==  locs = [x \in Things |-> TRUE]

=============================================================================

