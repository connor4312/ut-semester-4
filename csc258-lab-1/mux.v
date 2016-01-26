`timescale 1ns / 1ns // `timescale time_unit/time_precision

//SW[2:0] data inputs
//SW[9] select signal

//LEDR[0] output display

// Corresponding with the schematic:
//  SW[0] is u
//  SW[1] is v
//  SW[2] is w
//  SW[3] is v
//  SW[8] is s_0
//  SW[9] is s_1
//  LEDR[0] is m
module mux(LEDR, SW);
        input [9:0] SW;
        output [9:0] LEDR;

    wire Conn1;
    wire Conn2;

    mux2to1 u0(
        .x(SW[0]),
        .y(SW[1]),
        .s(SW[8]),
        .m(Conn1)
        );

    mux2to1 u1(
        .x(SW[2]),
        .y(SW[3]),
        .s(SW[8]),
        .m(Conn2)
        );

    mux2to1 u2(
        .x(Conn1),
        .y(Conn2),
        .s(SW[9]),
        .m(LEDR[0])
        );

endmodule

module mux2to1(x, y, s, m);
    input x; //selected when s is 0
    input y; //selected when s is 1
    input s; //select signal
    output m; //output

    assign m = s & y | ~s & x;
    // OR
    // assign m = s ? y : x;

endmodule
