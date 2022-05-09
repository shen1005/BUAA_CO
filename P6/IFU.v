
module IFU(
    input clk,
    input reset,
    input [31:0] next_pc,
    input En,
    output [31:0] pc
    );
    reg [31:0] now_pc ;
    reg [31:0] find_instr ;
    always @(posedge clk) begin
        if (reset == 1) begin
            now_pc <= 32'h00003000 ;
        end
        else if (En == 1)  now_pc <= next_pc ;
    end
    assign pc = now_pc ;
endmodule
