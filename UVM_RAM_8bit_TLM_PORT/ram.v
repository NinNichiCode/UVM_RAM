module ram (
input clk, wr,
input [7:0] din,
input [3:0] addr,
output reg [7:0] dout
);

reg [7:0] mem [15:0];
always@(posedge clk) begin
  if(wr) begin  
     mem[addr] <= din;
  end
  else begin
     dout <= mem[addr];
  end
end
endmodule

