// Module Name:    inst_rom2
// Class  Name:    CSE141L
// Design Name:    SESO
// Create Date:    2023.08.20
// CSE141L  -- instruction ROM -- one approach
// no external file needed, but lots of 
// DW = machine code width (9 bits for class; 32 for ARM/MIPS)
// IW = program counter width, determines instruction memory depth

module InstROM #(parameter IW = 10, DW = 9)(
  input        [IW-1:0] InstAddress,	    // address pointer
  output logic [DW-1:0] InstOut
  );

  logic [DW-1:0] inst_rom [2**IW];	    
  assign InstOut = inst_rom[InstAddress];
  
//  initial begin		                    // load from external text file
//  	$readmemb("machine_code_1.txt",inst_rom);
//  end 

endmodule