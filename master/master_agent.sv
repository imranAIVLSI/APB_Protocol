class master_agent extends uvm_agent;
    `uvm_component_utils(master_agent)
    
master_driver driver;
master_sequencer sequencer;
master_monitor monitor;


function new(string name , uvm_component parent);
        super.new(name,parent);
    endfunction

// ========================================= BUILD PHASE ============================================== 
//------------------------------------------------------------------------------------------------------ 

virtual function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    monitor = master_monitor::type_id::create("monitor",this);
    if(is_active == UVM_ACTIVE) begin
        sequencer = master_sequencer::type_id::create("sequencer",this);
        driver = master_driver::type_id::create("driver",this);
    end
endfunction

// ========================================= CONNECT PHASE ============================================== 
//-------------------------------------------------------------------------------------------------------

virtual function void connect_phase(uvm_phase phase);
    if(is_active == UVM_ACTIVE)
        driver.seq_item_port.connect(sequencer.seq_item_export);
    endfunction
endclass