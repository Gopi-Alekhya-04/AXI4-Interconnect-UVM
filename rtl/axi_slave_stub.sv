module axi_slave_stub (
  input  logic        ACLK,
  input  logic        ARESETn,

  // Write Address
  input  logic [31:0] AWADDR,
  input  logic        AWVALID,
  output logic        AWREADY,

  // Write Data
  input  logic [31:0] WDATA,
  input  logic        WVALID,
  output logic        WREADY,

  // Write Response
  output logic [1:0]  BRESP,
  output logic        BVALID,
  input  logic        BREADY,

  // Read Address
  input  logic [31:0] ARADDR,
  input  logic        ARVALID,
  output logic        ARREADY,

  // Read Data
  output logic [31:0] RDATA,
  output logic [1:0]  RRESP,
  output logic        RVALID,
  input  logic        RREADY
);

  // Simple 256-word memory
  logic [31:0] mem [0:255];

  // Ready behavior (always ready when not in reset)
  always_comb begin
    AWREADY = ARESETn;
    WREADY  = ARESETn;
    ARREADY = ARESETn;
  end

  // Default responses
  always_ff @(posedge ACLK or negedge ARESETn) begin
    if (!ARESETn) begin
      BVALID <= 0;
      BRESP  <= 2'b00;
      RVALID <= 0;
      RRESP  <= 2'b00;
      RDATA  <= '0;
    end else begin
      // WRITE: capture when both valids are asserted (simplified)
      if (AWVALID && AWREADY && WVALID && WREADY) begin
        mem[AWADDR[9:2]] <= WDATA;    // word address
        BVALID <= 1;
        BRESP  <= 2'b00;              // OKAY
      end

      // complete write response handshake
      if (BVALID && BREADY) begin
        BVALID <= 0;
      end

      // READ: on AR handshake, present data and assert RVALID
      if (ARVALID && ARREADY) begin
        RDATA <= mem[ARADDR[9:2]];
        RVALID <= 1;
        RRESP  <= 2'b00;              // OKAY
      end

      // complete read data handshake
      if (RVALID && RREADY) begin
        RVALID <= 0;
      end
    end
  end

endmodule
