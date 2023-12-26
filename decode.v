`include "riscv_defs.v"

module decode(
	input wire clock,
	input wire [31:0] instr,
	output reg [6:0] funct7,
	output reg [2:0] funct3,
	output reg [2:0] type,
	output reg [4:0] rs1,
	output reg [4:0] rs2,
	output reg [4:0] rd,
	output reg [31:0] imm,
	output reg [6:0] opcode
);

	reg[4:0] rs1_next;
	reg[4:0] rs2_next;
	reg[4:0] rd_next;
	reg[31:0] imm_next;
	reg[2:0] type_next;
	
	initial begin
		type_next = 7;
		type = 7;
	end


	always @* begin//update the outputs
		funct7 <= instr[31:25];
		funct3 <= instr[14:12];
		rs1 <= rs1_next;
		rs2 <= rs2_next;
		imm <= imm_next;
		type <= type_next;

	end
	
	always @* begin //determine the type and assign the rs1,rs2,rd,imm next values
		opcode <= instr[6:0];
		rd <= instr[11:7];
		case(instr[6:0])
			`INST_R_MASK: begin //R-Type
				type_next <= `R_TYPE;
				rs1_next <= instr[19:15];
				rs2_next <= instr[24:20];
			end
				
			`INST_I_MASK: begin //I-Type
				type_next <= `I_TYPE;
				rs1_next <= instr[19:15];
				if (instr[31] == 1) begin//sign extension negative
					imm_next <= {20'hFFFFF,instr[31:20]};
				end else begin//positive
					imm_next <= {20'h0,instr[31:20]};
				end
			end
			`INST_S_MASK: begin //S-Type
				type_next <= `S_TYPE;
				rs1_next <= instr[19:15];
				rs2_next <= instr[24:20];
				imm_next <= {instr[31:25], instr[11:7]};
			end
			
			`INST_L_MASK: begin //L-Type
				type_next <= `L_TYPE;
				rs1_next <= instr[19:15];
				imm_next <= instr[31:20];
			end
			
			`INST_B_MASK: begin //B-Type
				type_next <= `B_TYPE;
				rs1_next <= instr[19:15];
				rs2_next <= instr[24:20];
				if (instr[31] == 1) begin//sign extension negative
					imm_next <= {20'hFFFFF,instr[31],instr[7],instr[30:25],instr[11:8],1'b0};
				end else begin//positive
					imm_next <= {20'h0,instr[31],instr[7],instr[30:25],instr[11:8],1'b0};
				end
			end
			
			`INST_JAL_MASK: begin //J-Type
				type_next <= `J_TYPE;
				if (instr[31] == 1) begin
					imm_next <= {11'h7FF,instr[31],instr[19:12],instr[20],instr[30:21],1'h0};
				end else begin
					imm_next <= {11'h0,instr[31],instr[19:12],instr[20],instr[30:21],1'h0};
				end
			end
			
			`INST_JALR_MASK: begin //J-Type
				type_next <= `J_TYPE;
				rs1_next <= instr[19:15];
				if (instr[31] == 1) begin//sign extension negative
					imm_next <= {20'hFFFFF,instr[31:20]};
				end else begin//positive
					imm_next <= {20'h0,instr[31:20]};
				end
			end
			
			`INST_LUI_MASK: begin //LUI-Type
				type_next <= `U_TYPE;
				imm_next <= instr[31:12];
			end
			`INST_AUIPC_MASK: begin //AUIPC-Type
				type_next <= `U_TYPE;
				imm_next <= instr[31:12];
			end
			default: begin
				type_next <= 7;
			end
		endcase
		
		end
		


endmodule