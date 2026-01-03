`include "uvm_macros.svh"
import uvm_pkg::*;

class axi_rand_smoke_test extends uvm_test;
  `uvm_component_utils(axi_rand_smoke_test)

  axi_env env;
  int unsigned num_iters = 50;   // default

  function new(string name="axi_rand_smoke_test", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = axi_env::type_id::create("env", this);

    // Optional override: +NUM_ITERS=200
    void'($value$plusargs("NUM_ITERS=%0d", num_iters));
  endfunction

  task run_phase(uvm_phase phase);
    axi_base_seq seq;

    phase.raise_objection(this);
    `uvm_info("TEST",
      $sformatf("Starting AXI rand smoke test (NUM_ITERS=%0d)", num_iters),
      UVM_MEDIUM)

    repeat (num_iters) begin
      seq = axi_base_seq::type_id::create($sformatf("seq_%0d", $time));

      // If axi_base_seq has rand knobs, this will randomize them.
      // If it doesn't, randomize() will simply return 1 (still fine).
      if (!seq.randomize()) begin
        `uvm_warning("RAND", "axi_base_seq randomize() failed; continuing with defaults")
      end

      seq.start(env.agent.sequencer);
    end

    `uvm_info("TEST", "Completed AXI rand smoke test", UVM_MEDIUM)
    phase.drop_objection(this);
  endtask
endclass
