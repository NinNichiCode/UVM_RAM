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
    @(vif.mon_cb);
    trans.wr   = vif.mon_cb.wr;
    trans.addr = vif.mon_cb.addr;
    trans.din  = vif.mon_cb.din;

    if (vif.mon_cb.wr == 0) begin
      // READ: dout valid after 1 cycle
      @(vif.mon_cb);
      trans.dout = vif.mon_cb.dout;
    end
    // else begin
    //   // WRITE: dout not relevant
    //   trans.dout = '0;
    // end

    item_send_port.write(trans);

    `uvm_info("MON",
      $sformatf("wr=%0h din=%0h addr=%0h dout=%0h",
        trans.wr, trans.din, trans.addr, trans.dout),
      UVM_LOW)
  end
endtask

endclass



