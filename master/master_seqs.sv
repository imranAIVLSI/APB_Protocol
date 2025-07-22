class master_seqs extends uvm_sequence #(master_packet);
    `uvm_object_utils(master_seqs)

    function new(string name = "master_seqs");
        super.new(name);
    endfunction

    task pre_body();
        uvm_phase phase;
        `ifdef  UVM_VERSION_1_2
        phase = get_starting_phase();
        `else
        phase = starting_phase;
        `endif 
            phase.raise_objection(this, "Starting sequence");

    endtask

    task post_body();
        uvm_phase phase;
        `ifdef  UVM_VERSION_1_2
        phase = get_starting_phase();
        `else
        phase = starting_phase;
        `endif 
            phase.drop_objection(this, "Ending sequence");
        
    endtask

endclass

class test_seq extends master_seqs;
    `uvm_object_utils(test_seq)

    function new(string name = "test_seq");
        super.new(name);
    endfunction

    task body();
        `uvm_do_with (req, {PWRITE == 1;
                            PADDR == 32'h0;})
        `uvm_info(get_type_name(), "sequence 1", UVM_MEDIUM)
        `uvm_do_with (req, {PWRITE == 1;
                            PADDR == 32'h1;})
        `uvm_info(get_type_name(), "sequence 2", UVM_MEDIUM)
        `uvm_do_with (req, {PWRITE == 1;
                            PADDR == 32'h2;})
        `uvm_info(get_type_name(), "sequence 3", UVM_MEDIUM)
        // `uvm_do_with (req, {PWRITE == 0;
        //                     PADDR == 32'h0;})
        // `uvm_info(get_type_name(), "sequence 4", UVM_MEDIUM)
        // `uvm_do_with (req, {PWRITE == 0;
        //                     PADDR == 32'h1;})
        // `uvm_info(get_type_name(), "sequence 5", UVM_MEDIUM)
        // `uvm_do_with (req, {PWRITE == 0;
        //                     PADDR == 32'h2;})
        // `uvm_info(get_type_name(), "sequence 6", UVM_MEDIUM)
        // `uvm_do_with (req, {PWRITE == 0;
        //                     PADDR == 32'b1;})
        // `uvm_info(get_type_name(), "sequence 7", UVM_MEDIUM)
        // `uvm_info(get_type_name(), $sformatf("APB Packet: \n%s", req.sprint()), UVM_MEDIUM)
    endtask

endclass: test_seq