module imm_gen(
    input [2:0] imm_src,
    input [24:0] imm,
    output reg [31:0] imm_ext
);
    always @(*) begin
        case (imm_src)
            3'b000: imm_ext = { {20{imm[24]}}, imm[24:13] };                                // tipo I
            3'b001: imm_ext = { {20{imm[24]}}, imm[24:18], imm[4:0] };                      // tipo S
            3'b010: imm_ext = { {21{imm[24]}}, imm[0], imm[23:18], imm[4:1], 1'b0 };        // tipo B
            3'b011: imm_ext = { {12{imm[24]}}, imm[12:5], imm[13], imm[23: 14], 1'b0 };     // tipo J
            3'b100: imm_ext = { imm[24:5], 12'b0 };                                         // tipo U
            default: imm_ext = 32'b0;
        endcase
    end
endmodule