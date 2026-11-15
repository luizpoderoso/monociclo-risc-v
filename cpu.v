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

    // ================== VALORES PC ==================
    assign pc_plus4 = pc + 4;
    assign pc_target = pc + imm_ext;

    // ================== MUX ==================
    assign src_b = alu_src ? imm_ext : write_data;

    assign result = (result_src == 2'b00) ? alu_result :
                (result_src == 2'b01) ? read_data  :
                (result_src == 2'b10) ? pc_plus4   :
                                        pc_target;   // 2'b11

    assign pc_next = (pc_src == 2'b00) ? pc_plus4   :
                 (pc_src == 2'b01) ? pc_target  :
                 (pc_src == 2'b10) ? alu_result :
                                     pc_plus4;       // 2'b11 não é usado

    // ================== Datapath ==================
    pc_reg PC (
        .rst(rst),
        .pc_next(pc_next),
        .pc(pc)
    );

    instr_mem I_MEM(
        .pc(pc),
        .instr(instr),
    );

    control CTRL(
        .op(instr[6:0]),
        .funct3(instr[14:12]),
        .funct7(instr[30]),
        .zero(zero),
        .mem_write(mem_write),
        .alu_src(alu_src),
        .reg_write(reg_write),
        .pc_src(pc_src),
        .result_src(result_src),
        .alu_ctrl(alu_ctrl),
        .imm_src(imm_src)
    );

    reg_file REG_FILE(
        .we3(reg_write),
        .clk(clk),
        .a1(instr[19:15]),
        .a2(instr[24:20]),
        .a3(instr[11:7]),
        .wd3(result),
        .rd1(src_a),
        .rd2(write_data)
    );

    imm_gen IMM_GEN(
        .imm_src(imm_src),
        .imm(instr[31:7]),
        .imm_ext(imm_ext)
    );

    alu ALU(
        .alu_ctrl(alu_ctrl),
        .src_a(src_a),
        .src_b(src_b),
        .alu_result(alu_result),
        .zero(zero)
    );

    data_mem D_MEM(
        .we(mem_write),
        .clk(clk),
        .addr(alu_result),
        .wd(write_data),
        .rd(read_data)
    );
endmodule