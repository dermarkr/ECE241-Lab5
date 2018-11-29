module main(CLOCK_50, SW, HEX0);

input CLOCK_50;
input [1:0] SW;
output [6:0] HEX0;

wire [3:0] out;
wire reset;

mux m0(.select({SW[1],SW[0]}), .clock(CLOCK_50), .reset(reset), .out(out[3:0]));

hexOut h0(.num(out[3:0]), .hex(HEX0[6:0]));

endmodule

module mux(select, clock, reset, out);
input [1:0] select;
input clock, reset;
output [3:0] out;

wire out1, out2, out4;

clock4 c0(.clock(clock), .reset(reset), .clockOut(out4));
clock2 c1(.clock(out4), .reset(reset), .q(out2));
clock2 c2(.clock(out2), .reset(reset), .q(out1));

reg clockOut;

always@(*)
begin
	case(select [1:0])
		2'b00 : clockOut = clock;
		2'b01 : clockOut = out4;
		2'b10 : clockOut = out2;
		2'b11 : clockOut = out1;
		default : clockOut = clock;
	endcase
end

 counter cr(.clock(clockOut), .reset(reset), .num(out[3:0]));

endmodule

module counter(clock, reset, num);
input clock, reset;
output reg [3:0] num;

always@(posedge clock or posedge reset)
begin
	if(reset == 1)
		num<=0;	
	else
		num <= num + 1;
end

endmodule



module clock2(clock, reset, q);
input clock, reset;
output reg q;

always@(posedge clock or posedge reset)
begin
	if(reset == 1)
	begin
		q<=0;
	end		
	else
		q <= q + 1;
end

endmodule


module clock4(clock, reset, clockOut);
input clock, reset;
reg [22:0] q;

//output reg clockOut;
output reg clockOut;

always@(posedge clock or posedge reset)
begin
	if(reset == 1)
	begin
		q<=0;
		clockOut<=0;
	end
	else if(q == 'b10111110101111000010000)
	begin
		q<=0;
		clockOut <= clockOut + 1;
	end		
	else
		q <= q + 1;
end

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