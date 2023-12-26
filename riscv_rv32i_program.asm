	.data	# Data Section
aArray:	.word 1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 
	      4096, 8192, 16384, 32768, 65536, 131072, 262144, 524288, 
	      1048576, 2097152, 4194304, 8388608, 16777216, 33554432, 67108864, 
	      134217728, 268435456, 536870912, 1073741824, 2147483648, 
aSize:   .word 32 

bArray:  .word 0xDEADBEEF, 0xBAADF00D, 0xBADDCAFE, 0xFACEFEED, 0xFEEDBABE, 0xF00DBABE, 0xBAAAAAAD, 0xFEEDC0DE
bSize:   .word 8 

cArray:	 .word 13, 6, 5, 10, 15, 19, 21, 17, 14, 3, 12, 18, 7, 4, 11, 20, 22, 23, 24, 2, 1, 8, 16, 9, 
cSize:   .word 24 

	.text	# Code Section
main:
	# RV32I Base Integer Instructions
	add t1, t2, t3
	sub t1, t2, t3 
	xor t1, t2, t3
	or  t1, t2, t3
	and t1, t2, t3
	sll t1, t2, t3
	srl t1, t2, t3
	sra t1, t2, t3
	slt t1, t2, t3
	sltu t1, t2, t3
	
	addi t1, t2, -100
	xori t1, t2, -100
	ori  t1, t2, -100
	andi t1, t2, -100
	slli t1, t2, 10 
	srli t1, t2, 10
	srli t1, t2, 10
	srai t1, t2, 10
	slti t1, t2, -100
	sltiu t1, t2, 10

	la t2, cArray		
	lb t1, -32(t2)
	lh t1, -32(t2)
	lw t1, -32(t2)
	lbu t1, -32(t2)
	lhu t1, -32(t2)

	sb t1, -64(t2)
	sh t1, -64(t2)
	sw t1, -64(t2)

	beq t1, t2, exit
	bne t1, t2, exit
	blt t1, t2, exit
	bge t1, t2, exit
	bltu t1, t2, exit
	bgeu t1, t2, exit

	jal t1, exit
	jalr t1, t2, -100

	lui t1, 100000
	auipc t1, 100000
	
exit:	beq zero, zero, exit	# program stops here		
