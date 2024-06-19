module decToHex (score, hex2, hex1, hex0);

input [8:0] score; //score as input
output logic [6:0] hex2, hex1, hex0;

logic [31:0] hund, ten, unit;


always_comb begin
hund = score /100; //find hex2 value
 
ten = (score /10)%10; //find hex1 value

unit = score % 10; //find hex0 value

end

always_comb begin
        if (hund == 1) begin
           hex2 = 7'b1111001;
        end
        else if (hund == 2) begin
           hex2 = 7'b0100100;
        end
		  else if (hund == 3) begin
           hex2 = 7'b0110000;
        end
		  else if (hund == 4) begin
           hex2 = 7'b0011001;
        end
		  else if (hund == 5) begin
           hex2 = 7'b0010010;
        end
		  else if (hund == 6) begin
           hex2 = 7'b0000010;
        end
		  else if (hund == 7) begin
           hex2 = 7'b1111000;
        end
		  else if (hund == 8) begin
           hex2 = 7'b0000000;
        end 
		  else if (hund == 9) begin
           hex2 = 7'b0010000;
        end
		  else if (hund == 0) begin
           hex2 = 7'b1000000;
        end
		  else begin
		     hex2 =  7'b1;
		  end
    end
	 
always_comb begin
        if (ten == 1) begin
           hex1 = 7'b1111001;
        end
        else if (ten == 2) begin
           hex1 = 7'b0100100;
        end
		  else if (ten == 3) begin
           hex1 = 7'b0110000;
        end
		  else if (ten == 4) begin
           hex1 = 7'b0011001;
        end
		  else if (ten == 5) begin
           hex1 = 7'b0010010;
        end
		  else if (ten == 6) begin
           hex1 = 7'b0000010;
        end
		  else if (ten == 7) begin
           hex1 = 7'b1111000;
        end
		  else if (ten == 8) begin
           hex1 = 7'b0000000;
        end 
		  else if (ten == 9) begin
           hex1 = 7'b0010000;
        end
		  else if (ten == 0) begin
           hex1 = 7'b1000000;
        end
		  else begin
		     hex1 =  7'b1;
		  end
    end

 always_comb begin
        if (unit == 1) begin
           hex0 = 7'b1111001;
        end
        else if (unit == 2) begin
           hex0 = 7'b0100100;
        end
		  else if (unit == 3) begin
           hex0 = 7'b0110000;
        end
		  else if (unit == 4) begin
           hex0 = 7'b0011001;
        end
		  else if (unit == 5) begin
           hex0 = 7'b0010010;
        end
		  else if (unit == 6) begin
           hex0 = 7'b0000010;
        end
		  else if (unit == 7) begin
           hex0 = 7'b1111000;
        end
		  else if (unit == 8) begin
           hex0 = 7'b0000000;
        end 
		  else if (unit == 9) begin
           hex0 = 7'b0010000;
        end
		  else if (unit == 0) begin
           hex0 = 7'b1000000;
        end
		  else begin
		     hex0 = 7'b1;
		  end
    end

endmodule

module decToHex_testbench();

    // Inputs
    reg [8:0] score;

    // Outputs
    wire [6:0] hex2;
    wire [6:0] hex1;
    wire [6:0] hex0;

    decToHex dut (
        .score(score), 
        .hex2(hex2), 
        .hex1(hex1), 
        .hex0(hex0)
    );

    // Display values
    initial begin
        $monitor("Time=%0d score=%d -> hex2=%b hex1=%b hex0=%b", $time, score, hex2, hex1, hex0);
    end

    // Stimulus
    initial begin
        // Initialize Inputs
        score = 0;

        // Test cases
        #10 score = 9;
        #10 score = 10;
        #10 score = 21;
        #10 score = 32;
        #10 score = 43;
        #10 score = 54;
        #10 score = 65;
        #10 score = 76;
        #10 score = 87;
        #10 score = 98;
        #10 score = 99;
        #10 score = 100;
        #10 score = 111;
        #10 score = 123;
        #10 score = 134;
        #10 score = 145;
        #10 score = 156;
        #10 score = 167;
        #10 score = 178;
        #10 score = 189;
        #10 score = 200;
        #10 score = 210;
        #10 score = 255;
        #10 score = 300;
        #10 score = 345;
        #10 score = 400;
        #10 score = 450;
        #10 score = 500;
        #10 score = 555;
        #10 score = 600;
        #10 score = 650;
        #10 score = 700;
        #10 score = 750;
        #10 score = 800;
        #10 score = 850;
        #10 score = 900;
        #10 score = 950;
        #10 score = 999;

        // End simulation
        #10 $finish;
    end
endmodule

