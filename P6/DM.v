module DM(
    input [11:0] address,
    input [31:0] data,
    input clk,
    input memse,
    output [31:0] DM_data,
    input reset
    );
    integer i ;
    reg [31:0] dm_reg [0:3071] ;
    always @(posedge clk) begin
        if (reset == 1) begin
            for (i = 0; i < 1024 ; i = i + 1 ) begin
                dm_reg [i] = 0 ;
            end
        end
        else begin
            if (memse == 1) begin
                dm_reg[address] = data ;
            end
        end  
    end
    assign DM_data =  dm_reg[address] ;
endmodule