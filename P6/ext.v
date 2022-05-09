`include "define.v" 
module ext (
    input [2:0] EXTop ,
    input [15:0]imm16,
    output [31:0]imm32
);
    assign imm32 = (EXTop == `EXTsign)? { {16{imm16[15]}},imm16} :
                    (EXTop == `EXTzero)? {{16{1'b0}}, imm16} :
                    (EXTop == `EXTlui)? {imm16, {16{1'b0}}} : 
                    (EXTop == `EXTsll)? {{27{1'b0}}, imm16[10:6]} : 0 ;

endmodule 