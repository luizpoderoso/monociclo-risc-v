module cpu(input clk, input rst);
    // ================== FIOS ==================
    // Instrução + PC
    wire [31:0] pc, pc_next, pc_target, pc_plus4, instr;
    // ALU
    wire [31:0] imm_ext, src_a, src_b, alu_result;
    wire zero;
    // Memória de Dados + Result
    wire [31:0] write_data, read_data, result;
    // Control
    wire mem_write, alu_src, reg_write;
    wire [1:0] imm_src, result_src, pc_src;
    wire [2:0] alu_ctrl;
endmodule