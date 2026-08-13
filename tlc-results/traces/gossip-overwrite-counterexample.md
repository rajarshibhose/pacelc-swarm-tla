# GossipOverwrite Counterexample Summary

The TLC run for `GossipOverwrite.tla` finds a counterexample to the
`NoDoneDivergence` invariant.

Terminal state summary:

- all messages have been delivered
- r1 decides a2
- r2 decides a2
- r3 decides a1

This demonstrates that overwrite-by-arrival dissemination can terminate
with different robots holding different decisions for the same epoch.
The counterexample supports the paper's claim that dissemination alone
is not sufficient for deterministic convergence.
