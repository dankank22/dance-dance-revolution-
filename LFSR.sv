module LFSR(Out, clk, rst);

			 
		input logic clk, rst;
		output logic [15:0] Out;

		logic xnor_out;
		assign xnor_out = (Out[0] ~^ Out[1] ~^ Out[3] ~^ Out[12]);

			always_ff @(posedge clk) begin 
				if (rst)
						Out <= 16'b0;
				else
						Out <= {xnor_out, Out[15:1]};
			end
endmodule

module LFSR_testbench();
    logic clk, Reset;
    logic [15:0] Out;
    LFSR l(.clk, .rst(Reset), .Out);
	 
	 parameter CLOCK_PERIOD=100;
     initial begin
      clk <= 0;
     forever #(CLOCK_PERIOD/2) clk <= ~clk; // Forever toggle the clock
     end

    // Set up the inputs to the design. Each line is a clock cycle.
    initial begin
			repeat(1); @(posedge clk);
			Reset <= 1; repeat(1) @(posedge clk); // Always reset FSMs at start
			Reset <= 0; repeat(100) @(posedge clk);
			$stop; // End the simulation.
    end
endmodule


