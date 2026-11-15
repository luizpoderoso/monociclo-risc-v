module imm_gen(
    input [2:0] imm_src,
    input [24:0] imm,
    output reg [31:0] imm_ext
);
    always @(*) begin
        case (imm_src)
            3'b000:  imm_ext = { {20{imm[24]}}, imm[24:13] };   // tipo I, 20 * bit de sinal concatenado com os demais bits
            default: imm_ext = 32'b0;
        endcase
    end
endmodule