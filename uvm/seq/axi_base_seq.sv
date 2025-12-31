`include "uvm_macros.svh"
import uvm_pkg::*;

class axi_base_seq extends uvm_sequence #(axi_txn);
  `uvm_object_utils(axi_base_seq)

  function new(string name="axi_base_seq");
    super.new(name);
  endfunction

  task body();
    axi_txn tr;

    `uvm_info(get_type_name(), "Starting AXI base sequence", UVM_MEDIUM)

    // WRITE transaction
    tr = axi_txn::type_id::create("wr_tr");
    start_item(tr);
      tr.addr     = 32'h0000_1000;
      tr.data     = 32'hDEAD_BEEF;
      tr.is_write = 1'b1;
    finish_item(tr);
    `uvm_info(get_type_name(), {"Issued WRITE: ", tr.convert2string()}, UVM_MEDIUM)

    // READ transaction
    tr = axi_txn::type_id::create("rd_tr");
    start_item(tr);
      tr.addr     = 32'h0000_1000;
      tr.data     = '0;
      tr.is_write = 1'b0;
    finish_item(tr);
    `uvm_info(get_type_name(), {"Issued READ: ", tr.convert2string()}, UVM_MEDIUM)
  endtask
endclass
