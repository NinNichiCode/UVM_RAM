class ram_scoreboard extends uvm_scoreboard;
   `uvm_component_utils(ram_scoreboard)
  
   ram_item tr, tr_gol;

   uvm_tlm_analysis_fifo#(ram_item) item_got_imp;
   uvm_tlm_analysis_fifo#(ram_item) item_golden_imp;

   function new (string name = "", uvm_component parent = null);
      super.new(name, parent);
      item_got_imp = new("item_got_imp", this);
      item_golden_imp = new("item_golden_imp", this);
   endfunction

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      tr = ram_item::type_id::create("tr", this);
      tr_gol = ram_item::type_id::create("tr_gol", this);
   endfunction


   virtual task run_phase(uvm_phase phase);
     forever begin 
       item_got_imp.get(tr);
       item_golden_imp.get(tr_gol);


      if (tr.wr == 1) begin
           tr_gol.dout = tr.dout; 
       end 
       
       if (tr.compare(tr_gol)) begin
		`uvm_info("SB", $sformatf("PASSED , wr = %0h, addr = %0h, din = %0h, dout = %0h", tr.wr, tr.addr, tr.din, tr.dout), UVM_LOW);

		`uvm_info("SB_gol", $sformatf("PASSED , wr_gol = %0h, addr_gol = %0h, din_gol = %0h, dout_gol = %0h", tr_gol.wr, tr_gol.addr, tr_gol.din, tr_gol.dout), UVM_LOW);
            end else begin 
	        `uvm_error("SB", $sformatf("FAILED , wr = %0h, addr = %0h, din = %0h, dout = %0h | din_gol = %0h, dout_gol = %0h", tr.wr, tr.addr, tr.din, tr.dout, tr_gol.din, tr_gol.dout));
            end
	end
   endtask

 endclass
                  


      



