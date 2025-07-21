class master_driver extends uvm_driver #(master_packet);
    virtual interface apb_interface vif; 
    `uvm_component_utils(master_driver)
    int pkts_sent = 0;
    int write_pkts = 0;
    int read_pkts = 0;
    function new(string name = "master_driver", uvm_component parent);
        super.new(name,parent);
        `uvm_info(get_type_name(), "=========== INSIDE MASTER DRIVER ===========", UVM_HIGH)
    endfunction

// ========================================= BUILD PHASE ============================================== 
//------------------------------------------------------------------------------------------------------ 
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(virtual apb_interface)::get(this, "", "vif", vif))
            `uvm_fatal("NOVIF", "VIF not get for Driver")
        // super.build_phase(phase);
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
                    seq_item_port.item_done(req);
                    pkts_sent++;
                    `uvm_info(get_type_name(), $sformatf("APB Packet: \n%s", req.sprint()), UVM_MEDIUM)
        end
endtask

// ========================================= REPORT PHASE ============================================== 
//------------------------------------------------------------------------------------------------------ 
int first_n=1;

    task send_to_slave(master_packet req);
    
        @(posedge vif.PCLK);

        vif.mcb.PWRITE  <= req.PWRITE;
        vif.mcb.PADDR   <= req.PADDR;
        vif.mcb.PWDATA  <= req.PWDATA;
        vif.mcb.PENABLE <= 1'b0;
        `uvm_info(get_type_name(), " Enable low", UVM_LOW)
       if(vif.mcb.PWRITE)
            write();
        else
            read();
        // if(vif.mcb.PWRITE) begin
        //     do begin
        //         @(posedge vif.mcb.PCLK);
        //         vif.mcb.PENABLE <= 1'b1;
        //         //  vif.mcb.PREADY <= 1'b1;
        //     end while(!vif.mcb.PREADY);

        //      @(posedge vif.mcb.PCLK);
        //      vif.mcb.PENABLE <= 1'b0;
        //     vif.mcb.PWRITE <= 1'b0;
        //     vif.mcb.PSEL <= 1'b0;
        //     // #1;
        // end
    endtask

    function void report_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "Master driver simulation complete", UVM_LOW)
        `uvm_info(get_type_name(), $sformatf("Master Driver Packets Sent: %0d", pkts_sent), UVM_LOW)
        `uvm_info(get_type_name(), $sformatf("Master Driver Write Packets: %0d", write_pkts), UVM_LOW)
    endfunction

    task write();
        write_pkts++;
        req.PSEL    = 1'b1;
        vif.PSEL    <= req.PSEL;
        @(posedge vif.PCLK);
        
            vif.PENABLE <= 1'b1;
             `uvm_info(get_type_name(), " Enable high", UVM_LOW)
        @(vif.mcb.PREADY);
          `uvm_info(get_type_name(), " master Pready high", UVM_LOW)
        @(posedge vif.PCLK);
        vif.mcb.PWRITE <= 1'b0;
        vif.mcb.PENABLE <= 1'b0;
        vif.mcb.PSEL <= 1'b0;
    endtask

    task read();
        read_pkts++;
        req.PSEL    = 1'b1;
        vif.mcb.PSEL    <= req.PSEL;
        @(posedge vif.PCLK);
            vif.mcb.PENABLE <= 1'b1;
        wait(vif.mcb.PREADY);
        vif.mcb.PENABLE <= 1'b0;
        vif.mcb.PSEL <= 1'b0;
    endtask
endclass
