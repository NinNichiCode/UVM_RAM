class ram_seq extends uvm_sequence#(ram_item);
   `uvm_object_utils(ram_seq)

   function new(string name = "ram_seq");
      super.new(name);

   endfunction

   ram_item req;
   virtual task body();
      req = ram_item::type_id::create("req");

      repeat (10) begin
//         `uvm_do(req);
  
     `uvm_do_with(req, {
        addr == 4'hf;
});

  end
   endtask
endclass


