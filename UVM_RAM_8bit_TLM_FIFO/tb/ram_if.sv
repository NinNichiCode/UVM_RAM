`timescale 1ns/1ps
interface ram_if(input clk);
   logic wr;
   logic [7:0] din;
   logic [3:0] addr;
   logic [7:0] dout;

   clocking drv_cb @(posedge clk);
      default input #1step output #1ns;
      output wr;
      output din;
      output addr;
   endclocking

   clocking mon_cb @(posedge clk);
      default input #1step output #1ns;
      input wr;
      input din;
      input addr;
      input dout;
   endclocking

 endinterface
