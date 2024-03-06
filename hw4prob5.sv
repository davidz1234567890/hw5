`default_nettype none
module myFSM2
(input logic clock, reset_L, a,
 output logic f);
logic [1:0] state, nextState;
always_comb begin
  nextState[1] = state[0] & a;
  nextState[0] = ~a;
end
assign f = state[1] & (~a);
always_ff @(posedge clock, negedge reset_L)
  if (~reset_L)
    state <= 2'b0;
  else
    state <= nextState;
endmodule: myFSM2


module myFSM22
(input logic clock, reset_L, a,
 output logic f);
enum logic [1:0] {nothing = 2'b00, saw0 = 2'b01, saw1 = 2'b10} 
                 state, nextstate;
always_comb begin
  case (state)
    nothing: begin
      if(a == 0)
        nextstate = saw0;
      else
        nextstate = nothing;
    end
    saw0: begin
      if(a == 0)
        nextstate = saw0;
      else
        nextstate = saw1;
    end
    saw1: begin
      if(a == 0)
        nextstate = saw0;
      else
        nextstate = nothing;
    end

  endcase
end

always_comb begin
  case (state)
    nothing: begin
      if(a == 0)
        f = 0;
      else
        f = 0;
    end
    saw0: begin
      if(a == 0)
        f = 0;
      else
        f = 0;
    end
    saw1: begin
      if(a == 0)
        f = 1;
      else
        f = 0;
    end

  endcase
end




always_ff @(posedge clock, negedge reset_L)
  if (~reset_L)
    state <= nothing;
  else
    state <= nextstate;
endmodule: myFSM22
