`default_nettype none
module hw5prob2
(input logic b, clock, reset,
output logic found3zeros_N);
logic [2:0] state, nextState;
always_comb begin
  nextState[2] = state[1] & (~b) | 
                 state[0] & (~b) |
                 state[2] & state[0] | 
                 state[2] & (~state[1]);
   // $display("here is nextState[2]: %b\n", nextState[2]);
  nextState[1] = state[2] & (~b) | 
                 (~state[1]) & (state[0]) & (b) |
                 (~state[2]) & state[1] & (~state[0]) & b;
  nextState[0] = state[2] & (~b) |
                 state[2] & (~state[1]) & (~state[0]) |
                 state[2] & state[1] & state[0] |
                 (~state[2]) & state[1] & (~state[0]) & b |
                 (~state[1]) & (~state[0]) & (~b);
end
assign found3zeros_N = ~(state[2] & state[1] & state[0]); //not sure about this
  //asserted low
always_ff @(posedge clock, posedge reset)
  if (reset)
    state <= 3'b0;
  else
    state <= nextState;
endmodule: hw5prob2


module tb1(output logic clock, reset, b,
           input logic found3zeros_N);

  initial begin
    clock = 0;
    reset = 1;
    reset <= 0;
    forever #5 clock = ~clock;
  end


  initial
    $monitor("State = %b, in(%b), out(%b)",
                 dut.state, b, found3zeros_N);
  initial begin
    
    b <= 1;
    @(posedge clock);
    b <= 1;
    @(posedge clock);
    @(posedge clock);
    b <= 1;
    @(posedge clock);
    b <= 1;
    @(posedge clock);
    b <= 0;
    @(posedge clock);
   
    @(posedge clock);
    b <= 1;
    @(posedge clock);
    b <= 0;
    @(posedge clock);
    b <= 1;
    @(posedge clock);
    b <= 1;
    @(posedge clock);
    b <= 0;
    @(posedge clock);
    b <= 0;
    @(posedge clock);
    b <= 1;
    @(posedge clock); //$display("reset here\n");
    b <= 1;
    @(posedge clock);
    b <= 1;
    @(posedge clock);
    b <= 0;
    @(posedge clock);
 
    @(posedge clock);
    @(posedge clock);
    @(posedge clock);
    $finish;



  end
endmodule: tb1



module hw5prob2_top();
logic clock, reset, b,found3zeros_N;
hw5prob2 dut(.*);
tb1 dut2(.*);
endmodule: hw5prob2_top
