module ternaddmux(x1, x0, x11, x10, y1, y0, y11, y10, s1, s0, s11, s10, Cin, Cout, G0, P0, G1, P1, C0);
input x1, x0, x11, x10, y1, y0, y10, y11, Cin;
output reg s1, s0, s11, s10, Cout, G0, P0, G1, P1, C0;

always @ (x1, x0, x11, x10, Cin) 
	/*calculate G0 and P0*/
	begin
		if (x1 == 0)
			begin
				G0 = x0 & y1 & ~y0;
				P0 = (~x0 & y1 & ~y0) | (x0 & ~y1 & y0);
			end
		else
			begin
				G0 = (~x0 & ~y1 & y0) | (~x0 & y1 &~y0);
				P0 = ~x0 & ~y1 & ~y0;
			end
	/*calculate G1 and P1*/
		if (x11 == 0)
			begin
				G1 = x10 & y11 & ~y10;
				P1 =(~x10 & y11 & ~y10) | (x10 & ~y11 & y10);
			end
		else
			begin
				G1 = (~x10 & ~y11 & y10) | (~x10 & y11 &~y10);
				P1 = ~x10 & ~y11 & ~y10;
			end
	/*calculate C0*/
		if (Cin == 1)
			begin
			C0 = G0 | P0;
			end
		else
			begin
			C0 = G0;
			end
	/*calculate Cout*/
		if (Cin == 1)
			begin
			Cout = G1 | P1 & G0 | P1 & P0;
			end
		else
			begin
			Cout = G1 | P1 & G0;
			end
	/*calculate S0*/
		if (Cin == 1)
			begin
				if (x1 == 1)
					begin
						if (x0 == 0)
							s0 = ~y1 & y0;
						else
							s0 = 0;
					end
				else
					begin
						if (x0 == 1)
							s0 = y1 & ~y0;
						else
							s0 = ~y1 & ~y0;
					end
			end
		else
			begin
				if (x1 == 1)
					begin
						if (x0 == 0)
							s0 = y1 & ~y0;
						else
							s0 = 0;
					end
				else
					begin
						if (x0 == 1)
							s0 = ~y1 & ~y0;
						else
							s0 = ~y1 & y0;
					end
			end
	/*calculate S1*/
		if (Cin == 1)
			begin
			if (x1 == 1)
				begin
					if (x0 == 0)
						s1 = y1 & ~y0;
					else
						s1 = 0;
				end
			else
				begin
					if (x0 == 1)
						s1 = ~y1 & ~y0;
					else
						s1 = ~y1 & y0;
				end
			end
		else
			begin
			if (x1 == 1)
				begin
				if (x0 == 0)
					s1 = ~y1 & ~y0;
				else
					s1 = 0;
				end
			else
				begin
				if (x0 == 1)
					s1 = ~y1 & y0;
				else
					s1 = y1 & ~y0;
				end
			end
	/*calculate S10*/
		if (C0 == 1)
			begin
				if (x11 == 1)
					begin
						if (x10 == 0)
							s10 = ~y11 & y10;
						else
							s10 = 0;
					end
				else
					begin
						if (x10 == 1)
							s10 = y11 & ~y10;
						else
							s10 = ~y11 & ~y10;
					end
			end
		else
			begin
				if (x11 == 1)
					begin
						if (x10 == 0)
							s10 = y11 & ~y10;
						else
							s10 = 0;
					end
				else
					begin
						if (x10 == 1)
							s10 = ~y11 & ~y10;
						else
							s10 = ~y11 & y10;
					end
			end
	/*calculate S11*/
	if (C0 == 1)
		begin
			if (x11 == 1)
				begin
					if (x10 == 0)
						s11 = y11 & ~y10;
					else
						s11 = 0;
				end
			else
				begin
					if (x10 == 1)
						s11 = ~y11 & ~y10;
					else
						s11 = ~y11 & y10;
				end
		end
	else
		begin
			if (x11 == 1)
				begin
					if (x10 == 0)
						s11 = ~y11 & ~y10;
					else
						s11 = 0;
				end
			else
				begin
					if (x10 == 1)
						s11 = ~y11 & y10;
					else
						s11 = y11 & ~y10;
				end
		end
	end
endmodule 
	