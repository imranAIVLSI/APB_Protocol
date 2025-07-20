class slave_driver extends uvm_driver#(slave_packet);

    virtual apb_interface sif;

    `uvm_component_utils(slave_driver)

    function new(string name = "slave_driver", uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!slave_sif_config::get(this, "", "sif", sif));
            `uvm_fatal("NOCONFIG", "No slave interface configured for driver")
    endfunction

    function void start_of_simulation_phase(uvm_phase phase);
        super.start_of_simulation_phase(phase);
        `uvm_info(get_type_name(), "Running Simulation: SLAVE Driver" , UVM_HIGH)
    endfunction 

    function void report_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "Master driver simulation complete", UVM_LOW)
    endfunction

endclass: slave_driver