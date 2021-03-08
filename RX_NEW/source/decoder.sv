module decoder
(
	input wire clk,
	input wire n_rst, 
	input reg  Dplus,
//	input reg  Dminus,
	input reg shift_en,
	input reg EOP,
	output reg D_orig
);
   reg 		   D;
   reg 		   next_D;
   reg 	store;
   reg 	next_store;
   assign D_orig = !(D ^ store);
 //EOP: when both Dplus and Dminus both equal to 0, it's 1

   always_comb begin
      next_store = store;
      next_D = Dplus;
      if(shift_en & EOP) begin
	 next_store = 1'b1;
	 next_D = 1'b1;
      end
      else begin
	 if(shift_en == 1 && EOP == 0)begin
	 next_store=Dplus;
      end
   end // always_comb
   end // always_comb
   
   
   always_ff@(posedge clk, negedge n_rst) begin
      if(n_rst==1'b0) begin
	 store<=1;//sync_reset
	 D<=1;
      end
      else begin
	 store<=next_store;
	 D<=next_D;
      end
   end
endmodule
	
/*always_ff @ (posedge clk, negedge n_rst) begin
	if(n_rst==1'b0)
	begin
	   next_Dplus_sync<=1'b0;
	end
	else
	begin
	   next_Dplus_sync<=Dplus_sync;
	end
end

always_comb begin //EOP and Error
   if(Dplus_sync==0 && Dminus_sync==0) begin
      EOP=1'b1;
   end
   else if (Dplus_sync==1'b1 && Dminus_sync=1'b1) begin
      D_input_Error=1'b1;
      EOP=1'b0;
   end
   else begin
      D_input_Error=1'b0;
      EOP=1'b0;
   end
end // always_comb

always_comb begin
   if(Dplus_sync==next_Dplus_sync) begin
      D_orig_i=1'b1;
   end
   else begin
      D_orig_i=1'b0;
   end
end

endmodule*/
		

