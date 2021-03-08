// $Id: $
// File name:   flex_stp_sr.sv
// Created:     9/24/2018
// Author:      Tsung Lin Hsia
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: flex_stp_sr
module flex_stp_sr
#(
  parameter NUM_BITS=4,
  parameter SHIFT_MSB=1
)
(
  input wire clk,
  input wire n_rst,
  input wire shift_enable,
  input wire serial_in,
  output reg [(NUM_BITS-1):0] parallel_out
);

  reg [(NUM_BITS-1):0] nstate;

always_ff @ (posedge clk, negedge n_rst)
begin
	if(n_rst==0)
	begin
		parallel_out<='1;
	end
	else
	begin
		parallel_out<=nstate;
	end
end

always_comb
begin
	if(shift_enable==1)
	begin
		if(SHIFT_MSB==1)
		begin
			nstate={parallel_out[(NUM_BITS-2):0],serial_in};		
		end
		else
		begin
			nstate={serial_in, parallel_out[(NUM_BITS-1):1]};
		end
	end
	else
	begin
		nstate=parallel_out;
	end
end
endmodule

