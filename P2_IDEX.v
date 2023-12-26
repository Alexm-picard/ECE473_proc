module P2_IDEX(
	input wire clock,
	input wire reset,
	input wire [6:0] funct7,
	input wire [2:0] funct3,
	input wire [2:0] type,
	input wire [31:0] rs1,
	input wire [31:0] rs2,
	input wire [4:0] rd,
	input wire stall,
	input wire [31:0] PC,
	input wire [6:0] opcode,
	output reg [6:0] funct7_out,
	output reg [2:0] funct3_out,
	output reg [2:0] type_out,
	output reg [31:0] rs1_out,
	output reg [31:0] rs2_out,
	output reg [4:0] rd_out,
	output reg [31:0] PC_out,
	output reg [6:0] opcode_out

);

	initial begin
		type_out <= 7;
	end

	always @(posedge clock) begin
		if (reset == 1'b1) begin
			funct7_out <= 0; //clear the register
			funct3_out <= 0;
			rs1_out <= 0;
			rs2_out <= 0;
			rd_out <= 0;
			type_out <= 7;//invalid type to make usr it ignores
			PC_out <= 0;
			opcode_out <= 0;
		end else begin
			if (stall ==0) begin//only move if not stalled
				funct7_out <= funct7;
				funct3_out <= funct3;
				rs1_out <= rs1;
				rs2_out <= rs2;
				rd_out <= rd;
				type_out <= type;
				PC_out <= PC;
				opcode_out <= opcode;
			end
		end
	end

endmodule