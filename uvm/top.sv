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

  initial begin
    // Make vif available to UVM components
    uvm_config_db#(virtual axi_if)::set(null, "*", "vif", axi_vif);
    run_test("axi_smoke_test");
  end

endmodule
