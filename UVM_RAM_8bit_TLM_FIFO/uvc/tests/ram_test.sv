class ram_test extends base_test;
    `uvm_component_utils(ram_test)

    function new(string name = "ram_test", uvm_component parent =null);
       super.new(name, parent);
    endfunction

   virtual task run_test_seq();
      ram_seq seq;
      seq = ram_seq::type_id::create("seq", this);
      seq.start(env.agent.seqr);
   endtask


 endclass
      


