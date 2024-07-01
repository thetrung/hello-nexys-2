## Hello Nexys Video #2
Everything is the same to ProjectF as usual, except that I use all leds & combined 2-parts of the tutorials.
#### 1. Verilog Code :
- I let the PWM module control leds instead of **directly** setting their states :

      pwm pwm_led_0 (.clk, .duty(dis ? 2 : (counter[0] ? 255 : 0)),   .pwm_out(led[0]));

- I manipulate them by `dis` and `counter` to control the led-duty.
- I use `counter` to store `led` old calculation :`logic [7:0] counter;`
      
