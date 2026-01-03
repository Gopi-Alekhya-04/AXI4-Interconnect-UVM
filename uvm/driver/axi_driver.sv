`include "uvm_macros.svh"
import uvm_pkg::*;

class axi_driver extends uvm_driver #(axi_txn);
  `uvm_component_utils(axi_driver)

  virtual axi_if vif;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual axi_if)::get(this, "", "vif", vif))
      `uvm_fatal("NOVIF", "virtual interface vif not set for axi_driver")
  endfunction

  task run_phase(uvm_phase phase);
    axi_txn tr;

    // Default idle values
    vif.AWVALID = 0; vif.WVALID = 0; vif.BREADY = 0;
    vif.ARVALID = 0; vif.RREADY = 0;

    forever begin
      seq_item_port.get_next_item(tr);
      `uvm_info("DRV", {"Driving: ", tr.convert2string()}, UVM_MEDIUM)

      if (tr.is_write) begin
        // Drive a simple write handshake (basic AXI-lite style)
        vif.AWADDR  <= tr.addr;
        vif.AWVALID <= 1;
        vif.WDATA   <= tr.data;
        vif.WVALID  <= 1;
        vif.BREADY  <= 1;

        // Wait for ready handshakes
        @(posedge vif.ACLK);
        wait (vif.AWREADY && vif.WREADY);

        // Deassert valids
        @(posedge vif.ACLK);
        vif.AWVALID <= 0;
        vif.WVALID  <= 0;

        // Wait for response
        wait (vif.BVALID);
        @(posedge vif.ACLK);
        vif.BREADY <= 0;

      end else begin
        // Drive a simple read handshake
        vif.ARADDR  <= tr.addr;
        vif.ARVALID <= 1;
        vif.RREADY  <= 1;

        @(posedge vif.ACLK);
        wait (vif.ARREADY);

        @(posedge vif.ACLK);
        vif.ARVALID <= 0;

        wait (vif.RVALID);
        @(posedge vif.ACLK);
        vif.RREADY <= 0;
      end

      seq_item_port.item_done();
    end
  endtask
endclass
