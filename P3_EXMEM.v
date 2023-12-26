module P3_EXMEM(
	input wire clock,
	input wire reset,
	input wire [2:0] type,
	input wire [31:0] rs1,
	input wire [31:0] rs2,
	input wire [4:0] rd,
	input wire [31:0] imm,
	input wire stall,
	input wire [31:0] store_mux,
	output reg [2:0] type_out,
	output reg [31:0] rs1_out,
	output reg [31:0] rs2_out,
	output reg [4:0] rd_out,
	output reg [31:0] imm_out,
	output reg [31:0] store

);

	initial begin
		type_out <= 7;
	end

	always @(posedge clock) begin
		if (reset == 1'b1) begin
			type_out <= 7;//invalid type to make sure it doesn't do anything
			rs1_out <= 0; //clear the register
			rs2_out <= 0;
			rd_out <= 0;
			imm_out <= 0;
			store <= 0;
		end else begin
			if (stall == 0) begin//only move if not stalled
				type_out <= type;
				rs1_out <= rs1;
				rs2_out <= rs2;
				rd_out <= rd;
				imm_out <= imm;
				store <= store_mux;
			end
		end
	end

endmodule