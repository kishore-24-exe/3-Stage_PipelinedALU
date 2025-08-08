module alu_core #(parameter width = 8)(
    input signed [width-1:0] a,
    input signed [width-1:0] b,
    input c_in,
    input [3:0] op,
    output reg signed [width-1:0] y,
    output reg c_out,
    output reg overflow,
    output reg borrow,
    output reg invalid_op
);
    always @(*) begin
        y = 0; c_out = 0; overflow = 0; borrow = 0; invalid_op = 0;
        case (op)
            4'd0: y = ~(a | b);                      // NOR
            4'd1: {c_out, y} = a + b;                // ADD
            4'd2: {c_out, y} = a + b + c_in;         // ADD with carry
            4'd3: begin y = a - b; borrow = (a < b); end
            4'd4: y = a + 1;
            4'd5: y = a - 1;
            4'd6: y = a & b;
            4'd7: y = ~a;
            4'd8: y = {a[0], a[width-1:1]};
            4'd9: y = {a[width-2:0], a[width-1]};
            4'd10: y = a | b;
            4'd11: y = a ^ b;
            4'd12: y = a <<< 1;
            4'd13: y = a >>> 1;
            4'd14: y = (a == b) ? 0 : ((a > b) ? 8'sd1 : -8'sd1);
            4'd15: y = ~(a & b);
            default: begin invalid_op = 1; y = 0; end
        endcase
    end
endmodule
