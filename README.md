# AXI4 Interconnect Design & UVM Verification

## Overview
This project implements a configurable **AXI4 interconnect** supporting multiple masters and slaves.  
A complete **UVM-based verification environment** is developed to validate AXI protocol behavior, arbitration, and end-to-end transaction flow.

The verification architecture follows industry-standard UVM methodology used in modern SoC verification teams.

---

## RTL Components
- AXI interconnect top module
- Arbitration logic for multiple masters
- Address decoder
- AXI master interface
- AXI slave interface (stub for verification)

---

## UVM Verification Environment
- Transaction: `axi_txn`
- Sequences: `axi_base_seq`
- Driver + Sequencer
- Agent (connects sequencer/driver)
- Environment (instantiates agent, monitor, scoreboard)
- Tests:
  - `axi_smoke_test` (basic end-to-end bring-up)
  - `axi_rand_smoke_test` (randomized read/write stimulus)

---

## Directory Structure
rtl/ Synthesizable RTL modules
uvm/ UVM testbench
agent/ Agent + Sequencer
driver/ Driver
env/ Environment
monitor/ Monitor
scoreboard/Scoreboard
seq/ Sequences
tests/ Testcases
sim/ Simulation file lists
docs/ Documentation


---

## Simulation (VCS - UVM)
This project is intended to be run using **Synopsys VCS** on a licensed Linux environment (university/company EDA server).

### Build
```bash
vcs -full64 -sverilog -ntb_opts uvm -timescale=1ns/1ps -f sim/filelist.f -o simv

./simv +UVM_TESTNAME=axi_smoke_test +UVM_VERBOSITY=UVM_MEDIUM

./simv +UVM_TESTNAME=axi_rand_smoke_test +UVM_VERBOSITY=UVM_MEDIUM
```
## Expected Output (Summary)
```bash
UVM test starts successfully

Driver issues AXI write/read transactions

Monitor publishes observed transactions

Scoreboard stores expected data on WRITE and checks READ data matches

No mismatches reported (UVM_ERROR not triggered)
```

## Skills Demonstrated

SystemVerilog (RTL + verification)

UVM methodology (agent, sequencer, driver, env, monitor, scoreboard)

AXI4 protocol fundamentals

Transaction-level modeling and sequence-based stimulus generation

Debug-oriented logging and scalable testbench structure