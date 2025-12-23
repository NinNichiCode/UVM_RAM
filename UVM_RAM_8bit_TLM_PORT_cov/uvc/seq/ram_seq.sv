class ram_seq extends uvm_sequence#(ram_item);
  `uvm_object_utils(ram_seq)

  function new(string name = "ram_seq");
    super.new(name);
  endfunction

  ram_item wr_req;
  ram_item rd_req;
  bit [3:0] temp_addr;

  virtual task body();

    repeat (100) begin

      // ---------- WRITE ----------
      wr_req = ram_item::type_id::create("wr_req");

      `uvm_do_with(wr_req, {
        kind == ram_item::WRITE;
        addr inside {[4'h00:4'hff]};
      });

      temp_addr = wr_req.addr;

      // ---------- READ ----------
      rd_req = ram_item::type_id::create("rd_req");

      `uvm_do_with(rd_req, {
        kind == ram_item::READ;
        addr == temp_addr;
      });

      `uvm_info(get_type_name(),
        $sformatf("WRITE then READ at addr = 0x%0h", temp_addr),
        UVM_MEDIUM)

    end

    repeat(20) begin
      ram_item req;
      `uvm_do_with(req, {
        kind == ram_item::WRITE;
      });
    end

    repeat(20) begin
      ram_item req;
      `uvm_do_with(req, {
        kind == ram_item::READ;
      });
    end

  repeat(16) begin
  ram_item req;
     `uvm_do_with(req, {
	addr inside {4'h5, 4'ha, 4'hf};
        din inside {8'd85, 8'd255};
});
    end



  endtask
endclass
