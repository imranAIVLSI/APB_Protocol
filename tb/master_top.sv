module master_top;
    import uvm_pkg::*;
    `include "uvm_macros.svh"

    import master_pkg::*;
    `include "apb_tb.sv"
    `include "master_test_lib.sv"

    bit clk = 0;
    always #5 clk = ~clk;
    master_interface mif(.PCLK(clk), .PRESET(1'b1));
    initial begin
        master_mif_config::set(null, "*", "mif", mif);
        run_test();
    end
endmodule 

