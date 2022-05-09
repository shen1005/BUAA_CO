
module IFU(
    input clk,
    input reset,
    input eret,
    input req,
    input [31:0] epc,
    input [31:0] next_pc,
    input En,
    output [31:0] pc
    );
    reg [31:0] now_pc ;
    reg [31:0] find_instr ;
    always @(posedge clk) begin
        if (reset == 1) begin
            now_pc <= 32'h3000 ;
        end
        else if(req) begin
            now_pc <= 32'h4180 ;
        end
        else if (En == 1) begin
            now_pc <= next_pc ;
        end 
    end
    assign pc = (eret)? epc : now_pc ;
endmodule
