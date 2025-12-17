class base_test extends uvm_test;
  `uvm_component_utils(base_test)

  function new(string name = "base_test", uvm_component parent  = null);
     super.new(name, parent);
  endfunction

  ram_env env;

  virtual function void build_phase (uvm_phase phase);
     super.build_phase(phase);
     env = ram_env::type_id::create("env", this);
  endfunction

  virtual task run_phase(uvm_phase phase);
     phase.raise_objection(this);
       run_test_seq();
     phase.drop_objection(this);
  endtask

  virtual task run_test_seq();
      
  endtask

  function void end_of_elaboration();
    uvm_top.print_topology();
  endfunction

  function void report_phase(uvm_phase phase);
     int error_cnt;
     uvm_report_server server;
     server = uvm_report_server::get_server();

     error_cnt = server.get_severity_count(UVM_FATAL) + server.get_severity_count(UVM_ERROR);

     if(error_cnt == 0)
        `uvm_info("BASE_TEST", "** TEST PASSED **", UVM_LOW)
      else
	`uvm_error("BASE_TEST", "** TEST FAILED **")
  endfunction
endclass

