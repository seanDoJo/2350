module GuessGame(clock, Reset, Ready, Iter, Digit3, Digit2, Digit1, Digit0);
	input clock, Reset, Ready, Iter;
	wire [3:0]R0, R1, R2, R3;
	output wire [1:7]Digit3, Digit2, Digit1, Digit0;
	reg [3:0] y, dig1En, dig2En, dig3En, dig4En;
	wire [3:0]G0, G1, G2, G3;
	reg [3:0] guesses;
	reg Ren, g1En, g2En, g3En, g4En, gclr;
	
	parameter init = 4'b0001, g1 = 4'b0010, g2 = 4'b0011, g3 = 4'b0100, g4 = 4'b0101, cmp= 4'b0110;
	parameter less = 4'b0111, sub = 4'b1000, win = 4'b1001, lose = 4'b1010;
	
	parameter num = 4'b0000, i = 4'b0001, H = 4'b0010, o = 4'b0011, L = 4'b0100, s = 4'b0101, e = 4'b0110, Ydisp = 4'b0111, A = 4'b1000, P = 4'b1001, Empty = 4'b1010;
	
	initial begin
		y <= init;
		Ren = 1;
		
		g1En = 0;
		g2En = 0;
		g3En = 0;
		g4En = 0;
		
		gclr = 0;
	end
	
	BCDcount random(clock, Ren, R3, R2, R1, R0);
	
	guessSet guess1(G0, g1En, Iter, gclr);
	guessSet guess2(G1, g2En, Iter, gclr);
	guessSet guess3(G2, g3En, Iter, gclr);
	guessSet guess4(G3, g4En, Iter, gclr);
	
	
	seg7 digit1(G0, Digit0, dig1En);
	seg7 digit2(G1, Digit1, dig2En);
	seg7 digit3(G2, Digit2, dig3En);
	seg7 digit4(G3, Digit3, dig4En);

	always @ (posedge Reset, posedge Ready)
	begin
		if (Reset)
		begin
			gclr = 0;
			y <= init;
			Ren <= 1;
		end
		else
			case(y)
				init:
					begin
						
						gclr = 1;
						guesses <= 9;
						
						dig1En <= Ydisp;
						dig2En <= A;
						dig3En <= L;
						dig4En <= P;
						
						y <= g1;
					end
					
				g1:
					begin
						
						g1En = 1;
						gclr = 0;
						Ren <= 0;
						
						dig1En <= num;
						dig2En <= num;
						dig3En <= num;
						dig4En <= num;
						
						y <= g2;
						
					end
					
				g2:
					begin
						g1En = 0;
						g2En = 1;
						y <= g3;
					end
				
				g3:
					begin
						g2En = 0;
						g3En = 1;
						y <= g4;
					end
				
				g4:
					begin
						g3En = 0;
						if (G0 == 4'b0000 && G1 == 4'b0000 && G2 == 4'b0000) g4En = 1;
						y <= cmp;
					end
					
				cmp:
					begin
						g4En = 0;
						if (G3 == R3 && G2 == R2 && G1 == R1 && G0 == R0)
							y <= win;
						else
							y <= less;
					end
				
				less:
					begin
						if (G3 == R3)
						begin
							if (G2 == R2)
							begin
								if (G1 == R1)
								begin
									if (G0 < R0)
									begin
										dig1En <= o;
										dig2En <= L;
										dig3En <= Empty;
										dig4En <= Empty;
									end
									else
									begin
										dig1En <= i;
										dig2En <= H;
										dig3En <= Empty;
										dig4En <= Empty;
									end
								end
								else if (G1 < R1)
								begin
									dig1En <= o;
									dig2En <= L;
									dig3En <= Empty;
									dig4En <= Empty;
								end
								else
								begin
									dig1En <= i;
									dig2En <= H;
									dig3En <= Empty;
									dig4En <= Empty;
								end
							end
							else if (G2 < R2)
							begin
								dig1En <= o;
								dig2En <= L;
								dig3En <= Empty;
								dig4En <= Empty;
							end
							else
							begin
								dig1En <= i;
								dig2En <= H;
								dig3En <= Empty;
								dig4En <= Empty;
							end
						end
						else if (G3 < R3)
						begin
							dig1En <= o;
							dig2En <= L;
							dig3En <= Empty;
							dig4En <= Empty;
						end
						else
						begin
							dig1En <= i;
							dig2En <= H;
							dig3En <= Empty;
							dig4En <= Empty;
						end
						
						y <= sub;
					end
				
				sub:
					begin
						guesses <= guesses - 1;
						if (guesses == 0)
							y <= lose;
						else
						begin
							gclr = 1;
							y <= g1;
						end
					end
				
				lose:
					begin
						dig1En <= e;
						dig2En <= s;
						dig3En <= o;
						dig4En <= L;
						
						gclr = 0;
						y <= init;
						Ren = 1;
					end
				
				win:
					begin
						dig1En <= Ydisp;
						dig2En <= A;
						dig3En <= Ydisp;
						dig4En <= Empty;
						
						gclr = 0;
						y <= init;
						Ren = 1;
					end
				default: y <= 4'bx;
			endcase
	end
endmodule

module BCDcount(clk, En, BCD3, BCD2, BCD1, BCD0);
	input clk, En;
	output reg [3:0]BCD3, BCD2, BCD1, BCD0;
	
	initial begin
		BCD3 <= 0;
		BCD2 <= 0;
		BCD1 <= 0;
		BCD0 <= 0;
	end
	
	always @ (posedge clk)
	begin
		if (En)
		begin
			if (BCD3 == 4'b0001)
			begin
				BCD3 <= 0;
				BCD2 <= 0;
				BCD1 <= 0;
				BCD0 <= 0;
			end
			
			else
			begin
				if(BCD0 == 4'b1001)
				begin
					BCD0 <= 0;
					if(BCD1 == 4'b1001)
					begin
						BCD1 <= 0;
						if (BCD2 == 4'b1001)
						begin
							BCD2 <= 0;
							BCD3 <= 4'b0001;
						end
						else
							BCD2 = BCD2 + 1;
					end
					else
						BCD1 = BCD1 + 1;
				end
				else
					BCD0 = BCD0 + 1;
			end
		end
	end
endmodule

module seg7(bcd, leds, DigEn);
	input [3:0] bcd, DigEn;
	output reg [1:7] leds;
	parameter num = 4'b0000, i = 4'b0001, H = 4'b0010, o = 4'b0011, L = 4'b0100, s = 4'b0101, e = 4'b0110, Y = 4'b0111, A = 4'b1000, P = 4'b1001; 
	
	always @ (bcd, DigEn)
	begin
		case (DigEn)
			num:
				begin
					case(bcd)
						0: leds = 7'b0000001;
						1: leds = 7'b1001111;
						2: leds = 7'b0010010;
						3: leds = 7'b0000110;
						4: leds = 7'b1001100;
						5: leds = 7'b0100100;
						6: leds = 7'b0100000;
						7: leds = 7'b0001111;
						8: leds = 7'b0000000;
						9: leds = 7'b0000100;
						default: leds = 7'bx;
					endcase
				end
			i: leds = 7'b1001111;
			H: leds = 7'b1001000;
			o: leds = 7'b1100010;
			L: leds = 7'b1110001;
			s: leds = 7'b0100100;
			e: leds = 7'b0110000;
			Y: leds = 7'b1000100;
			A: leds = 7'b0001000;
			P: leds = 7'b0011000;
			default: leds = 7'b1111111;
		endcase
	end
endmodule 

module guessSet(Guess, En, Iter, clear);
		output reg [3:0] Guess;
		input En, Iter, clear;
		
		initial begin
			Guess <= 4'b0000;
		end
		
		always @ (posedge Iter, posedge clear)
			if (clear)
				Guess <= 4'b0000;
			else if (En)
				if (Guess == 4'b1001)
					Guess <= 4'b0000;
				else
					Guess <= Guess + 1;
endmodule 