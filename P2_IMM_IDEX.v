module P2_IMM_IDEX(
	input wire clock,
	input wire reset,
	input wire [31:0] imm,
	input stall,
	output reg [31:0] imm_out

);

	always @(posedge clock) begin
		if (reset == 1'b1) begin
			imm_out <= 0;
		end else begin
			if (stall == 0) begin//only move if not stalled
				imm_out <= imm;
			end
		end
	end

endmodule