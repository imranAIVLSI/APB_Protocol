class slave_env extends uvm_env;

    slave_agent agent;

    `uvm_component_utils(slave_env)

    function new(string name = "slave_env", uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        agent = slave_agent::type_id::create("agent", this);
    endfunction

endclass: slave_env