// Module Name:    PC
// Class  Name:    CSE141L
// Design Name:    SESO
// Create Date:    2023.08.20
// program counter
// accepts branch and jump instructions
// default = increment by 1

module PC(
  input  init,
	 branch_en,	
	 CLK,
  input  [9:0] target,	     // how far or where to jump
  output logic[9:0] PC
  );

always @(posedge CLK)
  if(init) begin
    PC <= 0;
  end
  else begin
    if(branch_en) 
	  PC <= PC + target;
    else 
	  PC <= PC + 1;	     // default == increment by 1
  end
endmodule