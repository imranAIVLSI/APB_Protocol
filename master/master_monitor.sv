class master_monitor extends uvm_monitor;
    `uvm_component_utils(master_monitor)

    // virtual master_interface mif;

    function new (string name, uvm_component parent);
        super.new(name , parent);
    endfunction

// ========================================= BUILD PHASE ============================================== 
//------------------------------------------------------------------------------------------------------ 
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        // if (!uvm_config_db #(virtual master_interface)::get(this, "", "mif", mif)) begin
        //     `uvm_fatal("NOCONFIG", "No master_interface configured for the monitor")
        // end
    endfunction

// ========================================= RUN TASK PHASE ============================================== 
//------------------------------------------------------------------------------------------------------ 
    task run_phase(uvm_phase phase);
            `uvm_info("MASTER_MONITOR", "Run Phase started", UVM_LOW)
    endtask

// ========================================= START OF SIMULATION PHASE ============================================== 
//------------------------------------------------------------------------------------------------------ 
    function void start_of_simulation_phase(uvm_phase phase);
            super.start_of_simulation_phase(phase);
            `uvm_info("MASTER_MONITOR", "Simulation started", UVM_LOW)
    endfunction

// ========================================= REPORT PHASE ============================================== 
//------------------------------------------------------------------------------------------------------ 
    function void report_phase(uvm_phase phase);
            super.report_phase(phase);
    endfunction

endclass