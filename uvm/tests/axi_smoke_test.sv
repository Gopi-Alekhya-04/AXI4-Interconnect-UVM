`include "uvm_macros.svh"
import uvm_pkg::*;

class axi_smoke_test extends uvm_test;
  `uvm_component_utils(axi_smoke_test)

  axi_env env;

  function new(string name="axi_smoke_test", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = axi_env::type_id::create("env", this);
  endfunction

  task run_phase(uvm_phase phase);
    axi_base_seq seq;
    phase.raise_objection(this);

    `uvm_info("TEST", "Starting AXI smoke test", UVM_MEDIUM)

    seq = axi_base_seq::type_id::create("seq");
    seq.start(env.agent.sequencer);

    `uvm_info("TEST", "Completed AXI smoke test", UVM_MEDIUM)

    phase.drop_objection(this);
  endtask
endclass
