module LFSR_mod(Clock, Reset, Out);

input logic Clock, Reset;
output logic [9:0] Out;

logic xnor_out;
assign xnor_out = (Out[3] ~^ Out[0]);

logic LFSR;
	always_ff @(posedge Clock) begin 
		if (Reset)
            Out <= 10'b0;
      else
            Out <= {xnor_out, Out[9:1]};
	end
endmodule

module LFSR_mod_testbench();
    logic clk, Reset;
    logic [9:0] Out;
    LFSR_mod l(.Clock(clk), .Reset, .Out);
	 
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