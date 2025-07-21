class master_test extends uvm_test;
    `uvm_component_utils(master_test)

    // Constructor
    function new(string name , uvm_component parent);
        super.new(name , parent);
    endfunction

    apb_tb tb;

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        tb=apb_tb::type_id::create("tb", this);
        uvm_config_int::set(this, "*", "recording_detail", 1);
        uvm_config_db#(uvm_object_wrapper)::set(this, "tb.m_env.agent.sequencer.run_phase", "default_sequence", test_seq::get_type());
    endfunction

    function void start_of_simulation_phase(uvm_phase phase);
        super.start_of_simulation_phase(phase);
        `uvm_info(get_type_name(), "Running Simulation : MASTER Test", UVM_HIGH)
    endfunction


     function void end_of_elaboration_phase(uvm_phase phase);
        uvm_top.print_topology();
        `uvm_info(get_type_name(), "Elaboration phase : MASTER TeSt", UVM_HIGH)
    endfunction
endclass
