# TLC Result Summary

Raw TLC `.out` files are not included because TLC emits local machine
paths. This directory records the model-checking results used in the
paper.

| Model | Robots | Property | Result | Generated | Distinct | Diameter |
|---|---:|---|---|---:|---:|---:|
| CRDTIntent | 3 | TypeOK, ProposalEnabled | Passed | 3,088,512 | 45,632 | 9 |
| RaftQuorum | 3 | TypeOK, NoCommitWithoutQuorum | Passed | 280,640 | 4,096 | 8 |
| GossipOverwrite | 3 | NoDoneDivergence | Counterexample found | 10,584 | 3,120 | 7 |

These values were copied from TLC runs used for the paper.
