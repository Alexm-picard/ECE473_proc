module PC_incr(
	input wire clock,
	input wire reset,
	input wire [31:0] in_addr,
	input wire stall,
	input wire PC_SEL,
	input wire [31:0] branch,
	input wire JALR_flag,
	input wire [31:0] rs1,
	output reg [31:0] out_addr
	);
	
	initial begin
		out_addr <= 0;
	end
	
	
	always @* begin
		if (reset == 1) begin
			out_addr <= 0;
		end else begin
			if (in_addr == 0) begin
				out_addr <= 32'h400000;
			end else if (PC_SEL == 0) begin
				if (stall == 0) begin//only move if not stalled
					out_addr <= in_addr + 4;//word accesible
				end else begin
					out_addr <= in_addr;
				end
			end else begin
				if (JALR_flag) begin//JALR needs special case
					out_addr <= rs1 + branch;
				end else begin
					out_addr <= in_addr + branch - 8;//convert to word access and account for 2 lost cycles
				end
			end
		end
	end
	
endmodule