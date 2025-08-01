module master_top;
    import uvm_pkg::*;
    `include "uvm_macros.svh"

    import master_pkg::*;
    import slave_pkg::*;
    `include "apb_tb.sv"
    `include "master_test_lib.sv"

    bit clk = 0;
    bit PRESET;
    initial begin
        #10;
        PRESET = 1'b1;
    end

    always #5 clk = ~clk;
    apb_interface mif(.PCLK(clk), .PRESET(PRESET));


    initial begin
        // master_mif_config::set(null, "*", "mif", mif);
        uvm_config_db#(virtual apb_interface)::set(null, "*", "vif", mif);
        run_test();
    end
endmodule 

