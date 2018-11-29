module main(CLOCK_50, LEDR, SW, KEY);
input CLOCK_50;
input [2:0] SW;
input [1:0] KEY;
output [0:0] LEDR;

wire clockRed;
wire [13:0] whole;
wire [13:0] code;

letterselect ls(.select(SW[2:0]), .activate(KEY[1]), .code(code[13:0]));


LSLeft s0(.letter(code[13:0]), .clock(CLOCK_50), .load(KEY[1]), .reset(KEY[0]), .out(LEDR[0]), .pass(whole[13:0]), .clockOut(clockRed));


endmodule


module letterselect(select, activate, code);
input [2:0] select;
input activate;
output reg [13:0] code;

always@(negedge activate)
begin
	case(select)
		3'b000 : code = 14'b01010100000000;
		3'b001 : code = 14'b01110000000000;
		3'b010 : code = 14'b01010111000000;
		3'b011 : code = 14'b01010101110000;
		3'b100 : code = 14'b01011101110000;
		3'b101 : code = 14'b01110101011100;
		3'b110 : code = 14'b01110101110111;
		3'b111 : code = 14'b01110111010100;
		default: code = 14'b00000000000000;
	endcase
end

endmodule


module clock2(clock, reset, clockOut);
input clock, reset;
reg [23:0] q;

output reg clockOut;

always@(posedge clock or negedge reset)
begin
	if(reset == 0)
	begin
		q<=0;
		clockOut <= 0;
	end
	else if(q == 24'b10111110101111000010000)
	begin
		q<=0;
		clockOut <= clockOut + 1;
	end
	else
		q <= q + 1;
end

endmodule


module LSLeft(letter, clock, load, reset, out, pass, clockOut);
input [13:0] letter;

input reset, clock, load;
output out;

output clockOut;

output [13:0] pass;

clock2 c0(.clock(clock), .reset(reset), .clockOut(clockOut));


shift s0(.clock(clockOut), .reset(reset), .loadn(load), .InR(0), .d(letter[0]), .Out(pass[0]));
shift s1(.clock(clockOut), .reset(reset), .loadn(load), .InR(pass[0]), .d(letter[1]), .Out(pass[1]));
shift s2(.clock(clockOut), .reset(reset), .loadn(load), .InR(pass[1]), .d(letter[2]), .Out(pass[2]));
shift s3(.clock(clockOut), .reset(reset), .loadn(load), .InR(pass[2]), .d(letter[3]), .Out(pass[3]));
shift s4(.clock(clockOut), .reset(reset), .loadn(load), .InR(pass[3]), .d(letter[4]), .Out(pass[4]));
shift s5(.clock(clockOut), .reset(reset), .loadn(load), .InR(pass[4]), .d(letter[5]), .Out(pass[5]));
shift s6(.clock(clockOut), .reset(reset), .loadn(load), .InR(pass[5]), .d(letter[6]), .Out(pass[6]));
shift s7(.clock(clockOut), .reset(reset), .loadn(load), .InR(pass[6]), .d(letter[7]), .Out(pass[7]));
shift s8(.clock(clockOut), .reset(reset), .loadn(load), .InR(pass[7]), .d(letter[8]), .Out(pass[8]));
shift s9(.clock(clockOut), .reset(reset), .loadn(load), .InR(pass[8]), .d(letter[9]), .Out(pass[9]));
shift s10(.clock(clockOut), .reset(reset), .loadn(load), .InR(pass[9]), .d(letter[10]), .Out(pass[10]));
shift s11(.clock(clockOut), .reset(reset), .loadn(load), .InR(pass[10]), .d(letter[11]), .Out(pass[11]));
shift s12(.clock(clockOut), .reset(reset), .loadn(load), .InR(pass[11]), .d(letter[12]), .Out(pass[12]));
shift s13(.clock(clockOut), .reset(reset), .loadn(load), .InR(pass[12]), .d(letter[13]), .Out(out));





endmodule


module shift(clock, reset, loadn, InR, d, Out);
input clock;
input reset;
input loadn;
input InR, d;
output Out;

wire temp1;

mux2to1 m2(.y(InR), .x(d), .s(loadn), .m(temp1));
bitregister b1(.clock(clock), .Reset_b(reset), .loadn(loadn), .d(temp1), .q(Out));

endmodule


module mux2to1(x, y, s, m);
    input x; //select 0
    input y; //select 1
    input s; //select signal
    output m; //output
  
    assign m = s ? y : x;

endmodule


module bitregister(clock, Reset_b, loadn, d, q);

	input clock;
	input Reset_b;
	input d;
	input loadn;
	output reg q;

	always@(posedge clock or negedge Reset_b)
	begin
		if(Reset_b == 1'b0)
			q<=0;
		else
			q<=d;
	end

endmodule