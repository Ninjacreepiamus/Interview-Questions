/*
Verilog code for sequential logic. Consider the following logic function.
Module name: prime_counter()

Inputs:
  Clk rising edge active clock
  nRst active low asynchronous reset 
  B[3:0] 4 bit unsigned binary number

Outputs:
  N[7:0] the number of prime numbers recognized since 
  last reset saturates at 255 (i.e., stops counting at 255, doesn't roll over)
  Ovf Ovf = 1 when number of primes exceeds 255
*/

module prime_counter(
  input logic Clk,
  input logic nRst,
  input logic [3:0] B,
  output logic [7:0] N,
  output logic Ovf
);
  logic [7:0] next_N;
  logic next_Ovf;

  always_ff @(posedge Clk, negedge nRst) begin : flip_flops
    if(~nRst) begin
      N <= '0;
      Ovf <= 1'b0;
    end
    else begin
      next_N <= N;
      next_Ovf <= Ovf;
    end
  end

  always_comb begin : prime_states
    next_Ovf = 1'b0;
    next_N = N;

    if (Ovf == 1) begin // Stop the count
      next_N = N;
      next_Ovf = 1'b1;
    end

    else begin
      if (N == 8'd255)
        next_Ovf = 1'b1;

      else begin
        next_Ovf = 1'b0;
        if((B == 4'd2) || (B == 4'd3) || (B == 4'd5)
        || (B == 4'd7) || (B == 4'd11) || (B == 4'd13))
          next_N = N + 1;
        else
          next_N = N;
      end
    end
  end

endmodule