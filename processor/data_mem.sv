// Module Name:    data_mem
// Class  Name:    CSE141L
// Design Name:    SESO
// Create Date:    2023.08.23

module data_mem(
  input              CLK,
  input [7:0]        DataAddress,
  input              MemWrEn,        // write memory enable (control by Control)
  input [7:0]        DataIn,
  output logic[7:0]  DataOut
  );

  logic [7:0] core[256];
  
  assign DataOut = core[DataAddress];   
         
  always_ff @ (posedge CLK)		 
    if(MemWrEn) 
      core[DataAddress] <= DataIn;

endmodule