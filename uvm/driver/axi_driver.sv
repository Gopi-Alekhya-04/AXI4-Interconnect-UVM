`include "uvm_macros.svh"
import uvm_pkg::*;

class axi_driver extends uvm_driver #(axi_txn);
  `uvm_component_utils(axi_driver)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    axi_txn tr;
    forever begin
      seq_item_port.get_next_item(tr);
      `uvm_info("DRV", {"Received: ", tr.convert2string()}, UVM_MEDIUM)

      // TODO (later): drive signals via virtual interface to DUT

      seq_item_port.item_done();
    end
  endtask
endclass
