module main(SW, KEY, HEX0, HEX1);

input [1:0] SW;
input [0:0] KEY;
output [6:0] HEX0, HEX1;

wire q0, q1, q2, q3, q4, q5, q6, q7;
wire t1, t2 ,t3, t4, t5, t6, t7, t8;

tflipflop tf0(.clock(KEY[0]), .Reset_b(SW[0]), .t(SW[1]), .q(q0), .tnext(t1));
tflipflop tf1(.clock(KEY[0]), .Reset_b(SW[0]), .t(t1), .q(q1), .tnext(t2));
tflipflop tf2(.clock(KEY[0]), .Reset_b(SW[0]), .t(t2), .q(q2), .tnext(t3));
tflipflop tf3(.clock(KEY[0]), .Reset_b(SW[0]), .t(t3), .q(q3), .tnext(t4));
tflipflop tf4(.clock(KEY[0]), .Reset_b(SW[0]), .t(t4), .q(q4), .tnext(t5));
tflipflop tf5(.clock(KEY[0]), .Reset_b(SW[0]), .t(t5), .q(q5), .tnext(t6));
tflipflop tf6(.clock(KEY[0]), .Reset_b(SW[0]), .t(t6), .q(q6), .tnext(t7));
tflipflop tf7(.clock(KEY[0]), .Reset_b(SW[0]), .t(t7), .q(q7), .tnext(t8));

hexOut h0(.num({q3,q2,q1,q0}), .hex(HEX0[6:0]));
hexOut h1(.num({q7,q6,q5,q4}), .hex(HEX1[6:0]));

endmodule


module tflipflop(clock, Reset_b, t, q, tnext);

	input clock;
	input Reset_b;
	input t;
	output reg q;
	output tnext;
	wire d;
	
	assign d = t ^ q;	

	always@(posedge clock or negedge Reset_b)
	begin
		if(Reset_b == 1'b0)
			q<=0;
		else
			q<=d;
	end
	
	assign tnext = q & t;

endmodule



module hexOut(num, hex);
	input [3:0] num;
	output reg [6:0] hex;

	always@(*)
	begin
		case(num[3:0])
			4'b0000: {hex[6:0]} = 'b1000000; //0
			4'b0001: {hex[6:0]} = 'b1111001; //1
			4'b0010: {hex[6:0]} = 'b0100100; //2
			4'b0011: {hex[6:0]} = 'b0110000; //3
			4'b0100: {hex[6:0]} = 'b0011001; //4
			4'b0101: {hex[6:0]} = 'b0010010; //5
			4'b0110: {hex[6:0]} = 'b0000010; //6
			4'b0111: {hex[6:0]} = 'b1111000; //7
			4'b1000: {hex[6:0]} = 'b0000000; //8
			4'b1001: {hex[6:0]} = 'b0010000; //9
			4'b1010: {hex[6:0]} = 'b0001000; //A
			4'b1011: {hex[6:0]} = 'b0000011; //b
			4'b1100: {hex[6:0]} = 'b1000110; //C
			4'b1101: {hex[6:0]} = 'b0100001; //d
			4'b1110: {hex[6:0]} = 'b0000110; //E
			4'b1111: {hex[6:0]} = 'b0001110; //F
			default: {hex[6:0]} = 'b0000000; 
		endcase
	end
	
endmodule