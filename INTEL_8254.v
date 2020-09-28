module INTEL_8254(
    input clk,
    input rst,
    input CS,
    output wire [7:0] data,
    output reg OUT0,
    input wire GATE0
    );
    
    reg GATE0S, flag =0, FLAG;
    reg [3:0] counter;
    reg [3:0] capture = 0;
    reg [3:0] Toggles = -1;

    always @ (GATE0) 
		  if(CS) begin
            capture = counter+8'b1;
            flag = 1; // flag to start counting
            if(Toggles < 10)
                Toggles = Toggles + 1;
            else
                if(FLAG)
                    Toggles = 1;
        end

    always @(posedge clk, negedge rst) // Samples Gate every rising clock
        if(~rst) begin
            GATE0S <= 1;
            FLAG <= 0;
        end
        else if(CS) begin
            GATE0S <= GATE0; 
            FLAG <= flag; // Samples 
        end

    always @(posedge clk, negedge rst)
        if(~rst) begin
            OUT0 <= 0;
            counter <= 1;
        end
        else if(CS) 
            begin
                if(flag)
                    if(GATE0 & ~GATE0S || ~GATE0 & GATE0S)
                            begin
                                if(FLAG & ~(Toggles%10 == 0))
                                    OUT0 <= 1;
                                counter <= 1;
                            end
                        else
                            begin
                                OUT0 <= 0;
                                counter <= counter + 1;
                            end
            end
assign data = (CS && flag) ? capture : 8'bzzzzzzzz ; // Data
endmodule