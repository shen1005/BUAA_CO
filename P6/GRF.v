module GRF(
    input clk ,
    input reset,
    input regwe,
    input [4:0]A1,
    input [4:0]A2,
    input [4:0]A3,
    input [31:0]regwd,
    output [31:0] B1,
    output [31:0] B2
    );
    integer i ;
    reg [31:0] register[0:31];
    always @(posedge clk) begin
        if (reset==1) begin
            for (i = 0; i < 32 ; i = i + 1 ) begin
                register[i] = 0 ;
            end
        end
        else begin
            if (regwe == 1) begin
                if(A3 != 0) begin
                    register[A3] <= regwd ;
                end
            end
        end
    end
    assign B1 = register[A1] ;
    assign B2 = register[A2] ;
endmodule