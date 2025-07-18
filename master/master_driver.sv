class master_driver extends uvm_driver #(master_packet);
    virtual interface master_interface mif; 
    `uvm_component_utils(master_driver)

    function new(string name = "master_driver", uvm_component parent);
        super.new(name,parent);
        `uvm_info(get_type_name(), "=========== INSIDE MASTER DRIVER ===========", UVM_HIGH)
    endfunction

// ========================================= BUILD PHASE ============================================== 
//------------------------------------------------------------------------------------------------------ 
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!master_mif_config::get(this, "", "mif", mif))
            `uvm_fatal("NOVIF", "VIF not get for Driver")
        super.build_phase(phase);
    endfunction

// ========================================= START OF SIMULATION PHASE =================================
//------------------------------------------------------------------------------------------------------ 
    function void start_of_simulation_phase(uvm_phase phase);
        super.start_of_simulation_phase(phase);
        `uvm_info(get_type_name(), "Running Simulation: MASTER Driver" , UVM_HIGH)
    endfunction 

// ========================================= RUN TASK PHASE ============================================== 
//------------------------------------------------------------------------------------------------------ 
  task run_phase(uvm_phase phase);
        // master_packet pkt;
        forever begin
            seq_item_port.get_next_item(req);
            `uvm_info(get_type_name, " Driver Run Phase", UVM_HIGH)
            send_to_slave(req);
            seq_item_port.item_done();
            `uvm_info(get_type_name(), $sformatf("APB Packet: \n%s", req.sprint()), UVM_MEDIUM)
        end
endtask

// ========================================= REPORT PHASE ============================================== 
//------------------------------------------------------------------------------------------------------ 
    function void report_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "Master driver simulation complete", UVM_LOW)
    endfunction

    task send_to_slave(master_packet req);
        @(posedge mif.PCLK);
        req.PSEL = 1'b1;
        mif.PWRITE = req.PWRITE;
        mif.PSEL <= req.PSEL;
        mif.PADDR <= req.PADDR;
        mif.PWDATA <= req.PWDATA;
       
        if(mif.PWRITE) begin
            do begin
                //  @(posedge mif.PCLK);
                @(posedge mif.PCLK);
                 mif.PENABLE <= 1'b1;
                 mif.PREADY <= 1'b1;
            end while(!mif.PREADY);
            @(posedge mif.PCLK);
            mif.PENABLE <= 1'b0;
        end
    endtask

endclass
