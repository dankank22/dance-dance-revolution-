module DE1_SoC (
    output logic [6:0]  HEX0, HEX1, HEX2, HEX3, HEX4, HEX5,
    output logic [9:0]  LEDR,
    input  logic [3:0]  KEY,
    input  logic [9:0]  SW,
    output logic [35:0] GPIO_1,
    input  logic CLOCK_50
);

    // Turn off HEX displays
    
	 
    

    // Clock divider
    logic [31:0] Clock;
    logic SYSTEM_CLOCK;
    logic game_clk;
	 logic timer_clk;
    clock_divider divider (.clock(CLOCK_50), .divided_clocks(Clock));
    assign SYSTEM_CLOCK = Clock[14]; // 1526 Hz clock signal
	 assign timer_clk = Clock[25];
    

    // Speed control logic
    logic [4:0] speed;

    always_comb begin
        if (SW[6]) begin
            speed = 5'd19;
        end else if (SW[5]) begin
            speed = 5'd20;
        end else if (SW[4]) begin
            speed = 5'd21;
        end else if (SW[3]) begin
            speed = 5'd22;
        end else if (SW[2]) begin
            speed = 5'd23;
        end else if (SW[1]) begin
            speed = 5'd24;
        end else if (SW[0]) begin
            speed = 5'd25;
        end else begin
            speed = 5'd22; // Default speed if no switch is turned on
        end
    end
	 
	 assign game_clk = Clock[speed];
	

    // LED board driver
    logic [15:0][15:0] RedPixels; // 16 x 16 array representing red LEDs
    logic [15:0][15:0] GrnPixels; // 16 x 16 array representing green LEDs
    logic reset; // reset signal

    assign reset = ~SW[9];

    // LED Driver instantiation
    LEDDriver Driver (
        .GPIO_1(GPIO_1),
        .CLK(SYSTEM_CLOCK),
        .RST(reset),
        .EnableCount(1'b1),
        .RedPixels(RedPixels),
        .GrnPixels(GrnPixels)
    );
     
	      //gamePlay g (.clk(game_clk), .reset, .highScoreDisplay(SW[8]), .clearHighScore(SW[7]), .key3(KEY[3]), .key2(KEY[2]), .key1(KEY[1]), .key0(KEY[0]), .RedPixels, .GrnPixels, .hex2(HEX2), .hex1(HEX1), .hex0(HEX0), .hex5(HEX5), .hex4(HEX4), .hex3(HEX3));

	     gamePlay g (.clk(game_clk), .timer_clk, .reset, .highScoreDisplay(SW[8]), .clearHighScore(SW[7]), .speedSW(SW[6:0]), .key3(KEY[3]), .key2(KEY[2]), .key1(KEY[1]), .key0(KEY[0]),.RedPixels, .GrnPixels, .hex2(HEX2), .hex1(HEX1), .hex0(HEX0), .hex5(HEX5), .hex4(HEX4), .hex3(HEX3));
endmodule
