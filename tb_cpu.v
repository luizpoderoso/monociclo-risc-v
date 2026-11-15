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
        #60 $finish;
    end

    // No meio de cada ciclo, mostra o que está sendo executado
    always @(negedge clk) begin
        if (!rst)
            $display("PC=%h  instr=%h  | result=%0d | t0=%0d t1=%0d t2=%0d",
                     dut.pc, dut.instr, $signed(dut.result),
                     $signed(dut.REG_FILE.mem[5]),
                     $signed(dut.REG_FILE.mem[6]),
                     $signed(dut.REG_FILE.mem[7]));
    end
endmodule