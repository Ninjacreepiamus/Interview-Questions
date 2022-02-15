module modal_reg(input logic Clk, input logic nRst, input logic Ser, input logic [7:0] D, input logic [2:0] mode, output logic [7:0] Q);
  logic [7:0] next_Q;

  always_ff @(posedge Clk, negedge nRst) begin
    if(~nRst)
      Q <= '0;
    else
      Q <= next_Q
  end

  always_comb begin

    case(mode)
    3'b000: next_Q = Q;

    3'b001: next_Q = {Ser, Q[7:1]}; //Right shifted with Ser as leftmost

    3'b010: next_Q = {Q[6:0], Ser}; //Left shifted with Ser as rightmost

    3'b011: next_Q = D;

    3'b101: next_Q = Q & D;
    
    3'b110: next_Q = Q | D;

    default: next_Q = Q;

    endcase
  end
endmodule