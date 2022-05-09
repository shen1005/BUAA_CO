`include "define.v"
module load (
    input [31:0] load_data,
    input [31:0] result,
    input [3:0] memlb,
    output [31:0] DM_data
);
    assign DM_data = (memlb == `memlb_lw)? load_data :
                     (memlb == `memlb_lb && result[1:0] == 0)? {{24{load_data[7]}}, load_data[7:0]} :
                     (memlb == `memlb_lb && result[1:0] == 1)? {{24{load_data[15]}}, load_data[15:8]} :
                     (memlb == `memlb_lb && result[1:0] == 2)? {{24{load_data[23]}}, load_data[23:16]} :
                     (memlb == `memlb_lb && result[1:0] == 3)? {{24{load_data[31]}}, load_data[31:24]} :
                     (memlb == `memlb_lbu && result[1:0] == 0)? {{24{1'b0}}, load_data[7:0]} :
                     (memlb == `memlb_lbu && result[1:0] == 1)? {{24{1'b0}}, load_data[15:8]} :
                     (memlb == `memlb_lbu && result[1:0] == 2)? {{24{1'b0}}, load_data[23:16]} :
                     (memlb == `memlb_lbu && result[1:0] == 3)? {{24{1'b0}}, load_data[31:24]} :
                     (memlb == `memlb_lh && result[1:0] == 0)? {{16{load_data[15]}}, load_data[15:0]} :
                     (memlb == `memlb_lh && result[1:0] == 2)? {{16{load_data[31]}}, load_data[31:16]} :
                     (memlb == `memlb_lhu && result[1:0] == 0)? {{16{1'b0}}, load_data[15:0]} :
                     (memlb == `memlb_lhu && result[1:0] == 2)? {{16{1'b0}}, load_data[31:16]} : 0 ;


endmodule 