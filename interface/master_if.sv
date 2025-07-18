interface master_if#(parameter ADDR_WIDTH = 32; parameter DATA_WIDTH = 32);

    logic                       PCLK;
    logic                       PRESET;
    logic [ADDR_WIDTH-1:0]      PADDR;
    logic [2:0]                 PPROT;
    logic                       PNSE;
    logic                       PSEL;
    logic                       PENABLE;
    logic                       PWRITE;
    logic [DATA_WIDTH-1:0]      PWDATA;
    logic [(DATA_WIDTH/8)-1:0]  PSTRB;
    
    logic                       PREADY;
    logic [DATA_WIDTH-1:0]      PRDATA;
    logic                       PSLVERR;
    logic                       PWAKEUP;

endinterface: master_if