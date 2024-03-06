`default_nettype none
module fsm1
(input logic clock, reset_L, a,
 output logic f);
logic [1:0] state, nextState;
always_comb begin
  nextState[1] = state[0] & a | state[1] & (~state[0]) & (~a);
  nextState[0] = ~a;
end
assign f = state[1] & state[0];
always_ff @(posedge clock, negedge reset_L)
  if (~reset_L)
    state <= 2'b0;
  else
    state <= nextState;
endmodule: fsm1



module fsm11
(input logic clock, reset_L, a,
 output logic f);
 enum logic [1:0] {nothing = 2'b00, saw0 = 2'b01, saw1 = 2'b10, 
                   ssaw0 = 2'b11} state, nextstate;

always_comb begin
  case(state)
    nothing: begin
      if (a == 0)
        nextstate = saw0;
      else
        nextstate = nothing;
    end
    saw0: begin
      if (a == 0)
        nextstate = saw0;
      else
        nextstate = saw1;
    end
    saw1: begin
      if (a == 0)
        nextstate = ssaw0;
      else
        nextstate = nothing;
    end
    ssaw0: begin
      if (a == 0)
        nextstate = saw0;
      else
        nextstate = saw1;
    end
  endcase
end

always_comb begin
  case(state)
    nothing: f = 0;
    saw0: f = 0;
    saw1: f = 0;
    ssaw0: f = 1;
  endcase
end

always_ff @(posedge clock,negedge reset_L)
  if (~reset_L)
    state <= nothing;
  else
    state <= nextstate;
endmodule: fsm11
