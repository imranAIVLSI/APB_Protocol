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
        repeat(5)begin
        `uvm_do_with (req, {PWRITE == 1;})
        // `uvm_info(get_type_name(), $sformatf("APB Packet: \n%s", req.sprint()), UVM_MEDIUM)
        end
    endtask

endclass: test_seq