`include "define.v"
module ALU(
    input [31:0] rs,
    input [31:0] rt_or_imm,
    output [31:0] result,
    input [5:0] ALUop
    );
    assign result = (ALUop == `ALUsub)? $signed($signed(rs) - $signed(rt_or_imm)) :
                    (ALUop == `ALUadd)? $signed($signed(rs) + $signed(rt_or_imm)) :
                    (ALUop == `ALUor)? rs|rt_or_imm :
                    (ALUop == `ALUadd0)? rt_or_imm : 
                    (ALUop == `ALUsll)? (rt_or_imm<<rs) : 
                    (ALUop == `ALUsrl)? (rt_or_imm>>rs) :
                    (ALUop == `ALUsra)? $signed($signed(rt_or_imm)>>>rs) :
                    (ALUop == `ALUsllv)? (rt_or_imm<<(rs[4:0])) :
                    (ALUop == `ALUsrlv)? (rt_or_imm>>(rs[4:0])) : 
                    (ALUop == `ALUsrav)? $signed($signed(rt_or_imm)>>>(rs[4:0])) :
                    (ALUop == `ALUand)? rs&rt_or_imm : 
                    (ALUop == `ALUxor)? rs^rt_or_imm : 
                    (ALUop == `ALUnor)? ~(rs|rt_or_imm) : 
                    (ALUop == `ALUslt && $signed($signed(rs)<$signed(rt_or_imm)))?  1 :
                    (ALUop == `ALUslt && $signed($signed(rs)>=$signed(rt_or_imm)))? 0 : 
                    (ALUop == `ALUsltu &&  rs<rt_or_imm)? 1 :
                    (ALUop == `ALUsltu &&  rs>=rt_or_imm)?0 : 0 ;

endmodule
