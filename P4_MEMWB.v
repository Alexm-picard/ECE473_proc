module P4_MEMWB(
	input wire clock,
	input wire reset,
	input wire [2:0] type,
	input wire [31:0] rs2,
	input wire [4:0] rd,
	input wire stall,
	output reg [2:0] type_out,
	output reg [31:0] rs2_out,
	output reg [4:0] rd_out

);

	initial begin
		type_out <= 7;
	end

	always @(posedge clock) begin
		if (reset == 1'b1) begin//clear the registers
			rs2_out <= 0;
			rd_out <= 0;
			type_out <= 7;//set to an invalid type so it doesn't initiate a WB
		end else begin
			if (stall == 0) begin//only move if not stalled
				rs2_out <= rs2;
				rd_out <= rd;
				type_out <= type;
			end
		end
	end

endmodule