`include "uvm_macros.svh"
import uvm_pkg::*;

class axi_txn extends uvm_sequence_item;
  `uvm_object_utils(axi_txn)

  rand bit [31:0] addr;
  rand bit [31:0] data;
  rand bit        is_write;

  function new(string name="axi_txn");
    super.new(name);
  endfunction

  function string convert2string();
    return $sformatf("AXI_TXN addr=0x%08h data=0x%08h is_write=%0d", addr, data, is_write);
  endfunction
endclass
