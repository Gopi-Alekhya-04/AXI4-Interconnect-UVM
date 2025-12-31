`include "uvm_macros.svh"
import uvm_pkg::*;

class axi_env extends uvm_env;
  `uvm_component_utils(axi_env)

  axi_agent agent;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agent = axi_agent::type_id::create("agent", this);
  endfunction
endclass
