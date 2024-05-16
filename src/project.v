/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_LeakyIntegrateFireNeuron (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  wire rst = ! rst_n;

LeakyIntegrateFireNeuron u_LeakyIntegrateFireNeuron(
    .clk(clk),                          // Clock signal
    .reset(rst),                        // Asynchronous reset, active high
    .enable(ena),                      // Enable input for updating the neuron
    .input_current(ui_in[2:0]),          // Input current (I_ext)
    .threshold(uio_in),              // Firing threshold (V_thresh)
    .decay(uio_in),                 // Decay value adjusted based on membrane potential sign
    .refractory_period(uio_in),     // Refractory period in number of clock cycles, now 8 bits
    .spike_out(uo_out[2:0])                // Output spike signal, renamed from 'fired'
);

    assign uo_out[7:3]=5'b00000;
    
assign uio_oe = 8'b00000000; //used bidirectional pins as input

endmodule
