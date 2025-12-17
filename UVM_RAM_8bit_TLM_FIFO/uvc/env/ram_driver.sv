class ram_driver extends uvm_driver#(ram_item);
   `uvm_component_utils(ram_driver)

   function new (string name = "", uvm_component parent = null);
      super.new(name, parent);
   endfunction

   ram_item trans;
   virtual ram_if vif;

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if(!uvm_config_db#(virtual ram_if)::get(this,"","vif", vif))
	  `uvm_fatal("DRV", "cannot access interface")

   endfunction

   virtual task run_phase(uvm_phase phase);
      forever begin
          @(negedge vif.clk);
          
       seq_item_port.get_next_item(trans);
          vif.wr <= trans.wr;
	  vif.din <= trans.din;
	  vif.addr <= trans.addr;

	  @(negedge vif.clk);
       seq_item_port.item_done();
   
   `uvm_info("DRV", $sformatf("wr = %0h, din = %0h, addr = %0h", trans.wr, trans.din, trans.addr), UVM_LOW) 

      end
    endtask

endclass

