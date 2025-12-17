class ram_item extends uvm_sequence_item;

  rand bit wr;
  rand bit [7:0] din;
  rand bit [3:0] addr;
  rand bit [7:0] dout;

   function new (string name = "ram_item");
      super.new(name);
   endfunction

   `uvm_object_utils_begin(ram_item)
     `uvm_field_int(wr, UVM_DEFAULT)
     `uvm_field_int(addr, UVM_DEFAULT)
     `uvm_field_int(din, UVM_DEFAULT)
     `uvm_field_int(dout, UVM_DEFAULT)
   `uvm_object_utils_end

endclass
   
