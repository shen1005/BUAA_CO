`include "define.v"
module muldiv (
    input [31:0] rs,
    input [31:0] rt,
    input req,
    input reset,
    input start,
    input clk,
    input hilowe,
    input hilo_A3,
    input [5:0] ALUop,  
    output [31:0] HI,
    output [31:0] LO, 
    output busy  
);
    reg is_start ;
    reg [3:0] reg_busy ;
    reg [31:0] reg_HI ;
    reg [31:0] reg_LO ;
    reg [63:0] reg_mul ;
    reg [31:0] reg_div_HI ;
    reg [31:0] reg_div_LO ;
    reg [5:0] reg_ALUop ; 
    reg [63:0] reg_mulu ;
    reg [31:0] reg_divu_HI ;
    reg [31:0] reg_divu_LO ;
    always @(posedge clk) begin
        if(reset == 1) begin
				reg_busy <= 0 ; 
            is_start <= 0  ;
            reg_HI <= 0 ;
            reg_LO <= 0 ;
            reg_mul <= 0 ;
            reg_div_HI <= 0 ;
            reg_div_LO <= 0 ;
            reg_divu_HI <= 0 ;
            reg_divu_LO <= 0 ;
            reg_mulu <= 0 ;
            reg_ALUop <= 0 ; 
        end
            else if (hilowe == 1 && req != 1) begin
                if (hilo_A3 == 0) begin
                    reg_HI <= rs ;
                end
                else reg_LO <= rs ;
            end
            else if (start == 1  && req != 1) begin
                    is_start <= 1 ;
                    reg_busy <= 0  ;
                    reg_ALUop <= ALUop ;
                    reg_mul <= $signed($signed({{32{rs[31]}}, rs}) * $signed({{32{rt[31]}}, rt})) ;
                    reg_div_HI <= $signed($signed(rs) % $signed(rt)) ;
                    reg_div_LO <= $signed($signed(rs) / $signed(rt)) ;
                    reg_mulu <= rs * rt ;
                    reg_divu_HI <= rs % rt ;
                    reg_divu_LO <= rs / rt ;
                end
            else begin
                if(is_start == 1) begin
                    if (reg_ALUop == `ALUmul && reg_busy == 4) begin
                        is_start <= 0 ;
                        reg_busy <= 0 ;
                        reg_HI <= reg_mul[63:32] ;
                        reg_LO <= reg_mul[31:0] ;
                    end
                    else if (reg_ALUop == `ALUdiv && reg_busy == 9) begin
                        is_start <= 0 ;
                        reg_busy <= 0 ;
                        reg_HI <= reg_div_HI ;
                        reg_LO <= reg_div_LO ;
                    end
                    else if (reg_ALUop == `ALUdivu && reg_busy == 9) begin
                        is_start <= 0 ;
                        reg_busy <= 0 ;
                        reg_HI <= reg_divu_HI ;
                        reg_LO <= reg_divu_LO ;
                        
                    end
                    else if (reg_ALUop == `ALUmulu && reg_busy == 4) begin
                        is_start <= 0 ;
                        reg_busy <= 0 ;
                        reg_HI <= reg_mulu[63:32] ;
                        reg_LO <= reg_mulu[31:0] ;
                    end
                    else reg_busy <= reg_busy + 1 ;
                end
            end
        end
    assign HI = reg_HI ;
    assign LO = reg_LO ;
    assign busy = (reg_busy == 0 && is_start == 0)? 0 : 1 ;
endmodule //Untitled-1