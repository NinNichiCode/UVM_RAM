class ram_monitor extends uvm_monitor;
   `uvm_component_utils(ram_monitor)


   uvm_analysis_port#(ram_item) item_send_port;
   
   function new(string name = "", uvm_component parent = null);
     super.new(name, parent);
     item_send_port = new("item_send_port", this);

   endfunction

   ram_item trans;
   virtual ram_if vif;


   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
 
       
 if(!uvm_config_db#(virtual ram_if)::get(this,"", "vif", vif) )
	  `uvm_fatal("MON", "cannot_access_interface");
   endfunction

   virtual task run_phase(uvm_phase phase);
      forever begin
       trans = ram_item::type_id::create("trans", this);
      @(posedge vif.clk);
         #1;
 
	 trans.wr = vif.wr;
	 trans.addr = vif.addr;
	 trans.din = vif.din;
         trans.dout = vif.dout;
      
         item_send_port.write(trans);
   
   `uvm_info("MON", $sformatf("wr = %0h, din = %0h, addr = %0h, dout = %0h", vif.wr, vif.din, vif.addr, vif.dout), UVM_LOW) 
   end

   endtask

endclass



