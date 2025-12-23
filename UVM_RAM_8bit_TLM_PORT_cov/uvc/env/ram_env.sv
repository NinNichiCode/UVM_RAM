class ram_env extends uvm_env;
   `uvm_component_utils(ram_env);

   function new(string name = "", uvm_component parent = null);
      super.new(name, parent);
   endfunction

   
   ram_agent agent;
   ram_scoreboard scoreboard;
   ram_coverage cov;
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      agent = ram_agent::type_id::create("agent", this);
      scoreboard = ram_scoreboard::type_id::create("scoreboard", this);
      cov = ram_coverage::type_id::create("cov", this);
   endfunction


   virtual function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      agent.monitor.item_send_port.connect(scoreboard.item_got_imp);
      agent.monitor.item_send_port.connect(cov.analysis_export);
   endfunction

endclass


