# PACELC Swarm Coordination TLA+ Models

This repository contains the TLA+/TLC models used for the paper
"Measured-Divergence Coordination for Mobile Swarms: A PACELC Analysis
of CRDT Replication versus Linearizable Agreement."

## Models

- `CRDTIntent.tla` / `CRDTIntent.cfg`:
  finite CRDT intent-lattice model checking type safety and local proposal
  enablement under network changes.

- `CRDTIntent_N3.cfg`:
  three-robot TLC configuration used for the reported CRDT model-checking run.

- `RaftQuorum.tla` / `RaftQuorum.cfg`:
  quorum-gated intent replication abstraction checking no-quorum
  non-progress.

- `GossipOverwrite.tla` / `GossipOverwrite.cfg`:
  overwrite-by-arrival gossip baseline used to produce a divergence
  counterexample.

## TLC result summaries

Raw TLC `.out` files are not included because TLC emits local machine
paths. Sanitized result summaries are provided under `tlc-results/`.

## Scope

These models verify coordination-state properties only. They do not model
continuous-time robot dynamics, sensing noise, obstacle avoidance,
collision freedom, actuator limits, or platform-level control stability.

## Running TLC

Run each model with its corresponding configuration file, for example:

```bash
tlc2.TLC CRDTIntent.tla -config CRDTIntent.cfg
tlc2.TLC RaftQuorum.tla -config RaftQuorum.cfg
tlc2.TLC GossipOverwrite.tla -config GossipOverwrite.cfg
