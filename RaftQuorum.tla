----------------------------- MODULE RaftQuorum -----------------------------
EXTENDS Naturals, FiniteSets

CONSTANTS Robots, Epochs, Actions, Majority

CommittedRecords ==
  { <<e, i, a>> :
      e \in Epochs,
      i \in Robots,
      a \in Actions }

AllEdges ==
  { edge \in Robots \X Robots : edge[1] # edge[2] }

Networks ==
  SUBSET AllEdges

VARIABLES committed, net

Vars == <<committed, net>>

TypeOK ==
  /\ committed \subseteq CommittedRecords
  /\ net \in Networks

Init ==
  /\ committed = {}
  /\ net \in Networks

Reach(i) ==
  { j \in Robots : <<i, j>> \in net } \cup {i}

HasQuorum(i) ==
  Cardinality(Reach(i)) >= Majority

RaftCommit(i, e, a) ==
  /\ HasQuorum(i)
  /\ committed' = committed \cup {<<e, i, a>>}
  /\ UNCHANGED net

ChangeNet ==
  /\ net' \in Networks
  /\ UNCHANGED committed

Next ==
  \/ \E i \in Robots, e \in Epochs, a \in Actions :
        RaftCommit(i, e, a)
  \/ ChangeNet

Spec ==
  Init /\ [][Next]_Vars

NoMajorityReachable ==
  \A i \in Robots :
    Cardinality(Reach(i)) < Majority

AnyCommitEnabled ==
  ENABLED (
    \E i \in Robots, e \in Epochs, a \in Actions :
      RaftCommit(i, e, a)
  )

NoCommitWithoutQuorum ==
  NoMajorityReachable => ~AnyCommitEnabled

=============================================================================