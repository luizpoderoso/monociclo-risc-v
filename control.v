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
        pc_src     = 2'b00;    // pc + 4
        result_src = 2'b00;    // result vem da ALU
        alu_ctrl   = 3'b000;   // soma
        imm_src    = 3'b000;   // tipo I

        case (op)
            7'b0010011: begin          // addi e slli
                reg_write = 1'b1;      // grava em rd
                alu_src   = 1'b1;      // src_b = imediato
                imm_src   = 3'b000;    // tipo I
                
                if (funct3 == 3'b000)  // addi
                    alu_ctrl  = 3'b000;
                else                   // slli
                    alu_ctrl = 3'b100;
            end
            7'b0000011: begin          // lw
                reg_write  = 1'b1;     // grava em rd
                alu_src    = 1'b1;     // src_b = imediato
                result_src = 2'b01;    // result vem da memória
            end
            7'b0100011: begin          // sw
                mem_write = 1'b1;      // pode escrever na memória
                alu_src   = 1'b1;      // src_b = imediato
                imm_src   = 3'b001;    // tipo S
            end
            7'b0010111: begin          // auipc
                reg_write  = 1'b1;     // grava em rd
                imm_src    = 3'b100;   // tipo U
                result_src = 2'b11;    // result = pc + imm
            end
            7'b1101111: begin          // jal
                reg_write  = 1'b1;     // grava em rd
                imm_src    = 3'b011;   // tipo J
                result_src = 2'b10;    // result = pc + 4
                pc_src     = 2'b01;    // pc = pc + imm
            end
            7'b0110011: begin          // add
                reg_write = 1'b1;      // pode escrever no reg
            end
            7'b1100111: begin          // jalr
                reg_write  = 1'b1;     // grava em rd
                result_src = 2'b10;    // result = pc + 4
                pc_src     = 2'b10;    // pc = pc + imm
            end
        endcase
    end
endmodule