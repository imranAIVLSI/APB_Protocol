class slave_agent extends uvm_agent;

    `uvm_component_utils(slave_agent)

    slave_driver driver;
    slave_monitor monitor;

    function new(string name = "slave_agent", uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        driver = slave_driver::type_id::create("driver", this);
        monitor = slave_monitor::type_id::create("monitor", this);
    endfunction

endclass: slave_agent