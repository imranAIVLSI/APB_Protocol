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
        forever begin
            slave_packet pkt;
            @(posedge vif.PCLK);
            pkt = slave_packet::type_id::create("pkt");
            pkt.PADDR = vif.scb.PADDR;
            pkt.PWDATA = vif.scb.PWDATA;
            pkt.PWRITE = vif.scb.PWRITE;
            if(vif.PSEL ) begin
                @(posedge vif.PENABLE);
                `uvm_info(get_type_name(), " slave Enable high", UVM_LOW)
                pkt.PSEL = vif.PSEL;
                pkt.PENABLE = vif.PENABLE;
                // `uvm_info(get_type_name(), "slave driver select enable true condition", UVM_LOW)
               // @(posedge vif.PCLK);
                //@(posedge vif.PCLK);
                vif.PREADY = 1'b1;
                `uvm_info(get_type_name(), "slave Pready high", UVM_LOW)
                memory[pkt.PADDR] = pkt.PWDATA;
                pkt.PREADY = vif.PREADY;
                @(posedge vif.PCLK);
                vif.scb.PREADY <= 1'b0;
                #1ns;
                // if(!vif.scb.PENABLE)
            end
            else
                vif.PREADY <= 1'b0;


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