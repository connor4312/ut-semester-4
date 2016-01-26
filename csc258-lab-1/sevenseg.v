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

