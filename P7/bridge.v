`include "define.v"


module bridge (
    input [31:0] M_result,
    input [3:0] M_mem_byteen,
    input [31:0] M_rt,
    input [31:0] m_data_rdata,
    input [31:0] TC0_out,
    input [31:0] TC1_out,
    output TC0_we,
    output TC1_we,
    output [31:0] TC0_in,
    output [31:0] TC1_in,
    output [31:0] M_mem_addr,
    output [31:0] M_data_wdata,
    output [3:0] M_data_byteen,
    output [31:0] M_load_data  
);
    wire selTC0 ;
    wire selTC1 ;
    reg [31:0] reg_TC0 ;
    reg [31:0] reg_TC1 ;
    assign M_mem_addr = M_result ;
    assign M_data_wdata = (M_rt << (M_result[1:0]*8)) ;
    assign M_data_byteen = (M_mem_byteen<<M_result[1:0]) ;
    assign selTC0 = (M_result >= `TC0_start && M_result < `TC0_end)? 1 : 0 ;
    assign selTC1 = (M_result >= `TC1_start && M_result < `TC1_end)? 1 : 0 ;
    assign TC0_we = (selTC0 && M_mem_byteen != 0)? 1 : 0 ;
    assign TC0_we = (selTC0 && M_mem_byteen != 0)? 1 : 0 ;
    always @(*) begin
        reg_TC0 = TC0_out;
        if (M_data_byteen[3]) reg_TC0[31:24] = M_data_wdata[31:24];
        if (M_data_byteen[2]) reg_TC0[23:16] = M_data_wdata[23:16];
        if (M_data_byteen[1]) reg_TC0[15: 8] = M_data_wdata[15: 8];
        if (M_data_byteen[0]) reg_TC0[7 : 0] = M_data_wdata[7 : 0];
    end
    assign TC0_in = reg_TC0 ;
    always @(*) begin
        reg_TC1 = TC1_out;
        if (M_data_byteen[3]) reg_TC1[31:24] = M_data_wdata[31:24];
        if (M_data_byteen[2]) reg_TC1[23:16] = M_data_wdata[23:16];
        if (M_data_byteen[1]) reg_TC1[15: 8] = M_data_wdata[15: 8];
        if (M_data_byteen[0]) reg_TC1[7 : 0] = M_data_wdata[7 : 0];
    end
    assign TC1_in = reg_TC1 ;
    assign M_load_data = (selTC0)? TC0_out :
                         (selTC1)? TC1_out :
                         m_data_rdata ; 





    /*assign m_data_addr = M_result ;
    assign m_data_wdata = (M_rt << (M_result[1:0]*8)) ;
    assign m_data_byteen = (M_mem_byteen<<M_result[1:0]) ;*/

endmodule 