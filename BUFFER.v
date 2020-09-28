module BUFFER(
output [7:0] data_bus,
input  [7:0] data_in,
input DACK
);
 assign  data_bus = (DACK) ? data_in : 8'bzzzzzzzz ;  
endmodule