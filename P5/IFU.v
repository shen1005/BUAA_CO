
module IFU(
    input clk,
    input reset,
    input [31:0] next_pc,
    input En,
    output [31:0] pc,
    output [31:0] instr
    );
	 wire [31:0] get_instr ;
    reg [31:0] im_reg[0:4095];
    reg [31:0] now_pc ;
    reg [31:0] find_instr ;
    initial begin
            $readmemh("code.txt",im_reg);
    end
    always @(posedge clk) begin
        if (reset == 1) begin
            now_pc <= 32'h00003000 ;
        end
        else if (En == 1)  now_pc <= next_pc ;
    end
    assign pc = now_pc ;
	 assign get_instr = now_pc - 32'h00003000 ;
    assign instr = im_reg[get_instr[13:2]] ;
endmodule
