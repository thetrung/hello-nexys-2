`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/02/2024 12:47:56 AM
// Design Name: 
// Module Name: pwm
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module pwm(
    input wire logic clk,
    input wire logic [7:0] duty, // 8-bit value [0-255]
    output     logic pwm_out
    );

    logic [7:0] cnt = 8'b0;
    
    always_ff @(posedge clk) begin
        cnt <= cnt + 1;
    end

    always_comb pwm_out = (cnt < duty);
    
endmodule
