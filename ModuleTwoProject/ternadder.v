module ternadder(Cin, x1, x0, y1, y0, x11, x10, y11, y10, s1, s0, s11, s10, C0, C1, P0, G0, P1, G1);
	input Cin, x1, x11, x0, x10, y11, y1, y10, y0;
	output s1, s0, s11, s10, C0, C1, P0, G0, P1, G1;
	
	pAndG stage0(x1, x0, y1, y0, P0, G0);
	pAndG stage1(x11, x10, y11, y10, P1, G1);
	
	assign C0 = G0 | P0 & Cin;
	assign C1 = G1 | P1 & G0 | P1 & P0 & Cin;
	
	assign s1 = (~Cin & ~x1 & ~x0 & y1 & ~y0) | (~Cin & ~x1 & x0 & ~y1 & y0) | (~Cin & x1 & ~x0 & ~y1 & ~y0) | (Cin & ~x1 & ~x0 & ~y1 & y0) | (Cin & ~x1 & x0 & ~y1 & ~y0) | (Cin & x1 & ~x0 & y1 & y0);
	assign s0 = (~Cin & ~x1 & ~x0 & ~y1 & y0) | (~Cin & ~x1 & x0 & ~y1 & ~y0) | (~Cin & x1 & ~x0 & y1 & ~y0) | (Cin & ~x1 & ~x0 & ~y1 & ~y0) | (Cin & ~x1 & x0 & y1 & ~y0) | (Cin & x1 & ~x0 & ~y1 & y0);
	
	assign s11 = (~C0 & ~x11 & ~x10 & y11 & ~y10) | (~C0 & ~x11 & x10 & ~y11 & y10) | (~C0 & x11 & ~x10 & ~y11 & ~y10) | (C0 & ~x11 & ~x10 & ~y11 & y10) | (C0 & ~x11 & x10 & ~y11 & ~y10) | (C0 & x11 & ~x10 & y11 & y10);
	assign s10 = (~C0 & ~x11 & ~x10 & ~y11 & y10) | (~C0 & ~x11 & x10 & ~y11 & ~y10) | (~C0 & x11 & ~x10 & y11 & ~y10) | (C0 & ~x11 & ~x10 & ~y11 & ~y10) | (C0 & ~x11 & x10 & y11 & ~y10) | (C0 & x11 & ~x10 & ~y11 & y10);
	
endmodule 

module pAndG (xin1, xin0, yin1, yin0, P, G);
	input xin1, xin0, yin1, yin0;
	output P, G;
	
	assign G = (~xin1 & xin0 & yin1 & ~yin0) | (xin1 & ~xin0 & ~yin1 & yin0) | (xin1 & ~xin0 & yin1 & ~yin0);
	assign P = (~xin1 & ~xin0 & yin1 & ~yin0) | (~xin1 & xin0 & ~yin1 & yin0) | (xin1 & ~xin0 & ~yin1 & ~yin0);
	
endmodule 