module gamePlay(clk, RST, sw8, RedPixels, GrnPixels);
    input logic clk, RST, sw8;
    output logic [15:0][15:0] RedPixels; // 16x16 array of red LEDs
    output logic [15:0][15:0] GrnPixels; // 16x16 array of green LEDs
	 
	 enum { gameOver, a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x, y, z } ps, ns;
	 
	 always_comb begin
case (ps)
    gameOver: begin
				//                  FEDCBA9876543210
		  RedPixels[00] = 16'b0000000000000000;
		  RedPixels[01] = 16'b1111000010010000;
		  RedPixels[02] = 16'b1000000011110000;
		  RedPixels[03] = 16'b1011000011110000;
		  RedPixels[04] = 16'b1001000010010000;
		  RedPixels[05] = 16'b1111000010010000;
		  RedPixels[06] = 16'b0000000000000000;
		  RedPixels[07] = 16'b0000000000000000;
		  RedPixels[08] = 16'b0000000000000000;
		  RedPixels[09] = 16'b0000000000000000;
		  RedPixels[10] = 16'b0000100100001111;
		  RedPixels[11] = 16'b0000100100001001;
		  RedPixels[12] = 16'b0000100100001111;
		  RedPixels[13] = 16'b0000100100001010;
		  RedPixels[14] = 16'b0000011000001001;
		  RedPixels[15] = 16'b0000000000000000;
		  
		  //                  FEDCBA9876543210
		  GrnPixels[00] = 16'b0000000000000000;
		  GrnPixels[01] = 16'b0000111100001111;
		  GrnPixels[02] = 16'b0000100100001000;
		  GrnPixels[03] = 16'b0000111100001111;
		  GrnPixels[04] = 16'b0000100100001000;
		  GrnPixels[05] = 16'b0000100100001111;
		  GrnPixels[06] = 16'b0000000000000000;
		  GrnPixels[07] = 16'b0000000000000000;
		  GrnPixels[08] = 16'b0000000000000000;
		  GrnPixels[09] = 16'b0000000000000000;
		  GrnPixels[10] = 16'b1111000011110000;
		  GrnPixels[11] = 16'b1001000010000000;
		  GrnPixels[12] = 16'b1001000011110000;
		  GrnPixels[13] = 16'b1001000010000000;
		  GrnPixels[14] = 16'b1111000011110000;
		  GrnPixels[15] = 16'b0000000000000000;;

            if (sw8)    
                ns = a;
            
            else                   
                ns = gameOver;
        end
    LtR001: begin
	 out = 3'b001;
            if (!sw1 && !sw0)      //SW[1] = 0 && SW[0] = 0 
                ns = calm101;
            else if (!sw1 && sw0)  //SW[1] = 0 && SW[0] = 1 
                ns = mid010;
            else                   //SW[1] = 1 && SW[0] = 0 
                ns = RtL100;
        end
endcase
end

//when reset, goes to calm state
always_ff @(posedge clk) begin
if (RST)
ps <= gameOver;
else
ps <= ns;
end
endmodule








module gamePlay_testbench();

	logic RST;
	logic [15:0][15:0] RedPixels, GrnPixels;
	
	LED_test dut (.RST, .RedPixels, .GrnPixels);
	
	initial begin
	RST = 1'b1; #10;
	RST = 1'b0; #10;
	end
	
endmodule