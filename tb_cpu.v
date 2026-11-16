`include "cpu.v"

module tb_cpu;
    reg clk = 0;
    reg rst = 1;

    cpu dut (.clk(clk), .rst(rst));

    always #5 clk = ~clk;

    initial begin
        $dumpfile("cpu.vcd");
        $dumpvars(0, tb_cpu);

        #8 rst = 0;     // rst ativo na 1ª subida, então PC = 0
        
        #3000;
        $display("origem   = %0d %0d %0d", dut.D_MEM.mem[0], dut.D_MEM.mem[1], dut.D_MEM.mem[2]);
        $display("destino  = %0d %0d %0d", dut.D_MEM.mem[3], dut.D_MEM.mem[4], dut.D_MEM.mem[5]);
        $display("auxiliar = %0d %0d %0d", dut.D_MEM.mem[6], dut.D_MEM.mem[7], dut.D_MEM.mem[8]);
        $display("topos: s1=%0d s3=%0d s5=%0d | sp=%h | PC=%h",
            $signed(dut.REG_FILE.mem[9]),    // s1: topo da origem
            $signed(dut.REG_FILE.mem[19]),   // s3: topo do destino
            $signed(dut.REG_FILE.mem[21]),   // s5: topo do auxiliar
            dut.REG_FILE.mem[2], dut.pc);
        $finish;
    end
endmodule