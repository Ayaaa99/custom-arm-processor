// Module Name:    TopLevel
// Class  Name:    CSE141L
// Design Name:    SESO
// Create Date:    2023.08.20

module TopLevel(		   // you will have the same 3 ports
    input     start,	           // init/reset, active high
    input     CLK,		   // clock -- posedge used inside design
    output    halt		   // done flag from DUT
    );

wire [ 9:0] PC,
            branch_value;  // program count
wire [ 8:0] Instruction;   // our 9-bit opcode
wire [ 7:0] Read_reg,      // reg_file outputs
            Read_acc;      // reg_file outputs
wire [ 7:0] In_acc, In_reg,// ALU operand inputs
            ALU_out;       // ALU result
wire [ 7:0] regWriteValue, // data in to reg file
	    Mem_Out;	   // data out from data_memory    
wire	    MEM_WRITE,	   // data_memory write enable
	    reg_wr_en,	   // reg_file write enable
	    acc_wr_en,     // acc_file write enable
            LoadInst,
            branch_en,	   // to program counter: branch enable
	    to_jump;	   // to control: jump

logic[15:0] cycle_ct;	   // standalone; NOT PC!

  // Fetch = Program Counter + Instruction ROM
  // Program Counter

  PC PC1 (
	.init       (start),
	.branch_en  (branch_en),        // branch enable when branch_en = 'b1
	.CLK        (CLK),              // (CLK) is required in Verilog, optional in SystemVerilog
	.target	    (branch_value),     // branch distance
	.PC         (PC)                // program count = index to instruction memory
	);	

   LUT LUT1 (
	.addr(Instruction[3:0]),
        .Target(branch_value)
    );

  // instruction ROM
  InstROM instr_ROM1(
	.InstAddress   (PC), 
	.InstOut       (Instruction)
	);			  

  // Control decoder
  Ctrl Ctrl1 (
	.Instruction    (Instruction),        // from instr_ROM
	.to_jump	(to_jump),	
	.Branch		(branch_en),          // to PC
	.RegWrEn        (reg_wr_en),          // to reg
	.AccWrEn	(acc_wr_en),	      // to reg
	.MemWrEn	(MEM_WRITE),	      // to data_memory
        .LoadInst       (LoadInst),           // selects memory/ALU output as data input to reg_file
        .halt    
  );


  assign regWriteValue = LoadInst? Mem_Out : ALU_out;  // 2:1 switch into reg_file

  // reg_file
  reg_file #(.W(8),.D(4)) reg_file1 (
	.CLK,
	.reg_write_en (reg_wr_en), 
	.acc_write_en (acc_wr_en),
	.raddr_reg    (Instruction[3:0]),  
	.data_in      (regWriteValue), 
	.data_out_acc (Read_acc), 
	.data_out_reg (Read_reg)
  );

  assign In_acc = Read_acc;		                // connect RF out to ALU in
  assign In_reg = Read_reg;

  ALU ALU1  (
	.CLK(CLK),
	.reset(start),
	.Instruction  (Instruction),                    // from instr_ROM
	.INPUT_ACC    (In_acc),
	.INPUT_REG    (In_reg),
	.OP           (Instruction[7:4]),
	.OUT          (ALU_out),
	.to_jump      (to_jump)
  );
  

  data_mem dm1(
	.DataAddress  (ALU_out),                        // address of ALU out
	.MemWrEn      (MEM_WRITE),
        .DataIn       (Read_acc), 
	.DataOut      (Mem_Out), 
	.CLK
  );
	
// count number of instructions executed
always_ff @(posedge CLK)
  if (start == 1)	   // if(start)
  	cycle_ct <= 0;
  else if(halt == 0)       // if(!halt)
  	cycle_ct <= cycle_ct+16'b1;

endmodule
