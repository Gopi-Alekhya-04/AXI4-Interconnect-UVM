`include "uvm_macros.svh"
import uvm_pkg::*;

class axi_agent extends uvm_agent;
  `uvm_component_utils(axi_agent)

  axi_sequencer sequencer;
  axi_driver    driver;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    sequencer = axi_sequencer::type_id::create("sequencer", this);
    driver    = axi_driver   ::type_id::create("driver", this);
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    driver.seq_item_port.connect(sequencer.seq_item_export);
  endfunction
endclass
