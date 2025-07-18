class master_sequencer extends uvm_sequencer #(master_packet);
    `uvm_component_utils(master_sequencer)

    // Constructor
    function new(string name , uvm_component parent);
        super.new(name , parent);
    endfunction

    function void start_of_simulation_phase(uvm_phase phase);
        super.start_of_simulation_phase(phase);
        `uvm_info(get_type_name(), "Running Simulation : MASTER SEQUENCER", UVM_HIGH)
    endfunction
endclass