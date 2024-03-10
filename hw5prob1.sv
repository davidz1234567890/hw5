`default_nettype none
module hw5prob1
(input logic a, clock, reset_L,
output logic found_it);
enum logic [2:0] {nothing = 3'b001, saw1 = 3'b010, 
                    saw0 = 3'b100} state, nextState;
always_comb begin
  unique case (state)
    nothing: nextState = (a ==1) ? saw1 : nothing;
    saw1: nextState = (a ==1) ? saw1 : saw0;
    saw0: nextState = (a ==1) ? saw1 : nothing;
  endcase
end
always_comb begin
  unique case (state)
    nothing: found_it = 0;
    saw1: found_it = 0;
    saw0: found_it = (a==1) ? 1 : 0;
  endcase
end
always_ff @(posedge clock, negedge reset_L)
  if (~reset_L)
    state <= nothing;
  else
    state <= nextState;
endmodule: hw5prob1


module tb2(output logic clock, reset_L, a,
           input logic found_it);
  initial begin
    clock = 0;
    reset_L = 0;
    reset_L <= 1;
    forever #5 clock = ~clock;
  end


  initial
    $monitor("State = %s, in(%b), out(%b)",
                 dut.state.name, a, found_it);
  initial begin
    a <= 0;
    @(posedge clock);
    a <= 1;
    @(posedge clock);
    @(posedge clock);
    a <= 0;
    @(posedge clock);
    a <= 1;
    @(posedge clock);
    a <= 0;
    @(posedge clock);
  
    @(posedge clock);
    a <= 1;
    @(posedge clock);
    a <= 0;
    @(posedge clock);
    a <= 1;
    @(posedge clock);
    a <= 0;
    @(posedge clock);
    a <= 1;
    @(posedge clock);
    a <= 0;
    @(posedge clock);
    a <= 0;
    @(posedge clock);
    a <= 0;
    @(posedge clock);
    a <= 1;
    @(posedge clock);
    a <= 0;
    @(posedge clock);
    a <= 1;
    @(posedge clock);
    a <= 1;
    @(posedge clock);
    a <= 1;
    @(posedge clock);
    a <= 1;
    @(posedge clock);
    a <= 0;
    @(posedge clock);
    a <= 1;
    @(posedge clock);
    a <= 0;
    @(posedge clock);
    a <= 1;
    @(posedge clock);
    $finish;



  end
endmodule: tb2

module hw4prob5();
logic clock, reset_L, a,found_it;
hw5prob1 dut(.*);
tb2 dut2(.*);

endmodule: hw4prob5
