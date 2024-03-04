`timescale 1ns / 1ps

`define B15to0H 10'b1000000000
`define AandBH  10'b0100000000
`define AorBH   10'b0010000000
`define notBH   10'b0001000000
`define shlBH   10'b0000100000
`define shrBH   10'b0000010000
`define AaddBH  10'b0000001000
`define AsubBH  10'b0000000100
`define AmulBH  10'b0000000010
`define AcmpBH  10'b0000000001

module tb_ArithmeticUnit();

reg [15:0] A, B;
reg [9:0] instruction;
reg cin;

wire zout, cout;
wire [15:0] aluout;

// ##########   instantiate module  #############
ArithmeticUnit ArithmeticUnit0 (
  .A      (A),    
  .B      (B),
  .cin    (cin),

  .B15to0 (instruction[9]), 
  .AandB  (instruction[8]),
  .AorB   (instruction[7]),
  .notB   (instruction[6]),
  .shlB   (instruction[5]),
  .shrB   (instruction[4]),
  .AaddB  (instruction[3]),
  .AsubB  (instruction[2]),
  .AmulB  (instruction[1]),
  .AcmpB  (instruction[0]),

  .aluout (aluout),
  .zout   (zout),
  .cout   (cout)
);
// ########################################

integer B15to0H_case, AandBH_case, AorBH_case, notBH_case, shlBH_case, shrBH_case, AaddBH_case, AsubBH_case, AmulBH_case, AcmpBH_case; 
integer B15to0H_execute, AandBH_execute, AorBH_execute, notBH_execute, shlBH_execute, shrBH_execute, AaddBH_execute, AsubBH_execute, AmulBH_execute, AcmpBH_execute;
integer B15to0H_pass, AandBH_pass, AorBH_pass, notBH_pass, shlBH_pass, shrBH_pass, AaddBH_pass, AsubBH_pass, AmulBH_pass, AcmpBH_pass;
integer B15to0H_false, AandBH_false, AorBH_false, notBH_false, shlBH_false, shrBH_false, AaddBH_false, AsubBH_false, AmulBH_false, AcmpBH_false;

integer random_num;
logic scoreboard;

initial begin
//############    initial value   ###################
  {B15to0H_case, AandBH_case, AorBH_case, notBH_case, shlBH_case, shrBH_case, AaddBH_case, AsubBH_case, AmulBH_case, AcmpBH_case} = 10'b0;
  {B15to0H_execute, AandBH_execute, AorBH_execute, notBH_execute, shlBH_execute, shrBH_execute, AaddBH_execute, AsubBH_execute, AmulBH_execute, AcmpBH_execute} = 10'b0;
  {B15to0H_pass, AandBH_pass, AorBH_pass, notBH_pass, shlBH_pass, shrBH_pass, AaddBH_pass, AsubBH_pass, AmulBH_pass, AcmpBH_pass} = 10'b0;
  {B15to0H_false, AandBH_false, AorBH_false, notBH_false, shlBH_false, shrBH_false, AaddBH_false, AsubBH_false, AmulBH_false, AcmpBH_false} = 10'b0;
  
  random_num = 20;

// ##########   random verification   #########
  #1;
  {B15to0H_case,AandBH_case,AorBH_case,notBH_case,shlBH_case,shrBH_case,AaddBH_case,AsubBH_case,AmulBH_case,AcmpBH_case} += {10{random_num}};
  for (int i = 0; i < 10; i++) begin
    instruction = 10'b00_0000_0000;
    instruction[i] = 1'b1;
  
    repeat(random_num) begin 
      A = $random(); 
      B = $random(); 
      cin = $random(); 
      #5; 
    end
  end

// ##########   directed special case verification    #########
  {B15to0H_case,AandBH_case,AorBH_case,notBH_case,shlBH_case,shrBH_case,AcmpBH_case} += {7{32'd10}};
  {AaddBH_case,AsubBH_case,AmulBH_case} += {3{32'd20}};

  repeat(10)begin //zout = 1'b1 case
    instruction = `B15to0H;   A = $random();    B = 16'h0000;   cin = $random();    #5;
    instruction = `AandBH;
    A = $random();
    for(int i = 0; i < 16; i++) begin
      if(A[i] == 1'b1) begin
        B[i] = 1'b0;
      end else begin
        B[i] = $random();
      end
    end
    cin = $random();    #5;
    instruction = `AorBH;     A = 16'h0000;     B = 16'h0000;   cin = $random();    #5;
    instruction = `notBH;     A = $random();    B = 16'hffff;   cin = $random();    #5;
    instruction = `shlBH;     A = $random();    B = 16'h0000;   cin = $random();    #5;
    instruction = `shrBH;     A = $random();    B = 16'h0000;   cin = $random();    #5;
    instruction = `AaddBH;
    A = $random();    B = 16'h0000 - A;     cin = 1'b0;       #5;
    A = $random();    B = 16'h0000 - A - 1; cin = 1'b1;       #5;
    instruction = `AsubBH;
    A = $random();    B = A;          cin = 1'b0;         #5;
    A = $random();    B = A + 1;      cin = 1'b1;         #5;
    instruction = `AmulBH;
    A = $random();    B = 16'h0000;   cin = $random();    #5;
    A = 16'h0000;     B = $random();  cin = $random();    #5;
    instruction = `AcmpBH;
    A = $random();    B = A;          cin = $random();    #5;
  end
//#########     scoreboard     ##############
  $display("scoreboard\n");

  $display("B15to0H_case = %d", B15to0H_case);
  $display("B15to0H_execute = %d\tpass = %d\tfalse = %d\n", B15to0H_execute, B15to0H_pass, B15to0H_false);

  $display("AandBH_case = %d", AandBH_case);
  $display("AandBH_execute = %d\tpass = %d\tfalse = %d\n", AandBH_execute, AandBH_pass, AandBH_false);

  $display("AorBH_case = %d", AorBH_case);
  $display("AorBH_execute = %d\tpass = %d\tfalse = %d\n", AorBH_execute,  AorBH_pass,  AorBH_false);

  $display("notBH_case = %d", notBH_case);
  $display("notBH_execute = %d\tpass = %d\tfalse = %d\n", notBH_execute, notBH_pass, notBH_false);

  $display("shlBH_case = %d", shlBH_case);
  $display("shlBH_execute = %d\tpass = %d\tfalse = %d\n", shlBH_execute, shlBH_pass, shlBH_false);

  $display("shrBH_case = %d", shrBH_case);
  $display("shrBH_execute = %d\tpass = %d\tfalse = %d\n", shrBH_execute, shrBH_pass, shrBH_false);

  $display("AaddBH_case = %d", AaddBH_case);
  $display("AaddBH_execute = %d\tpass = %d\tfalse = %d\n", AaddBH_execute, AaddBH_pass, AaddBH_false);

  $display("AsubBH_case = %d", AsubBH_case);
  $display("AsubBH_execute = %d\tpass = %d\tfalse = %d\n", AsubBH_execute, AsubBH_pass, AmulBH_false);

  $display("AmulBH_case = %d", AmulBH_case);
  $display("AmulBH_execute = %d\tpass = %d\tfalse = %d\n", AmulBH_execute, AmulBH_pass, AmulBH_false);

  $display("AcmpBH_case = %d", AcmpBH_case);
  $display("AcmpBH_execute = %d\tpass = %d\tfalse = %d\n", AcmpBH_execute, AcmpBH_pass, AcmpBH_false);

  $display("total_case = %d\ntotal_execute = %d\ntotal_pass = %d\ntotal_false = %d",
    B15to0H_case+ AandBH_case+ AorBH_case+ notBH_case+ shlBH_case+ shrBH_case+ AaddBH_case+ AsubBH_case+ AmulBH_case+ AcmpBH_case,
    B15to0H_execute+ AandBH_execute+ AorBH_execute+ notBH_execute+ shlBH_execute+ shrBH_execute+ AaddBH_execute+ AsubBH_execute+ AmulBH_execute+ AcmpBH_execute,
    B15to0H_pass+ AandBH_pass+ AorBH_pass+ notBH_pass+ shlBH_pass+ shrBH_pass+ AaddBH_pass+ AsubBH_pass+ AmulBH_pass+ AcmpBH_pass,
    B15to0H_false+ AandBH_false+ AorBH_false+ notBH_false+ shlBH_false+ shrBH_false+ AaddBH_false+ AsubBH_false+ AmulBH_false+ AcmpBH_false);
end
// ############################################

//#############   checker   ################
always @(A or B or cin or instruction or aluout or zout or cout) begin // zout
  #1;
  if(instruction == 10'b00_0000_0001) begin
    if(A == B) begin
      if(zout == 1'b1) begin
      end else begin
        $display("zout flag didnt active");
        $display("instruction = %b\tA = %h\tB = %h\tcin = %h\naluout = %h\tzout = %b\tcout = %b\n", instruction, A, B, cin, aluout, zout, cout);
      end
    end else begin
      if(zout == 1'b1) begin
        $display("zout flag was actived accidentally ");
        $display("instruction = %b\tA = %h\tB = %h\tcin = %h\naluout = %h\tzout = %b\tcout = %b\n", instruction, A, B, cin, aluout, zout, cout);
      end else begin
      end
    end
  end else begin
    if(aluout == 16'h0000) begin
      if(zout == 1'b1) begin
      end else begin
        $display("zout flag didnt active");
        $display("instruction = %b\tA = %h\tB = %h\tcin = %h\naluout = %h\tzout = %b\tcout = %b\n", instruction, A, B, cin, aluout, zout, cout);
      end
    end else begin
      if(zout == 1'b1) begin
        $display("zout flag was actived accidentally ");
        $display("instruction = %b\tA = %h\tB = %h\tcin = %h\naluout = %h\tzout = %b\tcout = %b\n", instruction, A, B, cin, aluout, zout, cout);
      end else begin
      end
    end
  end
end

always @(A or B or cin or instruction or aluout or zout or cout) begin // alu vs cout
  case (instruction) 
    `B15to0H: begin
                #1;
                B15to0H_execute = B15to0H_execute + 1;
                if(aluout == B) begin
                  B15to0H_pass = B15to0H_pass + 1;
                end else begin
                  $display("---------false_B15to0H--------");
                  $display("A = %h\tB = %h\tcin = %h\naluout = %h\tzout = %b\tcout = %b\n", A, B, cin, aluout, zout, cout);
                  B15to0H_false = B15to0H_false + 1;
