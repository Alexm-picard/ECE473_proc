`include "riscv_defs.v"

module controller(
	input wire reset,
	input wire [1:0] stall,
	input wire [2:0] typeWB,
	input wire [2:0] typeMEM,
	input wire clk,
	input wire zero_flag,
	input wire [2:0] typeEX,
	input wire [2:0] funct3_EX,
	input wire GE_flag,
	input wire LT_flag,
	input wire [6:0] opcode_EX,
	output reg stall_PC,
	output reg stall_P1,
	output reg stall_P2,
	output reg stall_P3,
	output reg stall_P4,
	output reg regEN,
	output reg memEN,
	output reg flushP1,
	output reg flushP2,
	output reg flushP3,
	output reg flushP4,
	output reg load_SEL,
	output reg PC_SEL,
	output reg JALR_flag
	
	// controlls regiter file write mem write
	// flushes pipeline registers
	// stall
	
);	

	always @* begin
		if (reset == 1) begin//reset everything
			flushP1 <= 1;
			flushP2 <= 1;
			flushP3 <= 1;
			flushP4 <= 1;
		end else begin
			flushP1 <= 0;
			flushP4 <= 0;
			if (typeEX == `B_TYPE) begin
				if ((zero_flag == 1) && (funct3_EX == `BEQ)) begin//BEQ
					PC_SEL <= 1;
					flushP1 <= 1;
					flushP2 <= 1;
					flushP3 <= 1;
				end else if ((GE_flag == 1) && (funct3_EX == `BGE))begin//BGE
					PC_SEL <= 1;
					flushP1 <= 1;
					flushP2 <= 1;
					flushP3 <= 1;
				end else if ((LT_flag == 1) && (funct3_EX == `BLT)) begin//BLT
					PC_SEL <= 1;
					flushP1 <= 1;
					flushP2 <= 1;
					flushP3 <= 1;
				end else if ((zero_flag == 0) && (funct3_EX == `BNE)) begin//BNE
					PC_SEL <= 1;
					flushP1 <= 1;
					flushP2 <= 1;
					flushP3 <= 1;
				end else begin
					PC_SEL <= 0;
					flushP1 <= 0;
					flushP2 <= 0;
					flushP3 <= 0;
				end
			end else if (typeEX == `J_TYPE) begin//only handles JAL
				if (opcode_EX == `JALR) begin
					JALR_flag <= 1;
				end else begin
					JALR_flag <= 0;
				end
				PC_SEL <= 1;
				flushP1 <= 1;
				flushP2 <= 1;
				flushP3 <= 0;
			end else begin
				PC_SEL <= 0;
				if (stall == 2'h1) begin
					stall_PC <= 1;
					stall_P1 <= 1;
					stall_P2 <= 1;
					stall_P3 <= 0;
					stall_P4 <= 0;
					flushP2 <= 1;
					flushP3 <= 0;//all other states reset flush
				end else if (stall == 2'h2) begin
					stall_PC <= 1;
					stall_P1 <= 1;
					stall_P2 <= 1;
					stall_P3 <= 1;
					stall_P4 <= 0;
					flushP2 <= 0;
					flushP3 <= 1;
				end else begin
					stall_PC <= 0;
					stall_P1 <= 0;
					stall_P2 <= 0;
					stall_P3 <= 0;
					stall_P4 <= 0;
					flushP1 <= 0;
					flushP2 <= 0;//all other states reset flush
					flushP3 <= 0;
				end
			end //BEQ
			
			if ((typeWB == `L_TYPE) || (typeWB == `R_TYPE) || (typeWB == `I_TYPE) || (typeWB == `U_TYPE) || (typeWB == `J_TYPE)) begin
				regEN <= 1;
			end else begin
				regEN <= 0;
			end
			
			if (typeMEM == `L_TYPE) begin//load from MEM
				load_SEL <= 0;
			end else begin 
				load_SEL <= 1;
			end
			
			if (typeMEM == `S_TYPE) begin //if WB is needed enable
				memEN <= 1;
			end else begin
				memEN <= 0;
			end
		end
		
	end
	
	

	
	
endmodule