
module NPC(
    input [31:0] pc,
    input [15:0] imm16,
    input [25:0] imm26,
    input is_b,
    input is_j,
    input is_jr,
    input is_branch,
    input [31:0] rs,
    output [31:0] pc8,
    output [31:0] next_pc
    );
    assign pc8 = pc + 8 ;
    assign next_pc = (is_jr == 1)? rs :
                    (is_j == 1)? {pc[31:28], imm26, {2{1'b0}}} :
                    (is_b == 1 && is_branch == 1)? pc+{{14{imm16[15]}},imm16, {2{1'b0}}} :
                    pc+4 ;
    
endmodule