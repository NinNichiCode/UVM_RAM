class ram_agent extends uvm_agent;
   `uvm_component_utils(ram_agent)

   function new(string name = "", uvm_component parent = null );
      super.new(name, parent);
   endfunction

   ram_driver driver;
   ram_monitor monitor;
   uvm_sequencer#(ram_item) seqr;

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      driver = ram_driver::type_id::create("driver", this);
      monitor = ram_monitor::type_id::create("monitor", this);
      seqr = uvm_sequencer#(ram_item)::type_id::create("seqr", this);

   endfunction   

   virtual function void connect_phase(uvm_phase phase);
       super.connect_phase(phase);
       driver.seq_item_port.connect(seqr.seq_item_export);
   endfunction

endclass


