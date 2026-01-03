`timescale 1ns/1ps
`include "uvm_macros.svh"
import uvm_pkg::*;

module top;

  logic ACLK;
  logic ARESETn;

  // Clock
  initial ACLK = 0;
  always #5 ACLK = ~ACLK;  // 100MHz

  // Reset
  initial begin
    ARESETn = 0;
    repeat (5) @(posedge ACLK);
    ARESETn = 1;
  end

  // Interface instance
  axi_if axi_vif(.ACLK(ACLK), .ARESETn(ARESETn));
  
  axi_slave_stub dut (
  .ACLK   (ACLK),
  .ARESETn(ARESETn),

  .AWADDR (axi_vif.AWADDR),
  .AWVALID(axi_vif.AWVALID),
  .AWREADY(axi_vif.AWREADY),

  .WDATA  (axi_vif.WDATA),
  .WVALID (axi_vif.WVALID),
  .WREADY (axi_vif.WREADY),

  .BRESP  (axi_vif.BRESP),
  .BVALID (axi_vif.BVALID),
  .BREADY (axi_vif.BREADY),

  .ARADDR (axi_vif.ARADDR),
  .ARVALID(axi_vif.ARVALID),
  .ARREADY(axi_vif.ARREADY),

  .RDATA  (axi_vif.RDATA),
  .RRESP  (axi_vif.RRESP),
  .RVALID (axi_vif.RVALID),
  .RREADY (axi_vif.RREADY)
);

  initial begin
    // Make vif available to UVM components
    uvm_config_db#(virtual axi_if)::set(null, "*", "vif", axi_vif);
    run_test("axi_smoke_test");
  end

endmodule
