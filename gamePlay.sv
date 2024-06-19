module gamePlay(
    input logic clk,          // Clock[22]
    input logic timer_clk,    // Clock[25]
    input logic reset,
    input logic highScoreDisplay,
    input logic clearHighScore,
    input logic [6:0] speedSW,
    input logic key3,
    input logic key2,
    input logic key1,
    input logic key0,
    output logic [15:0][15:0] RedPixels,
    output logic [15:0][15:0] GrnPixels,
    output logic [6:0] hex2,
    output logic [6:0] hex1,
    output logic [6:0] hex0,
    output logic [6:0] hex5,
    output logic [6:0] hex4,
    output logic [6:0] hex3
);

    assign hex3 = 7'b1111111; // HEX 3 NOT USED

    // LFSR FOR TILE PATTERN
    logic [15:0] lfsr_pattern;
    LFSR lfsr_inst (.Out(lfsr_pattern), .clk(clk), .rst(reset));

    logic [8:0] score; // game score
    logic [8:0] highScore; // all-time highscore initialized to 0

    logic [6:0] hex2_2, hex1_2, hex0_2; // hexes for score
    logic [6:0] hex2_1, hex1_1, hex0_1; // hexes for high score

    logic [15:0][15:0] nextRedPixels, nextGrnPixels; // updated red and green pixels

    // Timer variables
    logic [4:0] timer;
    logic [6:0] hex5_disp, hex4_disp; // hexes for timer

    decToHex timer_to_hex (.score({4'b0, timer}), .hex2(), .hex1(hex5_disp), .hex0(hex4_disp)); // conversion of timer to hex display

    // Score to hex conversion
    decToHex dh1 (.score(score), .hex2(hex2_1), .hex1(hex1_1), .hex0(hex0_1)); // conversion of score to hex display
    decToHex dh2 (.score(highScore), .hex2(hex2_2), .hex1(hex1_2), .hex0(hex0_2)); // conversion of high score to hex display

    logic gameOver;

    logic [9:0] lfsr_output; // LFSR FOR SPEED TOGGLE
    logic speed; // speed signal

    LFSR_mod l (.Clock(clk), .Reset(reset), .Out(lfsr_output));
    comparator comp1 (.a({3'b0, speedSW[6:0]}), .b(lfsr_output), .out(speed));
    
    logic [10:0] counter;

    // Timer decrement logic
    always_ff @(posedge timer_clk or posedge reset) begin
        if (reset) begin
            timer <= 30;
        end else begin
            
            if (timer != 0) begin
                timer <= timer - 1;
            end 
        end
    end

    // Main logic with clk for key responsiveness and tile generation
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            nextRedPixels <= '{default: 16'b0};
            nextGrnPixels <= '{default: 16'b0};
            RedPixels <= '{default: 16'b0};
            GrnPixels <= '{default: 16'b0};
            score <= 0;
        end else begin
            // Shift pixels up
            for (int i = 1; i < 16; i++) begin
                nextRedPixels[i-1] = RedPixels[i];
                nextGrnPixels[i-1] = GrnPixels[i];
            end
				
				// Update RedPixels and GrnPixels
            RedPixels <= nextRedPixels;
            GrnPixels <= nextGrnPixels;
				
				// Key handling
            if (~key3) begin
                GrnPixels[0][15:12] <= 4'b1111;
                RedPixels[0][15:12] <= 4'b1111;
            end 
            if (~key2) begin
                GrnPixels[0][11:8] <= 4'b1111;
                RedPixels[0][11:8] <= 4'b1111;
            end 
            if (~key1) begin
                GrnPixels[0][7:4] <= 4'b1111;
                RedPixels[0][7:4] <= 4'b1111;
            end 
            if (~key0) begin
                GrnPixels[0][3:0] <= 4'b1111;
                RedPixels[0][3:0] <= 4'b1111;
            end 
				

            // Assign new random pattern to the first row
            nextRedPixels[15][15:12] <= {4{lfsr_pattern[0]}};
            nextGrnPixels[15][11:8] <= {4{lfsr_pattern[4]}};
            nextRedPixels[15][7:4] <= {4{lfsr_pattern[8]}};
            nextGrnPixels[15][3:0] <= {4{lfsr_pattern[12]}};

            
            // Light hit detection
            if ((RedPixels[0][15:12] == 4'b1111 & ~key3) ||
                (GrnPixels[0][11:8] == 4'b1111 & ~key2) ||
                (RedPixels[0][7:4] == 4'b1111 & ~key1) ||
                (GrnPixels[0][3:0] == 4'b1111 & ~key0)) begin
                score <= score + 2;
					 //highScore <= highScore + 2;
            end else if ((RedPixels[1][15:12] == 4'b1111 & RedPixels[0][15:12] == 4'b0000 & ~key3) ||
                        (GrnPixels[1][11:8] == 4'b1111 & GrnPixels[0][11:8] == 4'b0000 & ~key2) ||
                        (RedPixels[1][7:4] == 4'b1111 & RedPixels[0][7:4] == 4'b0000 & ~key1) ||
                        (GrnPixels[1][3:0] == 4'b1111 & GrnPixels[0][3:0] == 4'b0000 & ~key0)) begin
                score <= score + 1;
					 //highScore <= highScore + 1;
            end else if (((RedPixels[1][15:12] == 4'b0000 & RedPixels[0][15:12] == 4'b0000 & ~key3) ||
                         (GrnPixels[1][11:8] == 4'b0000 & RedPixels[0][11:8] == 4'b0000 & ~key2) ||
                         (RedPixels[1][7:4] == 4'b0000 & RedPixels[0][7:4] == 4'b0000 & ~key1) ||
                         (GrnPixels[1][3:0] == 4'b0000 & RedPixels[0][3:0] == 4'b0000 & ~key0)) & score >= 2) begin
                score <= score - 2;
					 //highScore <= highScore - 2;
            end

            if (clearHighScore & ~highScoreDisplay & ~reset) begin
                highScore <= 0;
            end else if (score > highScore) begin
                highScore <= score;
            end
        end
    end

    always_comb begin
        if (highScoreDisplay) begin
            // Display high score
            hex5 = 7'b0001001; // 'H'
            hex4 = 7'b1001111; // 'I'
            hex2 = hex2_2;
            hex1 = hex1_2;
            hex0 = hex0_2;
        end else begin
            // Normal game play display
            hex5 = hex5_disp;
            hex4 = hex4_disp;
            hex2 = hex2_1;
            hex1 = hex1_1;
            hex0 = hex0_1;
        end
    end

endmodule

module gamePlay_testbench();

    // Inputs
    reg clk;
    reg timer_clk;
    reg reset;
    reg highScoreDisplay;
    reg clearHighScore;
    reg [6:0] speedSW;
    reg key3;
    reg key2;
    reg key1;
    reg key0;

    // Outputs
    wire [15:0][15:0] RedPixels;
    wire [15:0][15:0] GrnPixels;
    wire [6:0] hex2;
    wire [6:0] hex1;
    wire [6:0] hex0;
    wire [6:0] hex5;
    wire [6:0] hex4;
    wire [6:0] hex3;

    
    gamePlay dut (
        .clk(clk),
        .timer_clk(timer_clk),
        .reset(reset),
        .highScoreDisplay(highScoreDisplay),
        .clearHighScore(clearHighScore),
        .speedSW(speedSW),
        .key3(key3),
        .key2(key2),
        .key1(key1),
        .key0(key0),
        .RedPixels(RedPixels),
        .GrnPixels(GrnPixels),
        .hex2(hex2),
        .hex1(hex1),
        .hex0(hex0),
        .hex5(hex5),
        .hex4(hex4),
        .hex3(hex3)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 100 MHz clock
    end

    initial begin
        timer_clk = 0;
        forever #50 timer_clk = ~timer_clk; // Slower clock for timer
    end

    // Initial setup and stimulus
    initial begin
        // Initialize Inputs
        reset = 1;
        highScoreDisplay = 0;
        clearHighScore = 0;
        speedSW = 7'b0;
        key3 = 1;
        key2 = 1;
        key1 = 1;
        key0 = 1;

        // Wait for global reset to finish
        #100;
        
        reset = 0;

        // Simulate key presses
        #100;
        key3 = 0; #20; key3 = 1; // Press and release key3
        #100;
        key2 = 0; #20; key2 = 1; // Press and release key2
        #100;
        key1 = 0; #20; key1 = 1; // Press and release key1
        #100;
        key0 = 0; #20; key0 = 1; // Press and release key0

        // Simulate high score display
        #200;
        highScoreDisplay = 1;
        #100;
        highScoreDisplay = 0;

        // Simulate clear high score
        #200;
        clearHighScore = 1;
        #100;
        clearHighScore = 0;

        // Simulate speed switch changes
        #200;
        speedSW = 7'b0111111;
        #100;
        speedSW = 7'b1011111;
        #100;
        speedSW = 7'b1101111;
        #100;
        speedSW = 7'b1110111;
        #100;
        speedSW = 7'b1111011;
        #100;
        speedSW = 7'b1111101;
        #100;
        speedSW = 7'b1111110;

        // Finish simulation
        #500;
        $finish;
    end

    // Monitor outputs
    initial begin
        $monitor("Time: %0t, score: %d, highScore: %d, timer: %d, hex0: %b, hex1: %b, hex2: %b, hex4: %b, hex5: %b", 
            $time, dut.score, dut.highScore, dut.timer, hex0, hex1, hex2, hex4, hex5);
    end

endmodule

