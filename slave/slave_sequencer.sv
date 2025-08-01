class slave_sequencer extends uvm_sequencer #(slave_packet);
    `uvm_component_utils(slave_sequencer)

    // Constructor
    function new(string name = "slave_sequencer", uvm_component parent);
        super.new(name , parent);
    endfunction

    function void start_of_simulation_phase(uvm_phase phase);
        super.start_of_simulation_phase(phase);
        `uvm_info(get_type_name(), "Running Simulation : Slave SEQUENCER", UVM_HIGH)
    endfunction
endclass