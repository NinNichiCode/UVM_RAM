class ram_seq extends uvm_sequence#(ram_item);
  `uvm_object_utils(ram_seq)

  function new(string name = "ram_seq");
    super.new(name);
  endfunction

  ram_item wr_req;
  ram_item rd_req;
  bit [3:0] temp_addr;

  virtual task body();

    repeat (10) begin

      // ---------- WRITE ----------
      wr_req = ram_item::type_id::create("wr_req");

      `uvm_do_with(wr_req, {
       wr == 1;
        addr inside {4'h0, 4'h4, 4'h8, 4'hC};
      });

      temp_addr = wr_req.addr;

      // ---------- READ ----------
      rd_req = ram_item::type_id::create("rd_req");

      `uvm_do_with(rd_req, {
        wr == 0;
        addr == temp_addr;
      });

      `uvm_info(get_type_name(),
        $sformatf("WRITE then READ at addr = 0x%0h", temp_addr),
        UVM_MEDIUM)

    end
  endtask
endclass
