module SevenSensorsPOSProc(X1, X2, X3, X4, X5, X6, X7, f);
	input X1, X2, X3, X4, X5, X6, X7;
	output reg f;
	
	always@(X1, X2, X3, X4, X5, X6, X7)
		if ((~X1 | ~X2 | ~X3 | ~X4 | ~X5 | ~X6) & (~X1 | ~X2 | ~X3 | ~X4 | ~X5 | ~X7) & (~X1 | ~X2 | ~X3 | ~X4 | ~X6 | ~X7) & (~X1 | ~X2 | ~X3 | ~X5 | ~X6 | ~X7) & (~X1 | ~X2 | ~X4 | ~X5 | ~X6 | ~X7) & (~X1 | ~X3 | ~X4 | ~X5 | ~X6 | ~X7) & (~X2 | ~X3 | ~X4 | ~X5 | ~X6 | ~X7))
			f = 1;
		else
			f = 0;
			
endmodule 