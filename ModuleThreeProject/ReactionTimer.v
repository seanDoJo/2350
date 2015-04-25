module ReactionTimer(Clock, Start, Reset, LEDn, Digit1, Digit2, Digit3);
	input Clock, Start, Reset;
	wire c100;
	output wire LEDn;
	output wire[1:7] Digit1, Digit2, Digit3;
	wire [0:6] lfsrOut;
	wire [3:0] BD0, BD1, BD2;
	wire [18:0] Q;
	wire [6:0] downOut;
	reg LED;
	
	
	always @ (posedge Clock)
	begin
		if (!Reset || !Start)
			LED <= 0;
		else if (downOut == 0 && Start)
		begin
			LED <= 1;
		end
	end
	
	assign LEDn = LED;
	clockAdjust lowerFreq(Clock, 1, Q, c100);
	lfsr randomizer(Start, lfsrOut, Clock);
	downCount downcounter(downOut, c100, Start, lfsrOut);
	BCDCount bcdcounter(c100, !Reset, LED, BD2, BD1, BD0);
	sevenSeg seg2(BD2, Digit3);
	sevenSeg seg1(BD1, Digit2);
	sevenSeg seg0(BD0, Digit1);
endmodule

module lfsr(En, OUT, clklf);
	input En, clklf;
	output reg [0:6] OUT;
	initial
	begin
		OUT <= 7'b0110010;
	end
	always @(posedge clklf)
		if (!En)
		begin
			OUT <= {OUT[6] ^ OUT[5], OUT[0], OUT[1], OUT[2], OUT[3], OUT[4], OUT[5]};
		end
endmodule

module downCount(outp, clk, load, R);
	input clk, load;
	input [6:0] R;
	output reg [6:0] outp;
	
	always @ (posedge clk)
		if (!load)
		begin
			outp <= R;
		end
		else if (outp != 7'b000000)
		begin
			outp <= outp - 1;
		end
endmodule

module BCDCount(ck, clear, E, BCD2, BCD1, BCD0);
	input ck, clear, E;
	output reg [3:0] BCD2, BCD1, BCD0;
	
	always @ (posedge ck)
	begin 
		if (clear)
		begin
			BCD2 <= 0;
			BCD1 <= 0;
			BCD0 <= 0;
		end
		else if (E)
			if (BCD0 == 4'b1001)
			begin
				BCD0 <= 0;
				if (BCD1 == 4'b1001)
				begin
					BCD1 <= 0;
					if (BCD2 == 4'b1001)
					begin
						BCD2 <= 0;
					end
					else
						BCD2 <= BCD2 + 1;
				end
				else
					BCD1 <= BCD1 + 1;
			end
			else
				BCD0 <= BCD0 + 1;
	end
endmodule

module sevenSeg(bcd, leds);
	input [3:0] bcd;
	output reg [1:7] leds;
	
	always @ (bcd)
	begin
		case (bcd)
			0: leds = 7'b1111110;
			1: leds = 7'b0110000;
			2: leds = 7'b1101101;
			3: leds = 7'b1111001;
			4: leds = 7'b0110011;
			5: leds = 7'b1011011;
			6: leds = 7'b1011111;
			7: leds = 7'b1110000;
			8: leds = 7'b1111111;
			9: leds = 7'b1111011;
			default: leds = 7'bx;
		endcase
		leds = ~leds;
	end
endmodule

module clockAdjust(Cl, E, Q, clockout);
	parameter n = 19;
	input Cl, E;
	output reg [n-1:0] Q;
	output reg clockout;
	
	initial
	begin
		Q <= 0;
		clockout = 0;
	end
	
	always @ (posedge Cl)
		if (E)
		begin
			Q <= Q + 1;
			clockout = Q[18];
		end
endmodule
					
					
				

			
