module register(
	input wire [4:0] read_address_1,
	input wire [4:0] read_address_2,
	input wire [31:0] write_data_in,
	input wire [4:0] write_address,
	input wire WriteEnable,
	input wire reset,
	input wire clock,
	input wire [4:0] read_address_debug,
	input wire clock_debug,
	output reg [31:0] data_out_1,
	output reg [31:0] data_out_2,
	output reg [31:0] data_out_debug
	);
	
	reg [31:0] data [31:0]; //32 32 bit registers
	integer i;
	
	initial begin
		//for(i = 0; i < 32; i=i+1) begin//fill with the register counts register value
		//	data[i] = i;
		//end
		data[0] = 0;
		data[1] = 0;
		data[2] = 32'h7FFFEFFC;
		data[3] = 32'h10008000;
		for (i = 4; i<32; i=i+1) begin
			data[i] = 0;
		end
	end
	
	
	always @(negedge clock) begin

		if (reset == 1'b1) begin
			data[0] = 0;
			data[1] = 0;
			data[2] = 32'h7FFFEFFC;
			data[3] = 32'h10008000;
			for (i = 4; i<32; i=i+1) begin
				data[i] = 0;
			end
		end else if ((WriteEnable == 1'b1) && (write_address != 0)) begin
			data[write_address] <= write_data_in;
		end
	end
	
	always @* begin
		data_out_1 <= data[read_address_1];
		data_out_2 <= data[read_address_2];
	end
	
	always @(posedge clock_debug) begin
		data_out_debug <= data[read_address_debug]; 
	end
	
endmodule