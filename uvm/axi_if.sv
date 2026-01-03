interface axi_if(input logic ACLK, input logic ARESETn);

  // Write Address Channel
  logic [31:0] AWADDR;
  logic        AWVALID;
  logic        AWREADY;

  // Write Data Channel
  logic [31:0] WDATA;
  logic        WVALID;
  logic        WREADY;

  // Write Response Channel
  logic [1:0]  BRESP;
  logic        BVALID;
  logic        BREADY;

  // Read Address Channel
  logic [31:0] ARADDR;
  logic        ARVALID;
  logic        ARREADY;

  // Read Data Channel
  logic [31:0] RDATA;
  logic [1:0]  RRESP;
  logic        RVALID;
  logic        RREADY;

endinterface
