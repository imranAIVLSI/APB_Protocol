class apb_tb extends uvm_env;
    `uvm_component_utils(apb_tb)

    function new(string name = "apb_tb", uvm_component parent);
        super.new(name, parent);
    endfunction

    master_env m_env;
    slave_env s_env;
    task run_phase(uvm_phase phase);
        phase.raise_objection(this, "Starting Sequence....");
        #200ns;
        phase.drop_objection(this, "sequence complete");
    endtask

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        m_env = master_env::type_id::create("m_env", this);
        s_env = slave_env::type_id::create("s_env", this);
    endfunction

     function void start_of_simulation_phase(uvm_phase phase);
        super.start_of_simulation_phase(phase);
        `uvm_info(get_type_name(), "Running Simulation : MASTER ENVIRONMENT", UVM_HIGH)
    endfunction

endclass