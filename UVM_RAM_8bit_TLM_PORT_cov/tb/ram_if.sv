interface ram_if(input clk);
   logic wr;
   logic [7:0] din;
   logic [3:0] addr;
   logic [7:0] dout;

  //---------------------------------------------------------
  // SVA 
  //---------------------------------------------------------

  property p_dout_stable_during_write;
    @(posedge clk) wr |=> $stable(dout);
  endproperty
  
  ASSERT_DOUT_STABLE: assert property (p_dout_stable_during_write);

  COVER_WRITE: cover property (@(posedge clk) wr);
  COVER_READ:  cover property (@(posedge clk) !wr);



  property p_write_read_back;
    logic [7:0] written_data;
    logic [3:0] target_addr;
    @(posedge clk) 
      (wr, written_data = din, target_addr = addr) ##1 (!wr && addr == target_addr) 
      |=> (dout == written_data);
  endproperty

  ASSERT_WRITE_READ_BACK: assert property (p_write_read_back);

  COVER_WRITE_READ_SAME_ADDR: cover property (p_write_read_back);



  property p_no_x_on_read;
    @(posedge clk) ($time > 50) |-> (!wr |-> !$isunknown(dout));
  endproperty
  
  ASSERT_NO_X_READ: assert property (p_no_x_on_read) 
                    else $warning("SVA: Read value is X at time %0t", $time);

  COVER_NO_X_READ: cover property (p_no_x_on_read);




 endinterface
