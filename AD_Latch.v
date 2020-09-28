module ALatch(
input rst,
input [9:0] AD,
input ALE,
output reg [9:0] Address);

always @ (posedge ALE or negedge rst)
begin
  if (!rst)
    Address <= 10'bz;
  else 
    Address <= AD;
  //Address <= (ALE) ? AD : 10'bz;
end
endmodule