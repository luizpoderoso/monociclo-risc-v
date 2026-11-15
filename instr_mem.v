module instr_mem(
    input [31:0] pc,
    output [31:0] instr
);
    reg [31:0] mem [0:255]; // mais que o suficiente para o algoritmo

    initial $readmemh("memory/instr.hex", mem);

    // como aloquei 256 posições para a memória de instruções, 8 bits são necessários para obter a pos.
    // porém, importante destacar que esse valor (pos.) é obtido após 2 shifts no valor de PC (pois cada registro
    // ocupa 4 bytes).
    assign instr = mem[pc[9:2]];
endmodule