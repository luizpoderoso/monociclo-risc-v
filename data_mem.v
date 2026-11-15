module data_mem(
    input we,
    input clk,
    input [31:0] addr,
    input [31:0] wd,
    output [31:0] rd
);
    reg [31:0] mem [0:2047]; // 0x2000 a 0x3fff (dados + pilha)
    initial $readmemh("memory/data.hex", mem);

    wire [31:0] offset = addr - 32'h2000;   // distância desde o início dos dados

    // calcula-se a posição (11 bits) dividindo a distância por 4
    assign rd = mem[offset[12:2]];
    
    // escrita
    always @(posedge clk) begin
        if (we)
            mem[offset[12:2]] <= wd;
    end
endmodule