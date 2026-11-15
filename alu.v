module alu(
    input [2:0] alu_ctrl,
    input [31:0] src_a,
    input [31:0] src_b,
    output reg [31:0] alu_result,
    output reg zero
);
    always @(*) begin
        case (alu_ctrl)
            3'b000: alu_result = src_a + src_b;
            default: alu_result = 32'b0;
        endcase

        zero = alu_result == 32'b0;
    end
endmodule