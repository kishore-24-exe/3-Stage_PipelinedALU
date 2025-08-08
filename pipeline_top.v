`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.07.2025 07:53:33
// Design Name: 
// Module Name: pipeline_top
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

module pipeline_top #(parameter width = 8)(
    input clk,
    input reset,
    output [width-1:0]opcode,
    output [width-1:0]a,
    output [width-1:0]b,
    output [width-1:0]y
);
    // Stage 1: Instruction Fetch
    reg [15:0] instr_mem [0:31];
    reg [4:0] pc = 0;
    reg [15:0] instr_fetch;
    
    // Fetch stage
    always @(posedge clk) begin
        if (reset) begin
            pc <= 0;
        end else begin
            instr_fetch <= instr_mem[pc];
            pc <= pc + 1;
        end
    end

    // Pipeline registers
    reg [15:0] instr_decode;
    reg [15:0] instr_execute;
    reg [width-1:0] alu_result_mem;
    reg [width-1:0] alu_result_wb;
    
    // Pipeline register updates
    always @(posedge clk) begin
    if (reset) begin
        instr_decode   <= 0;
        instr_execute  <= 0;
        alu_result_mem <= 0;
        alu_result_wb  <= 0;
    end else begin
        instr_decode     <= instr_fetch;
        instr_execute    <= instr_decode;
        alu_result_mem   <= y_ex;
        alu_result_wb    <= alu_result_mem;
    end
end

    // Stage 2 Decode
    wire [3:0] op_decode      = instr_decode[15:12];
    wire [width-1:0] a_decode = instr_decode[11:4];
    wire [width-1:0] b_decode = instr_decode[3:0];
    wire c_in_decode = 0;

    // Stage 3 Execute
    wire [width-1:0] a_ex = instr_execute[11:4];
    wire [width-1:0] b_ex = instr_execute[3:0];
    wire [3:0] op_ex = instr_execute[15:12];
    wire [width-1:0] y_ex;
    wire c_out_ex, overflow_ex, borrow_ex, invalid_op_ex;

    alu_core #(width) alu_inst (
        .a(a_ex), .b(b_ex), .c_in(0), .op(op_ex),
        .y(y_ex), .c_out(c_out_ex),
        .overflow(overflow_ex), .borrow(borrow_ex),
        .invalid_op(invalid_op_ex)
    );
    // Monitor output (writeback stage)
    always @(posedge clk) begin
        $display("CLK: %0t | OPCODE: %d | A: %d | B: %d | RESULT: %d", 
                 $time, instr_execute[15:12], a_ex, b_ex, alu_result_wb);
    end
    
    assign opcode = instr_execute[15:12];
    assign a = a_ex;
    assign b = b_ex;
    assign y = alu_result_wb;
endmodule
