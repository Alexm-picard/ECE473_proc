module word_to_byte(
	input wire [31:0] word,
	output reg [31:0] byte
	);
	
	always @* begin
		byte <= word >> 2;
	end
	
endmodule