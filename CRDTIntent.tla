----------------------------- MODULE CRDTIntent -----------------------------
EXTENDS Naturals, FiniteSets

CONSTANTS Robots, Epochs, Actions, MaxCtr

Votes ==
  { <<e, i, c, a>> :
      e \in Epochs,
      i \in Robots,
      c \in 1..MaxCtr,
      a \in Actions }

AllEdges ==
  { edge \in Robots \X Robots : edge[1] # edge[2] }

Networks ==
  SUBSET AllEdges

VARIABLES S, ctr, net

Vars == <<S, ctr, net>>

TypeOK ==
  /\ S \in [Robots -> SUBSET Votes]
  /\ ctr \in [Robots -> 0..MaxCtr]
  /\ net \in Networks

Init ==
  /\ S = [i \in Robots |-> {}]
  /\ ctr = [i \in Robots |-> 0]
  /\ net \in Networks

CRDTPropose(i, e, a) ==
  /\ ctr[i] < MaxCtr
  /\ LET newCtr == ctr[i] + 1 IN
       /\ ctr' = [ctr EXCEPT ![i] = newCtr]
       /\ S' = [S EXCEPT ![i] =
             @ \cup {<<e, i, newCtr, a>>}]
  /\ UNCHANGED net

CRDTMerge(i, j) ==
  /\ <<i, j>> \in net
  /\ S' = [S EXCEPT ![j] = @ \cup S[i]]
  /\ UNCHANGED <<ctr, net>>

ChangeNet ==
  /\ net' \in Networks
  /\ UNCHANGED <<S, ctr>>

Next ==
  \/ \E i \in Robots, e \in Epochs, a \in Actions :
        CRDTPropose(i, e, a)
  \/ \E i \in Robots, j \in Robots :
        CRDTMerge(i, j)
  \/ ChangeNet

Spec ==
  Init /\ [][Next]_Vars

ProposalEnabled ==
  \A i \in Robots :
    ctr[i] < MaxCtr =>
      ENABLED \E e \in Epochs, a \in Actions :
        CRDTPropose(i, e, a)

=============================================================================