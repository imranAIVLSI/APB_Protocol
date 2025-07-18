class master_packet extends uvm_sequence_item ;
    parameter ADDR_WIDTH = 32;
    parameter DATA_WIDTH = 32;
    rand bit [DATA_WIDTH-1:0]   PWDATA;
    rand bit [DATA_WIDTH-1:0]   PADDR;
    bit                         PWRITE;
    bit [2:0]                   PPROT;     // Protection attributes
    bit                         PSEL;     // Select slave
    bit                         PENABLE; 
    bit [DATA_WIDTH/8-1:0]    PSTRB;     // Write strobe
    bit                       PWAKEUP;  

    // Master receives these signals (inputs)
    bit [DATA_WIDTH-1:0]       PRDATA;    // Read data
    bit                        PREADY;    // Slave ready
    bit                        PSLVERR;   // Error response
    


    `uvm_object_utils_begin(master_packet)
        `uvm_field_int(PADDR, UVM_ALL_ON)
        `uvm_field_int(PWDATA, UVM_ALL_ON)
        `uvm_field_int(PWRITE, UVM_ALL_ON)
        `uvm_field_int(PPROT, UVM_ALL_ON)
        `uvm_field_int(PSEL, UVM_ALL_ON)
        `uvm_field_int(PENABLE, UVM_ALL_ON)
        `uvm_field_int(PSTRB, UVM_ALL_ON)
        `uvm_field_int(PWAKEUP, UVM_ALL_ON)
        `uvm_field_int(PRDATA, UVM_ALL_ON)
        `uvm_field_int(PREADY, UVM_ALL_ON)
        `uvm_field_int(PSLVERR, UVM_ALL_ON)
    `uvm_object_utils_end

    function new(string name = " MASTER PACKET");
        super.new(name);
    endfunction
endclass