// Module Name:   Ctrl
// Class  Name:   CSE141L
// Design Name:   SESO
// Create Date:   2023.08.23
// control decoder (combinational, not clocked)
// inputs from instrROM, ALU flags
// outputs to program_counter (fetch unit)
import definitions::*;

module Ctrl (
  input  [8:0]   Instruction,	   // machine code
  input  logic   to_jump,
  output logic   Branch,
	         RegWrEn,	   // write to reg_file (common)
                 AccWrEn,			
		 MemWrEn,	   // write to mem (store only)
                 LoadInst,
		 halt
  );

/* ***** All numerical values are completely arbitrary and for illustration only *****/

// alternative -- case format
always_comb begin
    // list the defaults here
    Branch    = 'b0;
    RegWrEn   = 'b1; 
    AccWrEn   = 'b0;
    MemWrEn   = 'b0;
    LoadInst  = 'b0;
    halt      = 'b0;

    if (Instruction[8] == 'b0) begin
            RegWrEn    = 'b0;    // imm
            AccWrEn    = 'b1;    // imm
    end
    else begin
      case(Instruction[7:4])  
       
        4'b0000:   begin
                AccWrEn = 'b1;   // lsl
                RegWrEn = 'b0;   // lsl
        end
        4'b0001:   begin
                AccWrEn = 'b1;   // lsr
                RegWrEn = 'b0;   // lsr
        end
        4'b0010:   begin
                AccWrEn = 'b1;   // add
                RegWrEn = 'b0;   // add
        end
        4'b0011:   begin
                AccWrEn = 'b1;   // and
                RegWrEn = 'b0;   // and
        end
        4'b0100:   begin
                AccWrEn = 'b1;   // orr
                RegWrEn = 'b0;   // orr
        end
        4'b0101:   begin
                AccWrEn = 'b1;   // eor
                RegWrEn = 'b0;   // eor
        end
        4'b0110:   begin
                AccWrEn = 'b1;   // take
                RegWrEn = 'b0;   // take
        end
        4'b0111:   begin end     // mov
        4'b1000:   begin  
                RegWrEn = 'b0;   // ldr
                AccWrEn = 'b1;   // ldr
                LoadInst= 'b1;   // ldr
        end
        4'b1001:   begin
                MemWrEn = 'b1;   // str
                RegWrEn = 'b0;   // str
        end
        4'b1010:   begin
                AccWrEn = 'b1;   // cmp
                RegWrEn = 'b0;   // cmp
        end
        4'b1011:   begin
                RegWrEn = 'b0;   // b
                Branch  = 'b1;   // b
        end
        4'b1100:   begin
                RegWrEn = 'b0;           // beq
                if (to_jump)
                        Branch  = 'b1;   // beq
                else
                        Branch  = 'b0;   // beq not satisfied
        end
        4'b1101:   begin
                RegWrEn = 'b0;           // bne
                if (!to_jump)
                        Branch  = 'b1;   // bne
                else
                        Branch  = 'b0;   // bne not satisfied
        end
	4'b1110:   begin
                halt  = 'b1;     // halt
        end
     
      // no default case needed -- covered before "case"
      endcase
    end
  end 
endmodule