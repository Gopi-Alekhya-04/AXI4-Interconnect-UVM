`include "uvm_macros.svh"
import uvm_pkg::*;

class axi_scoreboard extends uvm_component;
  `uvm_component_utils(axi_scoreboard)

  uvm_analysis_imp #(axi_txn, axi_scoreboard) imp;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    imp = new("imp", this);
  endfunction

  // Called whenever monitor publishes a transaction
  function void write(axi_txn t);
    `uvm_info("SB", {"Observed: ", t.convert2string()}, UVM_MEDIUM)
    // TODO: add protocol/data checking and end-to-end comparisons
  endfunction
endclass
