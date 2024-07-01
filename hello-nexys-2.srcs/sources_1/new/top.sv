`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: None
// Engineer: thetrung
// 
// Create Date: 07/01/2024 11:41:26 PM
// Design Name: hello-nexys-2
// Module Name: top
// Project Name: hello-nexys-2
// Target Devices: nexys-video
// Tool Versions: Vivado_2024.1
// Description: 
// 
// Dependencies: none
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top(
    input wire logic clk,
    input wire logic [2:0] sw,
    output     logic [7:0] led
    );
    logic dis;
    logic [7:0] counter;
    
    // using PWM module to change led brightness :
    pwm pwm_led_0 (.clk, .duty(dis ? 2 : (counter[0] ? 255 : 0)),   .pwm_out(led[0]));
    pwm pwm_led_1 (.clk, .duty(dis ? 4 : (counter[1] ? 255 : 0)),   .pwm_out(led[1]));
    pwm pwm_led_2 (.clk, .duty(dis ? 8 : (counter[2] ? 255 : 0)),   .pwm_out(led[2]));
    pwm pwm_led_3 (.clk, .duty(dis ? 16 : (counter[3] ? 255 : 0)),  .pwm_out(led[3]));
    pwm pwm_led_4 (.clk, .duty(dis ? 32 : (counter[4] ? 255 : 0)),  .pwm_out(led[4]));
    pwm pwm_led_5 (.clk, .duty(dis ? 64 : (counter[5] ? 255 : 0)),  .pwm_out(led[5]));
    pwm pwm_led_6 (.clk, .duty(dis ? 128 : (counter[6] ? 255 : 0)), .pwm_out(led[6]));
    pwm pwm_led_7 (.clk, .duty(dis ? 255 : (counter[7] ? 255 : 0)), .pwm_out(led[7]));
    
    // Define a constant param :
    localparam DIV_BY = 32'd100_000_000;   // 100 million

    // Define normal params :
    logic stb;            // a strobe
    logic [31:0] cnt = 0; // 32-bit counter

    // Loop per rising edge :
    always_ff @(posedge clk) begin
    
        // Clear mode :
        if (sw[1]) begin
            // clear values
            stb <= 0;
            cnt <= 0;
            dis <= 1;
            counter <= 0;
        end 
          
        // Active counter :
        if (sw[0]) begin
            // enable :
            dis <= 0;
            // count everytime it's 32
            if(cnt != DIV_BY-1) begin
                stb <= 0;
                cnt <= cnt + 1;
            end else begin 
                stb <= 1;
                cnt <= 0;
            end
            // count >> led 
            if (stb) begin 
                counter <= counter + 1;
            end
        end 
    end

endmodule
