interface master_interface #(parameter ADDR_WIDTH = 32,
                            parameter DATA_WIDTH = 32 )
    (input PCLK , input PRESET);
    import uvm_pkg::*;
    import master_pkg::*;
    `include "uvm_macros.svh"

// Master drives these signals (outputs)
    logic [ADDR_WIDTH-1:0]       PADDR;     // Address
    logic [2:0]                  PPROT;     // Protection attributes
    logic                        PSEL;     // Select slave
    logic                        PENABLE;   // Enable transfer
    logic                        PWRITE;    // Write/read select
    logic [DATA_WIDTH-1:0]       PWDATA;    // Write data
    logic [DATA_WIDTH/8-1:0]     PSTRB;     // Write strobe
    logic                        PWAKEUP;   // Wake-up

    // Master receives these signals (inputs)
    logic [DATA_WIDTH-1:0]       PRDATA;    // Read data
    logic                        PREADY;    // Slave ready
    logic                        PSLVERR;   // Error response

endinterface
