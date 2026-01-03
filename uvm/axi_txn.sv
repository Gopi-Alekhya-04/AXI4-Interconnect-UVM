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
    return $sformatf("AXI_TXN addr=0x%08h data=0x%08h is_write=%0d",
                     addr, data, is_write);
  endfunction

  // UVM standard methods (helpful for debug + scoreboard usage)
  function void do_copy(uvm_object rhs);
    axi_txn rhs_t;
    if (!$cast(rhs_t, rhs)) begin
      `uvm_fatal("COPY", "do_copy: cast failed")
    end
    super.do_copy(rhs);
    addr     = rhs_t.addr;
    data     = rhs_t.data;
    is_write = rhs_t.is_write;
  endfunction

  function bit do_compare(uvm_object rhs, uvm_comparer comparer);
    axi_txn rhs_t;
    if (!$cast(rhs_t, rhs)) return 0;
    if (!super.do_compare(rhs, comparer)) return 0;
    return (addr == rhs_t.addr) && (data == rhs_t.data) && (is_write == rhs_t.is_write);
  endfunction

  function void do_print(uvm_printer printer);
    super.do_print(printer);
    printer.print_field_int("addr", addr, 32, UVM_HEX);
    printer.print_field_int("data", data, 32, UVM_HEX);
    printer.print_field_int("is_write", is_write, 1, UVM_DEC);
  endfunction

endclass
