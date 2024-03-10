module hw5prob4();
logic a, f,clock, reset_L;
fsm11 dut (.*);

  initial begin
    clock = 0;
    reset_L = 0;
    reset_L <=  1;
    forever #5 clock = ~clock;
  end


  initial
    $monitor($time,,"Current State = %s, Next State = %s, in(%b), out(%b)",
                 dut.state.name, dut.nextstate.name, a, f);
  initial begin
    
    a <= 0; 
    #1 assert(dut.state == dut.nothing);
        
    @(posedge clock);
   
    a <= 1; 
    #1 assert(dut.state == dut.saw0);
        
    @(posedge clock);
    
    a <= 1; 
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

    a <= 0; 
    #1 assert(dut.state == dut.ssaw0);
    
    @(posedge clock);
    
    a <= 1; 
    #1 assert(dut.state == dut.saw0);
    
    @(posedge clock);
    
    a <= 0; 
    #1 assert(dut.state == dut.saw1);
        
    @(posedge clock);
    
    a <= 1;
    #1 assert(dut.state == dut.ssaw0);
     
    @(posedge clock);
    
    a <= 0; 
    #1 assert(dut.state == dut.saw1);
    
    @(posedge clock);

    a <= 1;
    #1 assert(dut.state == dut.ssaw0);
     
    @(posedge clock);
    
    a <= 0;
    #1 assert(dut.state == dut.saw1);
    
    @(posedge clock); 

    #1 assert(dut.state == dut.ssaw0); //prints ssaw0
    reset_L = 0; $display("reset here"); #1 assert(dut.state == dut.nothing);
    reset_L <= 1; //a is still 0 here

    @(posedge clock); 

    #1 assert(dut.state == dut.saw0);
    //a is still 0 here

    @(posedge clock);

    reset_L = 0;  $display("reset here");
    reset_L <= 1;

    @(posedge clock); 
    @(posedge clock);
    $finish;



  end



endmodule: hw5prob4
