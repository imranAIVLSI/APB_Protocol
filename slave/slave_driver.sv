class slave_driver extends uvm_driver#(slave_packet);

    virtual apb_interface vif;
    logic [31:0] memory [255:0];
    `uvm_component_utils(slave_driver)

    function new(string name = "slave_driver", uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db #(virtual apb_interface)::get(this," ", "vif", vif))
            `uvm_fatal("NOCONFIG", "No slave interface configured for driver")

            //  if(!uvm_config_db#(virtual apb_interface)::get(this, "", "vif", vif))
            // `uvm_fatal("NOVIF", "VIF not get for Driver")
    endfunction

    task run_phase(uvm_phase phase);
        wait(vif.PRESET);
        forever begin
            slave_packet pkt;
            @(posedge vif.PCLK);
            pkt = slave_packet::type_id::create("pkt");
            pkt.PADDR = vif.scb.PADDR;
            pkt.PWDATA = vif.scb.PWDATA;
            pkt.PWRITE = vif.scb.PWRITE;
            if(vif.scb.PWRITE) begin
                if(vif.scb.PSEL) begin
                    @(posedge vif.scb.PENABLE);
                    pkt.PSEL = vif.scb.PSEL;
                    pkt.PENABLE = vif.scb.PENABLE;
                    vif.scb.PREADY <= 1'b1;
                    memory[pkt.PADDR] = pkt.PWDATA;
                    pkt.PREADY = vif.scb.PREADY;
                    @(posedge vif.PCLK);
                    vif.scb.PREADY <= 1'b0;
                    // #1ns;
                    // if(!vif.slave.PENABLE)
                end
                else
                    vif.scb.PREADY <= 1'b0;
            end
            else if(!vif.scb.PWRITE)begin
                if(vif.scb.PSEL) begin
                    @(posedge vif.scb.PENABLE);
                    pkt.PSEL = vif.scb.PSEL;
                    pkt.PENABLE = vif.scb.PENABLE;
                    vif.scb.PREADY <= 1'b1;
                    // #1ns;
                    vif.scb.PRDATA <= memory[pkt.PADDR];
                    // vif.slave.PRDATA <= 32'b10;
                    pkt.PRDATA = memory[pkt.PADDR];
                    pkt.PREADY = vif.scb.PREADY;
                    @(posedge vif.PCLK);
                    vif.scb.PREADY <= 1'b0;
                    // #1ns;
                    // if(!vif.scbslave.PENABLE)
                end
                else
                    vif.scb.PREADY <= 1'b0;
            
            end


        `uvm_info(get_type_name(), $sformatf("APB slave Packet: \n%s", pkt.sprint()), UVM_MEDIUM)
        end

    endtask

    function void start_of_simulation_phase(uvm_phase phase);
        super.start_of_simulation_phase(phase);
        `uvm_info(get_type_name(), "Running Simulation: SLAVE Driver" , UVM_HIGH)
    endfunction 

    function void report_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "Master driver simulation complete", UVM_LOW)
    endfunction

endclass: slave_driver