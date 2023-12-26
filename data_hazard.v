module data_hazard(
	input wire [4:0] P1_rs1,
	input wire [4:0] P1_rs2,
	input wire [4:0] P2_rd,
	input wire [4:0] P3_rd,
	output reg [1:0] stall);
	always @* begin
		if ((P1_rs1 == 0) && (P1_rs2 == 0)) begin
			stall <= 0;
		end else if (P1_rs1 == 0) begin //rs1 cant be a problem if it is zero
			if (P1_rs2 == P2_rd) begin
				stall <= 2'h1;
			end else if (P1_rs2 == P3_rd) begin
				stall <= 2'h2;
			end else begin
				stall <= 2'h0;
			end
		end else if (P1_rs2 == 0) begin
			if (P1_rs1 == P2_rd) begin
				stall <= 2'h1;
			end else if (P1_rs1 == P3_rd) begin
				stall <= 2'h2;
			end else begin
				stall <= 2'h0;
			end
		end else begin
			if ((P1_rs1 == P2_rd) || (P1_rs2 == P2_rd)) begin//hazard is in pipeline 2
				stall <= 2'h1;
			end else if ((P1_rs1 == P3_rd) || (P1_rs2 == P3_rd)) begin//hazard is in pipeline 3
				stall <= 2'h2;
			end else begin
				stall <= 0;
			end
		end

	end
endmodule