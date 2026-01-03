`include "uvm_macros.svh"
import uvm_pkg::*;

class axi_monitor extends uvm_component;
  `uvm_component_utils(axi_monitor)

  virtual axi_if vif;
  uvm_analysis_port #(axi_txn) ap;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    ap = new("ap", this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual axi_if)::get(this, "", "vif", vif))
      `uvm_fatal("NOVIF", "virtual interface vif not set for axi_monitor")
  endfunction

  task run_phase(uvm_phase phase);
    axi_txn t;

    forever begin
      @(posedge vif.ACLK);

      // Observe a completed write (very simplified)
      if (vif.AWVALID && vif.AWREADY && vif.WVALID && vif.WREADY) begin
        t = axi_txn::type_id::create("mon_wr");
        t.addr = vif.AWADDR;
        t.data = vif.WDATA;
        t.is_write = 1;
        ap.write(t);
      end

      // Observe a completed read address + data valid (simplified)
      if (vif.ARVALID && vif.ARREADY) begin
        // wait until RVALID to capture data
        wait (vif.RVALID);
        t = axi_txn::type_id::create("mon_rd");
        t.addr = vif.ARADDR;
        t.data = vif.RDATA;
        t.is_write = 0;
        ap.write(t);
      end
    end
  endtask
endclass
