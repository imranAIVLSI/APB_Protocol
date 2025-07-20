class master_monitor extends uvm_monitor;
    `uvm_component_utils(master_monitor)

    virtual apb_interface mif;

    function new (string name, uvm_component parent);
        super.new(name , parent);
    endfunction

// ========================================= BUILD PHASE ============================================== 
//------------------------------------------------------------------------------------------------------ 
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db #(virtual apb_interface)::get(this, "", "mif", mif)) begin
            `uvm_fatal("NOCONFIG", "No master_interface configured for the monitor")
        end
    endfunction

// ========================================= RUN TASK PHASE ============================================== 
//------------------------------------------------------------------------------------------------------ 
    task run_phase(uvm_phase phase);
            `uvm_info("MASTER_MONITOR", "Run Phase started", UVM_LOW)
            forever begin
                master_packet mpkt;
                mpkt = master_packet::type_id::create("mpkt");
                collect_packet(mpkt);
                `uvm_info(get_type_name(), $sformatf("[%0d] Monitor Packet: \n%s",$time, mpkt.sprint()), UVM_MEDIUM)
            end

    endtask

// ========================================= START OF SIMULATION PHASE ============================================== 
//------------------------------------------------------------------------------------------------------ 
    function void start_of_simulation_phase(uvm_phase phase);
            super.start_of_simulation_phase(phase);
            `uvm_info("MASTER_MONITOR", "Simulation started", UVM_LOW)
    endfunction

// ========================================= REPORT PHASE ============================================== 
//------------------------------------------------------------------------------------------------------ 
    function void report_phase(uvm_phase phase);
            super.report_phase(phase);
    endfunction


    task collect_packet(master_packet pkt);
        @(posedge mif.PCLK);
        pkt.PADDR = mif.PADDR;
        pkt.PWDATA = mif.PWDATA;
        pkt.PSEL = mif.PSEL;
        pkt.PWRITE = mif.PWRITE;

        if(mif.PWRITE) begin
        do begin
        //  @(posedge mif.PCLK);
        @(posedge mif.PCLK);
            pkt.PENABLE = mif.PENABLE;
            pkt.PREADY = mif.PREADY;
        end while(!mif.PREADY);
        @(posedge mif.PCLK);
        pkt.PENABLE =  mif.PENABLE;
        end
    endtask

endclass