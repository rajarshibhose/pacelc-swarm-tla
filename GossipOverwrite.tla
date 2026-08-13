-------------------------- MODULE GossipOverwrite ---------------------------
EXTENDS Naturals, FiniteSets

CONSTANTS Robots, Epochs, Actions, NoAction

AllActions ==
  Actions \cup {NoAction}

AllPairs ==
  { p \in Robots \X Robots : p[1] # p[2] }

Messages ==
  { <<p[1], p[2], e, a>> :
      p \in AllPairs,
      e \in Epochs,
      a \in Actions }

VARIABLES gstate, msgs

Vars == <<gstate, msgs>>

TypeOK ==
  /\ gstate \in [Robots -> [Epochs -> AllActions]]
  /\ msgs \subseteq Messages

Init ==
  /\ gstate = [i \in Robots |->
                 [e \in Epochs |-> NoAction]]
  /\ msgs = {}

GossipPropose(i, e, a) ==
  /\ gstate' = [gstate EXCEPT ![i][e] = a]
  /\ msgs' = msgs \cup
       { <<i, j, e, a>> :
           j \in (Robots \ {i}) }

GossipDeliver(m) ==
  /\ m \in msgs
  /\ gstate' = [gstate EXCEPT ![m[2]][m[3]] = m[4]]
  /\ msgs' = msgs \ {m}

Next ==
  \/ \E i \in Robots, e \in Epochs, a \in Actions :
        GossipPropose(i, e, a)
  \/ \E m \in msgs :
        GossipDeliver(m)

Spec ==
  Init /\ [][Next]_Vars

Diverged ==
  \E e \in Epochs, i \in Robots, j \in Robots :
    /\ i # j
    /\ gstate[i][e] # NoAction
    /\ gstate[j][e] # NoAction
    /\ gstate[i][e] # gstate[j][e]

DoneDiverged ==
  /\ msgs = {}
  /\ Diverged

NoDoneDivergence ==
  ~DoneDiverged

=============================================================================