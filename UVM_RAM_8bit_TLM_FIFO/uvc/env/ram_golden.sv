class ram_golden extends uvm_monitor;
   `uvm_component_utils(ram_golden)


   uvm_analysis_port#(ram_item) item_golden_port;
   reg [7:0] mem [15:0];

   function new(string name = "", uvm_component parent = null);
     super.new(name, parent);
     item_golden_port = new("item_golden_port", this);

   endfunction

   ram_item trans;
   virtual ram_if vif;


   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
 
       
 if(!uvm_config_db#(virtual ram_if)::get(this,"", "vif", vif) )
	  `uvm_fatal("MON", "cannot_access_interface");
   endfunction

   function void predict();
      if(trans.wr) begin
	   mem[trans.addr] = trans.din;
      end else begin
	   trans.dout = mem[trans.addr];
      end
   endfunction

   virtual task run_phase(uvm_phase phase);
      forever begin
        trans = ram_item::type_id::create("trans",this);
      @(posedge vif.clk);
         #1;
 
	 trans.wr = vif.wr;
	 trans.addr = vif.addr;
	 trans.din = vif.din;
        
         predict();

   `uvm_info("GOLDEN_1", $sformatf("wr = %0h, dout = %0h", trans.wr, trans.dout), UVM_LOW) 
         item_golden_port.write(trans);
   
   `uvm_info("GOLDEN_2", $sformatf("wr = %0h, dout = %0h", trans.wr, trans.dout), UVM_LOW) 
   end

   endtask

endclass



