module word_to_byte_data(
	input wire [31:0] word_ALU,
	input wire [31:0] word_P3,
	input wire memEN,
	output reg [31:0] byte
	);
	
	always @* begin
		if (memEN) begin
			byte <= word_P3 >> 2;
		end else begin
			byte <= word_ALU >> 2;
		end
	end
	
endmodule