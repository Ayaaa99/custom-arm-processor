// Module Name:    reg_file 
// Class  Name:    CSE141L
// Design Name:    SESO
// Create Date:    2023.08.20
// Additional Comments: 					  $clog2

module reg_file #(parameter W=8, D=4)(		 // W = data path width; D = pointer width
  input           CLK,
                  reg_write_en,
                  acc_write_en,
  input  [D-1:0]  raddr_reg,
  input  [W-1:0]  data_in,
  output [W-1:0]  data_out_acc,
  output logic [W-1:0] data_out_reg
  );

// W bits wide [W-1:0] and 2**4 registers deep 	 
logic [W-1:0] registers[2**D];	    // or just registers[16] if we know D=4 always

// combinational reads w/ blanking of address 0
assign      data_out_acc = registers[15];
always_comb data_out_reg = registers[raddr_reg];               

// sequential (clocked) writes 
always_ff @ (posedge CLK) begin
  if(acc_write_en == 1'b1)
        registers[15] <= data_in;   // $accumulator
  else
  begin
    if(reg_write_en == 1'b1)
        registers[raddr_reg] <= data_in;
  end
end
endmodule