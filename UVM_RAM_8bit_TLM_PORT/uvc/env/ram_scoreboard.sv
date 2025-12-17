class ram_scoreboard extends uvm_scoreboard;
   `uvm_component_utils(ram_scoreboard)

   uvm_analysis_imp#(ram_item, ram_scoreboard) item_got_imp;
   bit [7:0] mem [int];

   function new (string name = "", uvm_component parent = null);
      super.new(name, parent);
      item_got_imp = new("item_got_imp", this);
   endfunction


   virtual function void write(ram_item trans);
       if(trans.kind == ram_item::WRITE) begin
	   mem[trans.addr] = trans.din;
	   `uvm_info("SB", $sformatf("kind = %s, addr = %0h, din = %0h", trans.kind.name(), trans.addr, trans.din), UVM_LOW);
       end
       else if (trans.kind == ram_item::READ) begin
            if (!mem.exists(trans.addr)) begin
               `uvm_info("SB",
               $sformatf("READ before WRITE addr=%0h dout=%0h (ignored)",
                           trans.addr, trans.dout),UVM_LOW)
               return;
             end

	        if(trans.dout == mem[trans.addr] ) begin
		         `uvm_info("SB", $sformatf("PASSED , kind = %s, addr = %0h, din = %0h, dout = %0h", trans.kind.name(), trans.addr, trans.din, trans.dout), UVM_LOW);
            end else begin 
	            `uvm_error("SB", $sformatf("FAILED , kind = %s, addr = %0h, din = %0h, dout = %0h", trans.kind.name(), trans.addr, trans.din, trans.dout));
            end
	end
   endfunction

 endclass
                  


      



