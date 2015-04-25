module SevenSensorSOPStruct(X1, X2, X3, X4, X5, X6, X7, f);
	input X1, X2, X3, X4, X5, X6, X7;
	wire X1n, X2n, X3n, X4n, X5n, X6n, X7n, X1X2, X1X3, X1X4, X1X5, X1X6, X1X7;
	wire X2X3, X2X4, X2X5, X2X6, X2X7;
	wire X3X4, X3X5, X3X6, X3X7;
	wire X4X5, X4X6, X4X7;
	wire X5X6, X5X7, X6X7;
	output f;
	
	not(X1n, X1);
	not(X2n, X2);
	not(X3n, X3);
	not(X4n, X4);
	not(X5n, X5);
	not(X6n, X6);
	not(X7n, X7);
	
	and(X1X2, X1n, X2n);
	and(X1X3, X1n, X3n);
	and(X1X4, X1n, X4n);
	and(X1X5, X1n, X5n);
	and(X1X6, X1n, X6n);
	and(X1X7, X1n, X7n);
	
	and(X2X3, X2n, X3n);
	and(X2X4, X2n, X4n);
	and(X2X5, X2n, X5n);
	and(X2X6, X2n, X6n);
	and(X2X7, X2n, X7n);
	
	and(X3X4, X3n, X4n);
	and(X3X5, X3n, X5n);
	and(X3X6, X3n, X6n);
	and(X3X7, X3n, X7n);
	
	and(X4X5, X4n, X5n);
	and(X4X6, X4n, X6n);
	and(X4X7, X4n, X7n);
	
	and(X5X6, X5n, X6n);
	and(X5X7, X5n, X7n);
	
	and(X6X7, X6n, X7n);
	
	or(f, X1X2, X1X3, X1X4, X1X5, X1X6, X1X7, X2X3, X2X4, X2X5, X2X6, X2X7, X3X4, X3X5, X3X6, X3X7, X4X5, X4X6, X4X7, X5X6, X5X7, X6X7);
endmodule 