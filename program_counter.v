module program_counter(
	input wire clock,
	input wire reset,
	input wire [31:0] in_addr,
	input wire stall,
	output reg [31:0] instr_addr
	);
	
	initial begin
		instr_addr <= 0;
	end
	
	
	always @(negedge clock) begin
		if (reset == 1'b1) begin
			instr_addr <= 0;
		end else begin
			if (stall == 0) begin
				instr_addr <= in_addr;
			end
		end
	end
	
endmodule