end
              end
    `AandBH:  begin
                #1;
                AandBH_execute = AandBH_execute + 1;
                if(aluout == (A & B)) begin
                  AandBH_pass = AandBH_pass + 1;
                end else begin
                  $display("---------false_AandBH--------");
                  $display("A = %h\tB = %h\tcin = %h\naluout = %h\tzout = %b\tcout = %b\n", A, B, cin, aluout, zout, cout);
                  AandBH_false = AandBH_false + 1;
                end
              end
    `AorBH:   begin
                #1;
                AorBH_execute = AorBH_execute + 1;
                if(aluout == (A | B)) begin
                  AorBH_pass = AorBH_pass + 1;
                end else begin
                  $display("---------false_AorBH--------");
                  $display("A = %h\tB = %h\tcin = %h\naluout = %h\tzout = %b\tcout = %b\n", A, B, cin, aluout, zout, cout);
                  AorBH_false = AorBH_false + 1;
                end
              end
    `notBH:   begin
                #1;
                notBH_execute = notBH_execute + 1;
                if(aluout == ~B) begin
                  notBH_pass = notBH_pass + 1;
                end else begin
                  $display("---------false_notBH--------");
                  $display("A = %h\tB = %h\tcin = %h\naluout = %h\tzout = %b\tcout = %b\n", A, B, cin, aluout, zout, cout);
                  notBH_false = notBH_false + 1;
                end
              end
    `shlBH:   begin
                #1;
                shlBH_execute = shlBH_execute + 1;
                if(aluout == {B[14:0], B[0]}) begin
                  shlBH_pass = shlBH_pass + 1;
                end else begin
                  $display("---------false_shlBH--------");
                  $display("A = %h\tB = %h\tcin = %h\naluout = %h\tzout = %b\tcout = %b\n", A, B, cin, aluout, zout, cout);
                  shlBH_false = shlBH_false + 1;
                end
              end
    `shrBH:   begin   
                #1;
                shrBH_execute = shrBH_execute + 1;
                if(aluout == {B[15], B[15:1]}) begin
                  shrBH_pass = shrBH_pass + 1;
                end else begin
                  $display("---------false_shrBH--------");
                  $display("A = %h\tB = %h\tcin = %h\naluout = %h\tzout = %b\tcout = %b\n", A, B, cin, aluout, zout, cout);
                  shrBH_false = shrBH_false + 1;
                end
              end
    `AaddBH:  begin  
                #1;
                AaddBH_execute = AaddBH_execute + 1;
                if({cout, aluout} == A + B + cin) begin
                  AaddBH_pass = AaddBH_pass + 1;
                end else begin
                  $display("---------false_AaddBH:--------");
                  $display("A = %h\tB = %h\tcin = %h\tA + B = %h\naluout = %h\tzout = %b\tcout = %b\n", A, B, cin, A+B, aluout, zout, cout);
                  AaddBH_false = AaddBH_false + 1;
                end
              end
    `AsubBH:  begin
                #1;
                AsubBH_execute = AsubBH_execute + 1;
                if({cout, aluout} == A - B - cin) begin
                  AsubBH_pass = AsubBH_pass + 1;
                end else begin
                  $display("---------false_AsubBH--------");
                  $display("A = %h\tB = %h\tcin = %h\tA - B = %h\naluout = %h\tzout = %b\tcout = %b\n", A, B, cin, A-B, aluout, zout, cout);
                  AsubBH_false = AsubBH_false + 1;
                end
              end
    `AmulBH:  begin 
                #1;
                AmulBH_execute = AmulBH_execute + 1;
                if({cout, aluout} == A[7:0] * B[7:0]) begin
                  AmulBH_pass = AmulBH_pass + 1;
                end else begin
                  $display("---------false_AmulB--------");
                  $display("A = %h\tB = %h\tcin = %h\tA - B = %h\naluout = %h\tzout = %b\tcout = %b\n", A, B, cin, A-B, aluout, zout, cout);
                  AmulBH_false = AmulBH_false + 1;
                end
              end
    `AcmpBH:  begin
                #1;
                AcmpBH_execute = AcmpBH_execute + 1;
                if(A > B) begin
                  if(cout == 1'b1 && zout == 1'b0) begin
                    AcmpBH_pass = AcmpBH_pass + 1;
                  end else begin
                    $display("---------false_AcmpB--------");
                    $display("A = %h\tB = %h\tcin = %h\tA - B = %h\naluout = %h\tzout = %b\tcout = %b\n", A, B, cin, A-B, aluout, zout, cout);
                  end
                end else if(A == B) begin
                  if(cout == 1'b0 && zout == 1'b1) begin
                    AcmpBH_pass = AcmpBH_pass + 1;
                  end else begin
                    $display("---------false_AcmpB--------");
                    $display("A = %h\tB = %h\tcin = %h\tA - B = %h\naluout = %h\tzout = %b\tcout = %b\n", A, B, cin, A-B, aluout, zout, cout);
                  end
                end else begin
                  if(cout == 1'b0 && zout == 1'b0) begin
                    AcmpBH_pass = AcmpBH_pass + 1;
                  end else begin
                    $display("---------false_AcmpB--------");
                    $display("A = %h\tB = %h\tcin = %h\tA - B = %h\naluout = %h\tzout = %b\tcout = %b\n", A, B, cin, A-B, aluout, zout, cout);
                  end
                end
              end
    default:  begin
                if(aluout == 16'h0000) begin
                  $display("default instruction pass");
                end else begin
                  $display("default instruction false");
                end
              end
  endcase
end
// #########################################################
endmodule
