module comparator(a, b, out);

input logic [9:0]a;
input logic [9:0]b;
output logic out;

always_comb begin
        out = 0;
        for (int i = 9; i >= 0; i = i - 1) begin
            if (a[i] & ~b[i]) begin
                out = 1;
                break;
            end
            if (~a[i] & b[i]) begin
                out = 0;
                break;
            end
			end
    end
	 
endmodule

module comparator_testbench();

logic [9:0]a;
logic [9:0]b;
logic out;

comparator dut(.a, .b, .out);

initial begin
a <= 10'b1111100000; //992
b <= 10'b1100101001; //809
#10;

a <= 10'b1100101001; //809
b <= 10'b1111100000; //992
#10;

a <= 10'b1111100000; //992
b <= 10'b1111100000; //992
#10;

a <= 10'b0; //0
b <= 10'b1; //1
#10;
$stop; // End the simulation.
end
endmodule