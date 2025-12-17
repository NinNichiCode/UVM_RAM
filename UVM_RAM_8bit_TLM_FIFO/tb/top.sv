`timescale 1ns/1ps

 `include "uvm_macros.svh"
 import uvm_pkg::*;
 import ram_pkg::*;

 module top;
   logic clk;

   initial begin
      clk = 0;
      forever #5 clk = ~clk;
   end

   ram_if vif(clk);

   ram dut(.clk(vif.clk), .wr(vif.wr), .addr(vif.addr), .din(vif.din), .dout(vif.dout)); 
initial begin
  vif.wr   = 1;
  vif.addr = 0;
  vif.din  = 0;
  #5;
end

   initial begin
      uvm_config_db#(virtual ram_if)::set(null, "*", "vif", vif);
      run_test();
   end
endmodule



