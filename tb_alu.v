`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.07.2025 09:38:40
// Design Name: 
// Module Name: tb_alu
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_alu;
    parameter width=8;
    wire [width-1:0]opcode;
    wire [width-1:0]a;
    wire [width-1:0]b;
    wire [width-1:0]y;
    reg clk = 0;
    reg reset = 0;

    pipeline_top uut(
    .clk(clk), 
    .reset(reset),
    .opcode(opcode),
    .a(a),
    .b(b),
    .y(y)
    );

    always #5 clk = ~clk;

    initial begin
        $readmemh("instr_mem.mem", uut.instr_mem);
        reset = 1; #10;
        reset = 0;
        #100;
        $stop;
    end
endmodule