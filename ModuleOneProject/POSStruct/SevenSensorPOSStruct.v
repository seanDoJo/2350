module SevenSensorPOSStruct(X1, X2, X3, X4, X5, X6, X7, f);
	input X1, X2, X3, X4, X5, X6, X7;
	output f;
	wire X1n, X2n, X3n, X4n, X6n, X7n;
	wire or1, or2, or3, or4, or5, or6, or7;
	
	not(X1n, X1);
	not(X2n, X2);
	not(X3n, X3);
	not(X4n, X4);
	not(X5n, X5);
	not(X6n, X6);
	not(X7n, X7);
	
	or(or1, X1n, X2n, X3n, X4n, X5n, X6n);
	or(or2, X1n, X2n, X3n, X4n, X5n, X7n);
	or(or3, X1n, X2n, X3n, X4n, X6n, X7n);
	or(or4, X1n, X2n, X3n, X5n, X6n, X7n);
	or(or5, X1n, X2n, X4n, X5n, X6n, X7n);
	or(or6, X1n, X3n, X4n, X5n, X6n, X7n);
	or(or7, X2n, X3n, X4n, X5n, X6n, X7n);
	
	and(f, or1, or2, or3, or4, or5, or6, or7);
endmodule 