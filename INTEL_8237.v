module INTEL_8237(
input clk,
input rst,
inout [9:0] Address,
input wire HLDA,
output reg HOLD,
output reg EOP,
output reg DACK,
output reg MEMW,
input  DREQ,
input  CS,
output reg BHE
);

reg [9:0] address;

always @ (DREQ,HLDA)
begin
  HOLD = (DREQ) ? 1:0; 
  MEMW = (DREQ) ? 1:0; 
  BHE  = (DREQ)? ((address % 2 == 0) ? 0:1):0; 
  DACK = (HLDA) ? 1:0; 
end

always @ (posedge clk or negedge rst)
begin
 if(!rst)
 begin
 address <= 0;
 end
 else if (DREQ == 1 && CS)
 begin
 address <= address + 1;
 EOP <= (address == 98) ? 1:0;
 end 
end
assign Address = (DREQ && CS) ? address : 10'bz;
endmodule
