module SevenSensorSOPContinuous(X1, X2, X3, X4, X5, X6, X7, f);
	input X1, X2, X3, X4, X5, X6, X7;
	output f;
	wire a1, a2, a3, a5, a6, b1, b2, b3, b4, b5, c1, c2, c3, c4, d1, d2, d3, e1, e2, g1;
	
	assign a1 = ~X1 & ~X2;
	assign a2 = ~X1 & ~X3;
	assign a3 = ~X1 & ~X4;
	assign a4 = ~X1 & ~X5;
	assign a5 = ~X1 & ~X6;
	assign a6 = ~X1 & ~X7;
	
	assign b1 = ~X2 & ~X3;
	assign b2 = ~X2 & ~X4;
	assign b3 = ~X2 & ~X5;
	assign b4 = ~X2 & ~X6;
	assign b5 = ~X2 & ~X7;
	
	assign c1 = ~X3 & ~X4;
	assign c2 = ~X3 & ~X5;
	assign c3 = ~X3 & ~X6;
	assign c4 = ~X3 & ~X7;
	
	assign d1 = ~X4 & ~X5;
	assign d2 = ~X4 & ~X6;
	assign d3 = ~X4 & ~X7;
	
	assign e1 = ~X5 & ~X6;
	assign e2 = ~X5 & ~X7;
	
	assign g1 = ~X6 & ~X7;
	
	assign f = a1 | a2 | a3 | a5 | a6 | b1 | b2 | b3 | b4 | b5 | c1 | c2 | c3 | c4 | d1 | d2 | d3 | e1 | e2 | g1;
	
endmodule 