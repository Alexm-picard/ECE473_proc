`include "riscv_defs.v"

module ALU(
	input wire [6:0] funct7,
	input wire [2:0] funct3,
	input wire [2:0] type,
	input wire [31:0] rs1,
	input wire [31:0] rs2,
	input wire [31:0] imm,
	input wire [31:0] PC,
	input wire [6:0] opcode,
	output reg [31:0] out,
	output reg zero_flag,
	output reg GE_flag,
	output reg LT_flag
);
	wire [31:0] temp_beq;

	assign temp_beq = rs1 - rs2;//for beq
	

	always @* begin
		case(type)
			`R_TYPE: begin
				case({funct7,funct3})
					`ADD: begin
						out <= rs1 + rs2;
					end
					`SUB: begin
						out <= rs1 - rs2;
					end
					`XOR: begin
						out <= rs1 ^ rs2;
					end
					`OR: begin
						out <= rs1 | rs2;
					end
					`AND: begin
						out <= rs1 & rs2;
					end
					`SLL: begin
						out <= rs1 << rs2;
					end
					`SRL: begin
						out <= rs1 >> rs2;
					end
					`SRA: begin //MSB extends
						if (rs1[31] == 1) begin
							out <= (rs1 >> rs2) | (32'hFFFFFFFF << (8'd32 - rs2));
						end else begin
							out <=rs1 >> rs2;
						end
					end
					`SLT: begin
						if (rs1 < rs2) begin
							out <= {32'h1};
						end else begin
							out <= {32'h0};
						end
					end
					`SLTU: begin
						if (rs1 < rs2) begin
							out <= {31'h0,1'b1};
						end else begin
							out <= {32'h0};
						end
					end
				endcase
			end
			`I_TYPE: begin
				case(funct3)
					`ADDI: begin
						out <= rs1 + imm;
					end
					`XORI: begin
						out <= rs1 ^ imm;
					end
					`ORI: begin
						out <= rs1 | imm;
					end
					`ANDI: begin
						out <= rs1 & imm;
					end
					`SLLI: begin
						out <= rs1 << imm[4:0];
					end
					`SRI: begin
						if (imm[11:5] == 7'h20) begin//SRAI
							if (rs1[31] == 1) begin
								out <= (rs1 >> imm[4:0]) | (32'hFFFFFFFF << (8'd32 - imm[4:0]));
							end else begin
								out <=rs1 >> imm[4:0];
							end
						end else begin//SRLI
							out <= rs1 >> imm[4:0];
						end
					end
					`SLTI: begin
						if (rs1 < imm) begin
							out <= {32'h1};
						end else begin
							out <= {32'h0};
						end
					end
					`SLTIU: begin
						if (rs1 < imm) begin
							out <= {32'h1};
						end else begin
							out <= {32'h0};
						end
					end
				endcase
			end
			`S_TYPE: begin//We only support SW because of word accessible mem
				out <= rs1 + imm;
			end
			
			`L_TYPE: begin//address calculation doesn't change
				out <= rs1 +imm;
			end
				
			`B_TYPE: begin
				if (temp_beq == 0) begin//BEQ
					zero_flag <= 1;
				end else begin
					zero_flag <= 0;
				end
				if (rs1 >= rs2) begin//BGE
					GE_flag <= 1;
				end else begin
					GE_flag <= 0;
				end
				if (rs1 < rs2) begin //BLT
					LT_flag <= 1;
				end else begin
					LT_flag <= 0;
				end
			end
			`J_TYPE: begin
				out <= PC; //there is an offset of 4 already
			end
			`U_TYPE: begin
				if (opcode == 7'b0110111) begin //lui
					out <= imm << 12;
				end else begin//auipc
					out <= PC + (imm << 12) - 4;
				end
			end
		endcase		
	end

endmodule