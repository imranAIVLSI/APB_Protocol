package master_pkg;
   import uvm_pkg::*;
    `include "uvm_macros.svh"
    typedef uvm_config_db #(virtual master_interface) master_mif_config;
    
    `include "master_packet.sv"
    `include "master_monitor.sv"
    `include "master_sequencer.sv"
    `include "master_seqs.sv"
    `include "master_driver.sv"
    `include "master_agent.sv"
    `include "master_env.sv"
   // `include "master_env.sv"

endpackage : master_pkg