# AXI4 Interconnect Design & UVM Verification

## Overview
This project implements a configurable AXI4 interconnect supporting multiple masters and slaves.  
A complete UVM-based verification environment is developed to validate AXI protocol behavior, arbitration, and transaction flow.

The verification architecture follows industry-standard UVM methodology used in modern SoC verification teams.

## RTL Components
- AXI interconnect top module
- Arbitration logic for multiple masters
- Address decoder
- AXI master interface
- AXI slave interface

## UVM Verification Environment
- AXI transaction (`axi_txn`)
- Base AXI sequence (`axi_base_seq`)
- AXI driver and sequencer
- AXI agent connecting sequencer and driver
- AXI environment instantiating the agent
- Smoke test (`axi_smoke_test`) to validate end-to-end UVM flow

## Directory Structure
rtl/ – Synthesizable RTL modules
uvm/ – UVM testbench
agent/ – Agent and sequencer
driver/ – Driver
env/ – Environment
seq/ – Sequences
tests/ – Testcases
sim/ – Simulation filelists

## How to Run (Example – Questa)
```bash
vlog -sv -f sim/filelist.f
vsim -c top -do "run -all; quit"
```
## Skills Demonstrated
- SystemVerilog (RTL and verification)
- UVM methodology (agent, driver, sequencer, env, tests)
- AXI4 protocol fundamentals
- Verification architecture and testbench design
- Transaction-level modeling
- Sequence-based stimulus generation
- Clean and scalable UVM hierarchy


