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
    wire [1:0] result_src, pc_src;
    wire [2:0] imm_src, alu_ctrl;

    assign pc_plus4 = pc + 4;
    assign pc_target = pc + imm_ext;
    assign src_b = alu_src ? imm_ext : write_data;
endmodule