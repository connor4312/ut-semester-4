module alu(KEY, SW, LEDR, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
    input[2:0] KEY;
    input[9:0] SW;
    output[7:0] LEDR;
    output[6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;

    wire [4:0] a1;
    ripple_carry_adder adder1(.SW(SW[8:0]), .LEDR(a1));

    sevenseg s0(.HEX(HEX0), .SW(SW[7:4]));
    sevenseg s1(.HEX(HEX1), .SW(4'b0000));
    sevenseg s2(.HEX(HEX2), .SW(SW[3:0]));
    sevenseg s3(.HEX(HEX3), .SW(4'b0000));

    wire [7:0] ALUout;

    mux7to1 m(
        .funcs(KEY),
        .a0({ a1, 3'b000 }),
        .a1({ SW[3:0] + SW[7:4], 4'b0000}),
        .a2({ SW[3:0] ^ SW[7:4], SW[3:0] | SW[7:4] }),
        .a3({ 7'b0000000, | (SW[3:0] | SW[7:4]) }),
        .a4({ 7'b0000000, & (SW[3:0] & SW[7:4]) }),
        .a5({ SW[3:0], SW[7:4] }),
        .out(ALUout));

    sevenseg s4(.HEX(HEX4), .SW(ALUout[3:0]));
    sevenseg s5(.HEX(HEX5), .SW(ALUout[7:4]));
    assign LEDR = ALUout;
endmodule

module mux7to1(funcs, a0, a1, a2, a3, a4, a5, out);
    input[2:0] funcs;
    input[7:0] a0, a1, a2, a3, a4, a5;
    output[7:0] out;

    reg [7:0] Out;
    always@(*)
    begin
        case(funcs)
            3'b000: Out = a0;
            3'b001: Out = a1;
            3'b010: Out = a2;
            3'b011: Out = a3;
            3'b100: Out = a4;
            3'b101: Out = a5;
            default: Out = 0;
        endcase
    end
    assign out = Out;
endmodule

module ripple_carry_adder(SW, LEDR);
    input [8:0] SW;         //inputs for a, b, and carry in
    output [4:0] LEDR;  //outputs

    wire carry_1;
    wire carry_2;
    wire carry_3;

    full_adder fa_1 (
        .a(SW[4]),
        .b(SW[0]),
        .ci(SW[8]),
        .s(LEDR[0]),
        .co(carry_1)
        );

    full_adder fa_2 (
        .a(SW[5]),
        .b(SW[1]),
        .ci(carry_1),
        .s(LEDR[1]),
        .co(carry_2)
        );

    full_adder fa_3 (
        .a(SW[6]),
        .b(SW[2]),
        .ci(carry_2),
        .s(LEDR[2]),
        .co(carry_3)
        );

    full_adder fa_4 (
        .a(SW[7]),
        .b(SW[3]),
        .ci(carry_3),
        .s(LEDR[3]),
        .co(LEDR[4])
        );
endmodule


module full_adder(a, b, ci, s, co);
    input a, b, ci;
    output s, co;

    wire w1;

    assign w1 = a ^ b;

    mux2to1 m0 (
        .x(b),
        .y(ci),
        .s(w1),
        .m(co)
        );

    assign s = w1 ^ ci;


endmodule


module mux2to1(x, y, s, m);
    input x; //selected when s is 0
    input y; //selected when s is 1
    input s; //select signal
    output m; //output

    assign m = s & y | ~s & x;

endmodule

module sevenseg(HEX, SW);
    input [3:0] SW;
    output [6:0] HEX;

    decode0 d0(.in(SW), .out(HEX[0]));
    decode1 d1(.in(SW), .out(HEX[1]));
    decode2 d2(.in(SW), .out(HEX[2]));
    decode3 d3(.in(SW), .out(HEX[3]));
    decode4 d4(.in(SW), .out(HEX[4]));
    decode5 d5(.in(SW), .out(HEX[5]));
    decode6 d6(.in(SW), .out(HEX[6]));
endmodule

module decode0(in, out);
    input [3:0] in;
    output out;

    assign out = in[0] & ~in[1] & ~in[2] |
        ~in[0] & in[1] & in[3] |
        ~in[1] & ~in[3] |
        ~in[0] & in[2] |
        in[0] & ~in[3] |
        in[1] & in[2];
endmodule

module decode1(in, out);
    input [3:0] in;
    output out;

    assign out = ~in[0] & ~in[2] & ~in[3] |
        ~in[0] & in[2] & in[3] |
        in[0] & ~in[2] & in[3] |
        ~in[1] & ~in[3] |
        ~in[0] & ~in[1];
endmodule

module decode2(in, out);
    input [3:0] in;
    output out;

    assign out = ~in[2] & in[3] |
        ~in[0] & in[1] |
        in[0] & ~in[1] |
        ~in[0] & in[3] |
        ~in[0] & ~in[2];
endmodule

module decode3(in, out);
    input [3:0] in;
    output out;

    assign out = in[1] & ~in[2] & in[3] |
        in[0] & ~in[2] |
        in[1] & in[2] & ~in[3] |
        ~in[1] & in[2] & in[3] |
        ~in[0] & ~in[1] & ~in[3];
endmodule

module decode4(in, out);
    input [3:0] in;
    output out;

    assign out = ~in[1] & ~in[3] |
        in[2] & ~in[3] |
        in[0] & in[2] |
        in[0] & in[1];
endmodule

module decode5(in, out);
    input [3:0] in;
    output out;

    assign out = ~in[0] & in[1] & ~in[2] |
        ~in[2] & ~in[3] |
        in[1] & ~in[3] |
        in[0] & ~in[1] |
        in[0] & in[2];
endmodule

module decode6(in, out);
    input [3:0] in;
    output out;

// ~bc + a~b + ad + c~d + ~ab~c

    assign out = ~in[1] & in[2] |
        in[0] & ~in[1] |
        in[0] & in[3] |
        in[2] & ~in[3] |
        ~in[0] & in[1] & ~in[2];
endmodule

