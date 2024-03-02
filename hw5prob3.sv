module hw5prob3
(input logic A, B, clock, reset_N,
output logic F);
logic [3:0] state, nextState;
always_comb begin
  nextState[3] = state[2] & state[1] & state[0] & B;
  nextState[2] = state[2] & (~state[1]) & state[0] |
                 state[2] & state[0] & (~B) |
                 state[2] & state[1] & (~state[0]) |
                 (~state[1]) & (~state[0]) & (~A) & B |
                 (~state[2]) & state[1] & state[0] & A;
   // $display("here is nextState[2]: %b\n", nextState[2]);
  nextState[1] = (~state[1]) & (~state[0]) & B | 
                 (~state[2]) & (~state[1]) & (A) |
                 (~state[2]) & (~state[0]) & (A) |
                 (~state[1]) & (~state[0]) & (A) |
                 (state[2]) & (~state[1]) & (B) |
                 (state[2]) &  (~state[0]) & B;
  nextState[0] = state[1] & (~state[0]) |
                 (~state[2]) & (state[0]) & ~A |
                 (state[2]) & (state[0]) & (~B);
end
assign F = (~state[2] & state[1] & state[0] & A) | 
            state[2] & state[1] & state[0] & B; //not sure about this
always_ff @(posedge clock, negedge reset_N)
  if (~reset_N)
    state <= 4'b0;
  else
    state <= nextState;



endmodule: hw5prob3






module tb1(output logic A, B, clock, reset_N,
           input logic F);

  initial begin
    clock = 0;
    reset_N = 0;
    reset_N <= 1;
    forever #5 clock = ~clock;
  end


  initial
    $monitor("State = %b, A(%B), B(%b), out(%b)",
                 dut.state, A, B, F);
  initial begin
    
    A <= 0; B <= 0;
    @(posedge clock);
    
    @(posedge clock);
    A <= 1; B <= 1;
    @(posedge clock);
    A <= 0; B <= 1;
    @(posedge clock);
    A <= 1; B <= 1;
    @(posedge clock);
    
    @(posedge clock);
    A <= 1; B <= 0;
    @(posedge clock);
    A <= 0; B <= 1;
    @(posedge clock);
    A <= 1; B <= 1;
    @(posedge clock);
    
    @(posedge clock);
    A <= 0; B <= 1;
    @(posedge clock);
    
    @(posedge clock);
    
    @(posedge clock);
    A <= 0; B <= 0;
    @(posedge clock); 
    $finish;



  end
endmodule: tb1



module hw5prob2_top();
logic clock, reset_N, A, B,F;
hw5prob3 dut(.*);
tb1 dut2(.*);
endmodule: hw5prob2_top








