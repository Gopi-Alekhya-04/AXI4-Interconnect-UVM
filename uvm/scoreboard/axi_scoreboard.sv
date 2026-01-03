`include "uvm_macros.svh"
import uvm_pkg::*;

class axi_scoreboard extends uvm_component;
  `uvm_component_utils(axi_scoreboard)

  uvm_analysis_imp #(axi_txn, axi_scoreboard) imp;

  // Simple expected memory model
  bit [31:0] exp_mem [bit [31:0]];

  function new(string name, uvm_component parent);
    super.new(name, parent);
    imp = new("imp", this);
  endfunction

  function void write(axi_txn t);
    if (t.is_write) begin
      exp_mem[t.addr] = t.data;
      `uvm_info("SB", $sformatf("WRITE captured: addr=0x%08h data=0x%08h", t.addr, t.data), UVM_LOW)
    end else begin
      if (exp_mem.exists(t.addr)) begin
        if (t.data === exp_mem[t.addr]) begin
          `uvm_info("SB", $sformatf("READ PASS: addr=0x%08h data=0x%08h", t.addr, t.data), UVM_LOW)
        end else begin
          `uvm_error("SB", $sformatf("READ FAIL: addr=0x%08h got=0x%08h exp=0x%08h",
                                      t.addr, t.data, exp_mem[t.addr]))
        end
      end else begin
        `uvm_warning("SB", $sformatf("READ with no expected entry: addr=0x%08h data=0x%08h", t.addr, t.data))
      end
    end
  endfunction
endclass
