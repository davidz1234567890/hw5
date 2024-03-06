module tb2;
  logic clock, reset_L, a,f;
  myFSM22 dut(.*);
  
  initial begin
    clock = 0;
    reset_L = 0;
    reset_L <= 1;
    forever #5 clock = ~clock;
  end


  initial
    $monitor("State = %b, in(%b), out(%b)",
                 dut.state, a, f);
  initial begin
    a <= 0;
    #1 assert(dut.state == dut.nothing);
    @(posedge clock);
    a <= 1;
    #1 assert(dut.state == dut.saw0);
    @(posedge clock);
    #1 assert(dut.state == dut.saw1);
    @(posedge clock);
    a <= 0;
    #1 assert(dut.state == dut.nothing);
    @(posedge clock);
    a <= 1;
    #1 assert(dut.state == dut.saw0);
    @(posedge clock);
    a <= 0;
    #1 assert(dut.state == dut.saw1);
    @(posedge clock);
    #1 assert(dut.state == dut.saw0);
    @(posedge clock);
    a <= 1;
    #1 assert(dut.state == dut.saw0);
    @(posedge clock);
    a <= 0;
    #1 assert(dut.state == dut.saw1);
    @(posedge clock);
    a <= 1;
    #1 assert(dut.state == dut.saw0);
    @(posedge clock);
    a <= 0;
    #1 assert(dut.state == dut.saw1);
    @(posedge clock);
    a <= 1;
    #1 assert(dut.state == dut.saw0);
    @(posedge clock);
    a <= 0;
    #1 assert(dut.state == dut.saw1);
    @(posedge clock);
    #1 assert(dut.state == dut.saw0);
    reset_L = 0; $display("reset here\n");
    reset_L <= 1;
    @(posedge clock); 
    $finish;



  end
endmodule: tb2
