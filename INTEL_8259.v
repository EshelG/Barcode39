module INTEL_8259( 
input IR0,
input INTA,
output reg INT);

always @ (*)
begin
	if ( IR0 ) // DMA done transfer IO to MEM
		INT = 1;
	else if ( INTA )
		INT = 0;
end
endmodule