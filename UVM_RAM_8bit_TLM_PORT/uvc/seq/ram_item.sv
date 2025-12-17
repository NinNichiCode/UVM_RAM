

class ram_item extends uvm_sequence_item;
   `uvm_object_utils(ram_item)

typedef enum bit {
   READ = 1'b0,
   WRITE = 1'b1
} ram_op_e;

  rand ram_op_e kind;
  rand bit [7:0] din;
  rand bit [3:0] addr;
  rand bit [7:0] dout;

   function new (string name = "ram_item");
      super.new(name);
   endfunction

endclass
   
