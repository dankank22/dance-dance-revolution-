# Dancing With Your Thumbs

A Verilog-based piano tiles–style rhythm game built for the DE1-SoC FPGA development board. Players tap corresponding keys as notes scroll down the screen in real time, with score and miss feedback, LED display effects, and a simple VGA visual interface.

## Project Summary

- **Platform:** DE1-SoC FPGA (Altera/Intel)
- **Language:** SystemVerilog (synthesizable)
- **Inputs:** Pushbuttons for gameplay
- **Outputs:** VGA display, 7-segment displays, LEDs
- **Main Goal:** Simulate a simplified version of "Piano Tiles" using hardware logic

## Features

- Real-time tile generation and descent using an LFSR (pseudo-random note generator)
- Scrolling visual display synced to a game clock
- Player interaction via pushbuttons to "hit" falling tiles
- Score tracking with decimal-to-binary logic
- Miss counter and end-game display logic
- Win/loss condition handling via finite state machine

## Modules Overview

- `DE1_SoC.sv` — Top-level module connecting all submodules and handling I/O
- `gamePlay.sv` — Manages game state machine and player input tracking
- `counter.sv` — Timing logic for tile descent and clock control
- `comparator.sv` — Determines whether tile and button match
- `LFSR.sv` / `LFSR_mod.sv` — Generates random tile patterns
- `LEDDriver.sv` — Controls LED display logic
- `LED_test.sv` — Standalone testbench for LED module
- `decToHex.sv` — Converts score/miss values to 7-segment hex encoding
- `clock_divider.sv` — Generates slower clock signals for game timing
- `FPGAcontrols.png` — Pin and control reference diagram
- `DANCING WITH YOUR THUMBS.pdf` — Project report with design explanation and testbench documentation


## Gameplay Rules

- Each successful hit adds to the score.
- A miss adds to the miss counter.
- 20 hits = **Win**
- 10 misses = **Lose**
- After either condition is met, a visual endgame signal is shown.
