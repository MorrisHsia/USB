module Detector
(
 input wire clk,
 input wire n_rst,
 input reg  Dplus,
 input reg Dminus,
 output reg EOP,
 output reg Edge
);
   reg 	    pre_Dplus;
   reg 	    next_edge;
   
assign EOP = (!(Dplus|Dminus))?1'b1:1'b0;
   
always_ff @(posedge clk, negedge n_rst) begin
   if(n_rst==1'b0) begin
      pre_Dplus<=1'b1;
      Edge<=1'b0;
   end
   else begin
      pre_Dplus<=Dplus;
      Edge<=next_edge;
   end
end
   
always_comb begin
      if(pre_Dplus!=Dplus) begin
	 next_edge=1;
      end
      else begin
	 next_edge=0;
      end
end

endmodule
