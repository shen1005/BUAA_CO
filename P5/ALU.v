`include "define.v"
module ALU(
    input [31:0] rs,
    input [31:0] rt_or_imm,
    output [31:0] result,
    input [3:0] ALUop
    );
    assign result = (ALUop == `ALUsub)? $signed($signed(rs) - $signed(rt_or_imm)) :
                    (ALUop == `ALUadd)? $signed($signed(rs) + $signed(rt_or_imm)) :
                    (ALUop == `ALUor)? rs|rt_or_imm :
                    (ALUop == `ALUadd0)? rt_or_imm : 0 ;

endmodule
