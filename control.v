module control(
    input [6:0] op,
    input [2:0] funct3,
    input funct7,
    input zero,
    output mem_write,
    output alu_src,
    output reg_write,
    output [1:0] pc_src,
    output [1:0] result_src,
    output [2:0] alu_ctrl,
    output [2:0] imm_src
);
endmodule