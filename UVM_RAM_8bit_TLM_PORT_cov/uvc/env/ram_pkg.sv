package ram_pkg;
   `include "uvm_macros.svh"
   import uvm_pkg::*;

   `include "../seq/ram_item.sv"
   `include "./ram_driver.sv"
   `include "./ram_monitor.sv"
   `include "./ram_agent.sv"
   `include "./ram_scoreboard.sv"
   `include "./ram_coverage.sv"
   `include "./ram_env.sv"

   `include "../seq/ram_seq.sv"
   `include "../tests/base_test.sv"
   `include "../tests/ram_test.sv"

endpackage
