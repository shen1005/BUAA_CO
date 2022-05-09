`include "define.v"
module cmp (
    input [31:0] rs,
    input [31:0] rt,
    input [3:0] branchop,
    output is_branch
);
    assign is_branch = (branchop == `bra_beq && rs == rt)? 1 :
                       (branchop == `bra_bne && rs != rt)? 1 :
                       (branchop == `bra_blez && $signed($signed(rs) <= 0))? 1 :
                       (branchop == `bra_bgtz && $signed($signed(rs) > 0))? 1 :
                       (branchop == `bra_bltz && $signed($signed(rs) < 0))? 1 :
                       (branchop == `bra_bgez && $signed($signed(rs) >= 0))? 1 : 0 ;
endmodule 
/*`define bra_beq 4'b0
`define bra_bne 4'b0001 
`define bra_blez 4'b0010 
`define bra_bgtz 4'b0011 
`define bra_bltz 4'b0100 
`define bra_bgez 4'b0101 */