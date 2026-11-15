module reg_file(
    input we3,
    input clk,
    input [4:0] a1,
    input [4:0] a2,
    input [4:0] a3,
    input [31:0] wd3,
    output [31:0] rd1,
    output [31:0] rd2
);
    reg [31:0] mem [0:31]; // 32 registradores
    integer i;

    // inicializa todos os registradores com 0 (exceto x2/sp)
    initial begin
        for (i = 0; i < 32; i = i + 1)
            mem[i] = 32'b0;
        mem[2] = 32'h3ffc;   // sp
    end
    
    assign rd1 = mem[a1];
    assign rd2 = mem[a2];

    always @(posedge clk) begin
        if (we3 && a3 != 0)
            mem[a3] <= wd3;
    end
endmodule