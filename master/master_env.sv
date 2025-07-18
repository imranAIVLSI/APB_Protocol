class master_env extends uvm_env;
`uvm_component_utils(master_env)

    function new(string name , uvm_component parent);
        super.new(name,parent);
    endfunction

    master_agent agent;

// ========================================= BUILD PHASE ============================================== 
//------------------------------------------------------------------------------------------------------ 
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        agent = master_agent::type_id::create("agent", this);
    endfunction

// ========================================= START OF SIMULATION PHASE ==================================
//-------------------------------------------------------------------------------------------------------
    function void start_of_simulation_phase(uvm_phase phase);
        super.start_of_simulation_phase(phase);
        `uvm_info(get_type_name(), "Running Simulation : MASTER ENVIRONMENT", UVM_HIGH)
    endfunction
endclass