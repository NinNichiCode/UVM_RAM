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
    @(posedge vif.clk);

    trans = ram_item::type_id::create("trans", this);

    if (vif.wr) begin
      // WRITE: dữ liệu hợp lệ ngay
      trans.kind = ram_item::WRITE;
      trans.addr = vif.addr;
      trans.din  = vif.din;
      trans.dout = 'x;
      item_send_port.write(trans);

      `uvm_info("MON",
        $sformatf("WRITE addr=%0h din=%0h", vif.addr, vif.din),
        UVM_LOW)

    end else begin
      // READ: chờ 1 chu kỳ để dout valid
      trans.kind = ram_item::READ;
      trans.addr = vif.addr;
      trans.din  = 'x;

      @(posedge vif.clk);
      trans.dout = vif.dout;

      item_send_port.write(trans);

      `uvm_info("MON",
        $sformatf("READ addr=%0h dout=%0h", vif.addr, vif.dout),
        UVM_LOW)
    end
  end
endtask


endclass



