module control(
    input [6:0] op,
    input [2:0] funct3,
    input funct7,
    input zero,
    output reg mem_write,
    output reg alu_src,
    output reg reg_write,
    output reg [1:0] pc_src,
    output reg [1:0] result_src,
    output reg [2:0] alu_ctrl,
    output reg [2:0] imm_src
);
    always @(*) begin
        mem_write  = 1'b0;     // não pode escrever na memória
        alu_src    = 1'b0;     // src_b = write_data
        reg_write  = 1'b0;     // não pode escrever no reg
        pc_src     = 2'b00;    // PC + 4
        result_src = 2'b00;    // result vem da ALU
        alu_ctrl   = 3'b000;   // soma
        imm_src    = 3'b000;   // tipo I

        case (op)
            7'b0010011: begin          // addi
                reg_write = 1'b1;      // grava em rd
                alu_src   = 1'b1;      // src_b = imediato
                imm_src   = 3'b000;    // tipo I
                alu_ctrl  = 3'b000;    // soma
            end
        endcase
    end
endmodule